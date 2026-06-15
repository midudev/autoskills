# Filesystem Security Rules

Filesystem vulnerabilities can lead to unauthorized file access, data leakage, and denial-of-service attacks.

**Rules:**

1. User-controlled file paths MUST be confined to an allowed root.
2. `os.Root` SHOULD be used for scoped file access (Go 1.24+).
3. Zip extraction MUST check for ZipSlip path traversal.
4. Temporary files MUST use `os.CreateTemp` — NEVER predictable names.
5. File permissions MUST be restrictive (0600 for secrets, 0750 for directories).

---

## Directory Traversal — High

Paths like `../../etc/passwd` access files outside intended directory.

**Bad:**

```go
filepath := filepath.Join("/var/www", filename) // DON'T
http.ServeFile(w, r, filepath)
```

**Good (Go 1.24+) — use `os.Root` for safe, scoped directory access:**

```go
root, err := os.OpenRoot("/var/www")
if err != nil { return err }
defer root.Close()
f, err := root.Open(filename) // cannot escape root directory
```

`os.Root` prevents ordinary path traversal at the OS level. All operations (`Open`, `Create`, `Stat`, `OpenFile`, etc.) are confined to the root directory, and symlinks that resolve outside the root are rejected. It is not a full sandbox: it does not by itself block bind mounts, special device files, or all `/proc`-style filesystem behavior. For archive extraction and uploads, still reject special files and choose a root without attacker-controlled mounts.

**Good (pre-Go 1.24 fallback):**

```go
func safeJoin(baseDir, userPath string) (string, error) {
    if userPath == "" || filepath.IsAbs(userPath) || !filepath.IsLocal(userPath) {
        return "", errors.New("invalid relative path")
    }

    full := filepath.Join(baseDir, userPath)

    rel, err := filepath.Rel(baseDir, full)
    if err != nil {
        return "", fmt.Errorf("checking path: %w", err)
    }
    if rel == ".." || strings.HasPrefix(rel, ".."+string(os.PathSeparator)) {
        return "", errors.New("path escapes base directory")
    }

    return full, nil
}
```

This lexical fallback is not a full symlink-resistant substitute for `os.Root`.

**Bad:**

```go
fullPath := filepath.Join(baseDir, filename)
if !strings.HasPrefix(filepath.Clean(fullPath), filepath.Clean(baseDir)) {
    return errors.New("access denied")
}
```

---

## Zip Archive Path Traversal — High

Malicious zip files can escape extraction directory.

**Bad:**

```go
for _, file := range reader.File {
    path := filepath.Join(dest, file.Name) // DON'T: No validation
    file.Create(path)
}
```

**Good (Go 1.24+) — use `os.Root` to scope extraction:**

```go
root, err := os.OpenRoot(dest)
if err != nil { return err }
defer root.Close()
for _, file := range reader.File {
    f, err := root.OpenFile(file.Name, os.O_CREATE|os.O_WRONLY, 0644)
    if err != nil { return err } // rejects paths escaping root
    // ... copy contents ...
    f.Close()
}
```

**Good (pre-Go 1.24 fallback):**

```go
for _, file := range reader.File {
    if !filepath.IsLocal(file.Name) {
        return fmt.Errorf("unsafe archive path: %q", file.Name)
    }

    targetPath, err := safeJoin(dest, file.Name)
    if err != nil {
        return err
    }

    // create parent directories, then write targetPath
    _ = targetPath
}
```

---

## Decompression Bomb — Medium

Tiny compressed files can expand to GBs.

**Bad:**

```go
gr, _ := gzip.NewReader(f)
out, _ := os.Create(dst)
io.Copy(out, gr) // DON'T: No size limits
```

**Good:**

```go
const maxDecompressedSize = 100 * 1024 * 1024 // 100MB limit

var errDecompressedSizeLimitExceeded = errors.New("decompressed size limit exceeded")

type limitedReader struct {
    r    io.Reader
    read int64
}

func (l *limitedReader) Read(p []byte) (int, error) {
    if l.read >= maxDecompressedSize {
        // Return a sentinel error — io.EOF would be treated as success by io.Copy
        return 0, errDecompressedSizeLimitExceeded
    }
    n, err := l.r.Read(p)
    l.read += int64(n)
    return n, err
}

lr := &limitedReader{r: gr}
if _, err := io.Copy(out, lr); err != nil {
    return fmt.Errorf("decompressing: %w", err)
}
```

---

## Insecure Temporary File Creation — Medium

Creating temp files without proper permissions.

**Bad:**

```go
f, _ := os.Create("/tmp/myapp.temp") // DON'T: Predictable name
f.WriteString(data)
```

**Good:**

```go
f, err := os.CreateTemp("", "myapp.*")
defer os.Remove(f.Name())
f.Chmod(0600) // Restrictive permissions
```

---

## Insecure File Permissions — Medium

Opening files with excessive permissions.

**Bad:**

```go
f, _ := os.OpenFile("config.json", os.O_CREATE, 0644) // DON'T: World-readable
```

**Good:**

```go
f, _ := os.OpenFile("config.json", os.O_CREATE, 0600) // OK: Owner only
```

---

## Insecure mkdir — Low

Creating directories with overly permissive permissions.

**Bad:**

```go
os.MkdirAll("/var/myapp/cache", 0777) // DON'T: World-writable
```

**Good:**

```go
os.MkdirAll("/var/myapp/cache", 0750) // OK: Group-writable
```

---

## Insecure File Write Permissions — Medium

Opening files for writing with inappropriate permissions.

**Bad:**

```go
os.OpenFile("app.log", os.O_CREATE, 0666) // DON'T: World-writable
```

**Good:**

```go
os.OpenFile("app.log", os.O_CREATE|os.O_APPEND, 0640) // OK
```

---

## Tainted File Read — High

Reading files based on unvalidated input.

**Bad:**

```go
func readFile(filename string) ([]byte, error) {
    return os.ReadFile(filename) // DON'T: No validation
}
```

**Good (Go 1.24+):**

```go
const allowedDir = "/var/www/public/"

func readFile(filename string) ([]byte, error) {
    root, err := os.OpenRoot(allowedDir)
    if err != nil { return nil, err }
    defer root.Close()
    f, err := root.Open(filename) // cannot escape root directory
    if err != nil { return nil, err }
    defer f.Close()
    return io.ReadAll(f)
}
```

**Good (pre-Go 1.24 fallback):**

```go
const allowedDir = "/var/www/public/"

func readFile(filename string) ([]byte, error) {
    fullPath, err := safeJoin(allowedDir, filename)
    if err != nil {
        return nil, err
    }
    return os.ReadFile(fullPath)
}
```

---

## CWE References

- **CWE-22**: Path Traversal (Directory Traversal)
- **CWE-409**: Zip Bomb Decompression
- **CWE-379**: Insecure Temp File Creation
- **CWE-732**: Incorrect File Permissions
