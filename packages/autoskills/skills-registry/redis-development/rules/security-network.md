---
title: Secure Network Access
impact: HIGH
impactDescription: Reduces attack surface and prevents unauthorized access
tags: security, network, firewall, bind, tls
description: Secure Network Access
alwaysApply: true
---

## Secure Network Access

Restrict network access to Redis to only trusted sources.

**Correct:** Bind to specific interfaces.

```
# redis.conf
bind 127.0.0.1 192.168.1.100
protected-mode yes
```

**Correct:** Use firewall rules.

```bash
# Allow only application servers
iptables -A INPUT -p tcp --dport 6379 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 6379 -j DROP
```

**Incorrect:** Exposing Redis to the internet.

```
# Bad: Binds to all interfaces
bind 0.0.0.0
protected-mode no
```

**Security checklist:**
- Use TLS for connections
- Bind to specific interfaces, not `0.0.0.0`
- Use firewall rules to restrict access
- Disable dangerous commands in production

```
# Disable dangerous commands
rename-command FLUSHALL ""
rename-command DEBUG ""
rename-command CONFIG ""
```

Reference: [Redis Security](https://redis.io/docs/latest/operate/oss_and_stack/management/security/)

