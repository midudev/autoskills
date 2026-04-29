# Writing Guidelines for Redis Rules

Guidelines for creating effective Redis best practice rules for AI agents and LLMs.

## Key Principles

### 1. Concrete Patterns

Show exact code transformations. Avoid abstract advice.

**Good:** "Use `SCAN` instead of `KEYS *` for iteration"
**Bad:** "Design efficient queries"

### 2. Problem-First Structure

Show the correct pattern first, then the incorrect one. This helps agents understand what to do and what to avoid.

```markdown
**Correct:** Description of good approach.

[good example]

**Incorrect:** Description of problematic approach.

[bad example]
```

### 3. Practical Impact

Include specific benefits. Helps agents prioritize.

**Good:** "10x faster", "50% less memory", "Eliminates blocking"
**Bad:** "Faster", "Better", "More efficient"

### 4. Complete Examples

Examples should be runnable or close to it.

```python
import redis

# Include setup when needed for clarity
pool = redis.ConnectionPool(host='localhost', max_connections=50)
r = redis.Redis(connection_pool=pool)

# Now show the pattern
result = r.get('user:1001')
```

### 5. Semantic Naming

Use meaningful names. Names carry intent for LLMs.

**Good:** `user:1001:profile`, `order:items`, `cache:api:response`
**Bad:** `key1`, `mykey`, `data`

---

## Code Standards

### Language Tags

- `python` - Python examples (preferred for Redis)
- `javascript` - Node.js examples
- `bash` - Redis CLI commands
- (none) - Redis commands without language wrapper

### Comments

- Explain _why_, not _what_
- Highlight performance implications
- Point out common mistakes

---

## Impact Levels

| Level | Improvement | Examples |
|-------|-------------|----------|
| **HIGH** | 5-100x | Missing indexes, connection issues, blocking commands |
| **MEDIUM** | 2-5x | Suboptimal data structures, missing TTL |
| **LOW** | Incremental | Advanced patterns, edge cases |

---

## Review Checklist

Before submitting a rule:

- [ ] Title is clear and action-oriented
- [ ] Impact level matches the benefit
- [ ] impactDescription includes quantification
- [ ] Has at least 1 **Correct** example
- [ ] Has at least 1 **Incorrect** example
- [ ] Code uses semantic naming
- [ ] Comments explain _why_
- [ ] Reference links included
