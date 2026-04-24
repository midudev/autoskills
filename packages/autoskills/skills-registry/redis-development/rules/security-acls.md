---
title: Use ACLs for Fine-Grained Access Control
impact: HIGH
impactDescription: Limits blast radius if credentials are compromised
tags: security, acl, users, permissions, least-privilege
description: Use ACLs for Fine-Grained Access Control
alwaysApply: true
---

## Use ACLs for Fine-Grained Access Control

Create users with only the permissions they need (principle of least privilege).

**Correct:** Create specific users with limited permissions.

```
# Read-only user for cache access
ACL SETUSER app_readonly on >password ~cache:* +get +mget +scan

# Writer that can't run dangerous commands
ACL SETUSER app_writer on >password ~* +@all -@dangerous

# Admin user (use sparingly)
ACL SETUSER admin on >strong-password ~* +@all
```

**Incorrect:** Using the default user for everything.

```
# Bad: Single password for all access
requirepass shared-password
```

**ACL categories:**
- `@read` - Read commands
- `@write` - Write commands
- `@dangerous` - Commands like FLUSHALL, DEBUG
- `@admin` - Administrative commands

Reference: [Redis ACL](https://redis.io/docs/latest/operate/oss_and_stack/management/security/acl/)

