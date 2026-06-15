# Cryptography Security Rules

Cryptography vulnerabilities threaten confidentiality and integrity of sensitive data.

**Rules:**

1. TLS MUST use 1.2+.
2. NEVER use DES, RC4, MD5, or SHA1 for security purposes.
3. SSH host keys MUST be verified — NEVER use `InsecureIgnoreHostKey`.
4. Passwords MUST be hashed with Argon2id (preferred) or bcrypt.
5. Security-critical randomness MUST use `crypto/rand`.

---

## Algorithm Selection Guide

Choose the right algorithm for the job — using the wrong primitive (e.g. SHA256 for passwords) is as dangerous as using a broken one:

| Use Case | Recommended | Avoid | Why |
| --- | --- | --- | --- |
| Symmetric encryption | AES-256-GCM, ChaCha20-Poly1305 | DES, 3DES, AES-ECB, RC4 | ECB reveals patterns; DES/RC4 are broken |
| Password hashing | Argon2id (preferred), bcrypt, scrypt | MD5, SHA-1, plain SHA-256 | Fast hashes enable brute-force; memory-hard functions resist GPU attacks |
| Message authentication | HMAC-SHA256, Poly1305 | HMAC-MD5, HMAC-SHA1 | MD5/SHA1 have known collision weaknesses |
| Digital signatures | Ed25519, ECDSA P-256 | RSA-PKCS1v1.5 | PKCS1v1.5 has padding oracle vulnerabilities |
| Key exchange | X25519, ECDH P-256 | Static RSA key transport | Forward secrecy requires ephemeral keys |
| Random generation | `crypto/rand` | `math/rand` | `math/rand` output is predictable |
| TLS | TLS 1.2+ (prefer 1.3) | TLS 1.0, 1.1, SSL | Known attacks (BEAST, POODLE) on older versions |

### Key Size Requirements

| Algorithm | Minimum Key Size         | Recommended      |
| --------- | ------------------------ | ---------------- |
| RSA       | 2048 bits                | 4096 bits        |
| AES       | 128 bits                 | 256 bits         |
| ECDSA     | P-256 (128-bit security) | P-256 or Ed25519 |

---

## Key Rotation Pattern

Keys should be rotated periodically. Use envelope encryption so rotating the Key Encryption Key (KEK) doesn't require re-encrypting all data:

```go
// Envelope encryption: encrypt data with a DEK, encrypt DEK with KEK
func EnvelopeEncrypt(kek, plaintext []byte) (encryptedDEK, ciphertext []byte, err error) {
    // 1. Generate random Data Encryption Key
    dek := make([]byte, 32)
    if _, err := rand.Read(dek); err != nil {
        return nil, nil, err
    }

    // 2. Encrypt data with DEK
    ciphertext, err = EncryptAESGCM(dek, plaintext)
    if err != nil {
        return nil, nil, err
    }

    // 3. Encrypt DEK with KEK
    encryptedDEK, err = EncryptAESGCM(kek, dek)
    if err != nil {
        return nil, nil, err
    }

    return encryptedDEK, ciphertext, nil
}

func EnvelopeDecrypt(kek, encryptedDEK, ciphertext []byte) ([]byte, error) {
    dek, err := DecryptAESGCM(kek, encryptedDEK)
    if err != nil {
        return nil, err
    }
    return DecryptAESGCM(dek, ciphertext)
}

func EncryptAESGCM(key, plaintext []byte) ([]byte, error) {
    block, err := aes.NewCipher(key)
    if err != nil { return nil, err }
    aead, err := cipher.NewGCM(block)
    if err != nil { return nil, err }
    nonce := make([]byte, aead.NonceSize())
    if _, err := rand.Read(nonce); err != nil { return nil, err }
    return aead.Seal(nonce, nonce, plaintext, nil), nil
}

func DecryptAESGCM(key, ciphertext []byte) ([]byte, error) {
    block, err := aes.NewCipher(key)
    if err != nil { return nil, err }
    aead, err := cipher.NewGCM(block)
    if err != nil { return nil, err }
    nonceSize := aead.NonceSize()
    if len(ciphertext) < nonceSize {
        return nil, errors.New("ciphertext too short")
    }
    return aead.Open(nil, ciphertext[:nonceSize], ciphertext[nonceSize:], nil)
}
```

When the KEK is rotated, only re-encrypt the DEKs (small), not the data (potentially large).

---

## Common Cryptographic Mistakes

### Mistake 1: AES-ECB reveals patterns — High

ECB encrypts each block independently — identical plaintext blocks produce identical ciphertext blocks, revealing data structure:

```go
// Bad — ECB mode reveals patterns in structured data
block, _ := aes.NewCipher(key)
// Using block.Encrypt directly = ECB mode

// Good — GCM provides authenticated encryption
aead, err := cipher.NewGCM(block) // randomized, authenticated
if err != nil {
    return nil, err
}
nonce := make([]byte, aead.NonceSize())
if _, err := rand.Read(nonce); err != nil {
    return nil, err
}
ciphertext := aead.Seal(nonce, nonce, plaintext, nil)
```

### Mistake 2: Reusing nonces — Critical

A nonce reuse with AES-GCM completely breaks confidentiality and authentication:

```go
// Bad — static or reused nonce
nonce := []byte("fixed_nonce!") // catastrophic with GCM

// Good — random nonce per encryption
nonce := make([]byte, 12) // 96-bit for GCM
if _, err := rand.Read(nonce); err != nil {
    return nil, err
}
```

### Mistake 3: Non-constant-time comparison for secrets — Medium

Comparing secrets with `==` short-circuits on the first differing byte, leaking timing information. See [Network/Web Security — Observable Timing](./network.md) for constant-time comparison patterns using `crypto/subtle`.

---

## Insecure TLS Configuration — High

Using insecure TLS configurations can expose your application to man-in-the-middle attacks.

**Bad:**

```go
transport := &http.Transport{
    TLSClientConfig: &tls.Config{
        InsecureSkipVerify: true, // DON'T: verify certificates
    },
}
```

**Good:**

```go
import "crypto/tls"

func secureConfig() *tls.Config {
    return &tls.Config{
        MinVersion:       tls.VersionTLS12,
        CurvePreferences: []tls.CurveID{tls.X25519, tls.CurveP256},
    }
}
```

---

## DES Encryption — High

DES is cryptographically broken.

**Bad:**

```go
import "crypto/des"
block, _ := des.NewCipher(key) // DON'T: broken
```

**Good:**

```go
import "crypto/aes"
block, _ := aes.NewCipher(key)     // OK: AES
cipher.NewGCM(block)              // OK: GCM for auth
```

---

## Insecure SSH Host Key Verification — High

**Bad:**

```go
import "golang.org/x/crypto/ssh"
&ssh.ClientConfig{
    HostKeyCallback: ssh.InsecureIgnoreHostKey(), // DON'T
}
```

**Good:**

```go
import "golang.org/x/crypto/ssh"
&ssh.ClientConfig{
    HostKeyCallback: ssh.FixedHostKey(publicKey),
}
```

---

## MD5 Hash — High

MD5 is collision-prone and weak for security.

**Bad:**

```go
import "crypto/md5"
hash := md5.Sum([]byte(data)) // DON'T: weak
```

**Good:**

```go
// For password hashing:
import "golang.org/x/crypto/argon2"
hash := argon2.IDKey([]byte(pw), salt, 3, 64*1024, 4, 32)

// Or bcrypt (simpler API, no salt management):
import "golang.org/x/crypto/bcrypt"
hash, err := bcrypt.GenerateFromPassword([]byte(pw), bcrypt.DefaultCost)
if err != nil {
    return nil, err
}

// For general-purpose hashing (not passwords):
import "crypto/sha256"
digest := sha256.Sum256(data)
```

---

## RC4 Cipher — High

RC4 is cryptographically broken.

**Bad:**

```go
import "crypto/rc4"
cipher, _ := rc4.NewCipher(key) // DON'T: broken
```

**Good:**

```go
import "crypto/cipher"
import "crypto/aes"
aead, _ := cipher.NewGCM(block) // OK: AES-GCM

// Or ChaCha20:
import "golang.org/x/crypto/chacha20poly1305"
aead, _ := chacha20poly1305.New(key)
```

---

## SHA1 Hash — Medium

SHA1 provides insufficient collision resistance.

**Bad:**

```go
import "crypto/sha1"
hash := sha1.Sum(data) // DON'T: weak
```

**Good:**

```go
import "crypto/sha256"
hash := sha256.Sum256(data)
```

---

## Weak Cryptographic Algorithms — Medium

**Bad:**

```go
import "crypto/hmac"
import "crypto/md5"
mac := hmac.New(md5.New, key) // DON'T: HMAC-MD5
```

**Good:**

```go
import "crypto/sha256"
mac := hmac.New(sha256.New, key)
```

---

## Insufficient Key Strength — Medium

RSA keys smaller than 2048 bits are insufficient.

**Bad:**

```go
import "crypto/rsa"
key, _ := rsa.GenerateKey(rand.Reader, 1024) // DON'T: too weak
```

**Good:**

```go
key, _ := rsa.GenerateKey(rand.Reader, 4096) // OK: 2048+ bits
```

---

## Weak Random Number Generators — High

`math/rand` is predictable, never use for security.

**Bad:**

```go
import "math/rand"
bytes := make([]byte, 16)
rand.Read(bytes) // DON'T: predictable
```

**Good:**

```go
import "crypto/rand"
_, err := rand.Read(bytes) // OK: cryptographically secure
```

---

## Weak TLS Versions — High

TLS 1.0 and 1.1 have known vulnerabilities.

**Bad:**

```go
import "crypto/tls"
&tls.Config{MinVersion: tls.VersionTLS10} // DON'T
```

**Good:**

```go
&tls.Config{MinVersion: tls.VersionTLS12} // OK
```

---

## Password Hashing — High

Don't use MD5, SHA1, or single-iteration hashes for passwords.

**Bad:**

```go
import "crypto/sha256"
hash := sha256.Sum256([]byte(password)) // DON'T: too fast
```

**Good:**

```go
// Argon2id (preferred) — memory-hard, resists GPU attacks:
import "golang.org/x/crypto/argon2"
key := argon2.IDKey([]byte(password), salt, 3, 64*1024, 4, 32)

// Or bcrypt (simpler API, widely supported):
import "golang.org/x/crypto/bcrypt"
hash, err := bcrypt.GenerateFromPassword([]byte(pw), bcrypt.DefaultCost)
if err != nil {
    return nil, err
}

// Or PBKDF2 with 600,000+ iterations (Go 1.24+ stdlib):
import "crypto/pbkdf2"
key, err := pbkdf2.Key(sha512.New, password, salt, 600_000, 32)
if err != nil {
    return err
}

// Or scrypt:
import "golang.org/x/crypto/scrypt"
key, err := scrypt.Key([]byte(password), salt, 32768, 8, 1, 32)
if err != nil {
    return err
}
```

For Go 1.24+, prefer stdlib `crypto/hkdf`, `crypto/pbkdf2`, and `crypto/sha3`. Use `golang.org/x/crypto/...` fallbacks only for modules targeting older Go versions or for algorithms still outside the standard library.

---

## CWE References

- **CWE-327**: Use of a Broken or Risky Cryptographic Algorithm
- **CWE-331**: Insufficient Entropy
- **CWE-326**: Inadequate Encryption Strength
- **CWE-295**: Improper Certificate Validation
- **CWE-330**: Use of Insufficiently Random Values
- **CWE-916**: Use of Password Hash With Insufficient Computational Effort
