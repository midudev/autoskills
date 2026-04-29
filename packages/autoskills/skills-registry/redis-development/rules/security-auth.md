---
title: Always Use Authentication in Production
impact: HIGH
impactDescription: Prevents unauthorized access to your data
tags: security, authentication, password, tls, ssl
description: Always Use Authentication in Production
alwaysApply: true
---

## Always Use Authentication in Production

Never run Redis without authentication in production environments.

**Correct:** Use password and TLS.

**Python** (redis-py):
```python
r = redis.Redis(
    host='localhost',
    port=6379,
    password='your-strong-password',
    ssl=True,
    ssl_cert_reqs='required'
)
```

**Java** (Jedis):
```java
import redis.clients.jedis.*;
import javax.net.ssl.*;
import java.security.KeyStore;

// Create SSL context with trust store and key store
KeyStore trustStore = KeyStore.getInstance("jks");
trustStore.load(new FileInputStream("./truststore.jks"), "password".toCharArray());

TrustManagerFactory tmf = TrustManagerFactory.getInstance("X509");
tmf.init(trustStore);

SSLContext sslContext = SSLContext.getInstance("TLS");
sslContext.init(null, tmf.getTrustManagers(), null);

JedisClientConfig config = DefaultJedisClientConfig.builder()
    .ssl(true)
    .sslSocketFactory(sslContext.getSocketFactory())
    .user("redisUser")
    .password("redisPassword")
    .build();

JedisPooled jedis = new JedisPooled(new HostAndPort("redis-host", 6379), config);
```

**Incorrect:** Connecting without authentication.

**Python** (redis-py):
```python
# Bad: No authentication
r = redis.Redis(host='localhost', port=6379)
```

**Java** (Jedis):
```java
// Bad: No authentication or TLS
UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379");
```

**Configuration:**

```
# redis.conf
requirepass your-strong-password
tls-port 6380
tls-cert-file /path/to/redis.crt
tls-key-file /path/to/redis.key
```

Reference: [Redis Security](https://redis.io/docs/latest/operate/oss_and_stack/management/security/)

