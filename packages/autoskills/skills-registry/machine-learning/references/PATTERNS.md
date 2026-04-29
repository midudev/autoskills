# Machine Learning Patterns

## Design Patterns

### Pattern 1: Input Validation

Always validate input before processing:

```python
def validate_input(data):
    if data is None:
        raise ValueError("Data cannot be None")
    if not isinstance(data, dict):
        raise TypeError("Data must be a dictionary")
    return True
```

### Pattern 2: Error Handling

Use consistent error handling:

```python
try:
    result = risky_operation()
except SpecificError as e:
    logger.error(f"Operation failed: {e}")
    handle_error(e)
except Exception as e:
    logger.exception("Unexpected error")
    raise
```

### Pattern 3: Configuration Loading

Load and validate configuration:

```python
import yaml

def load_config(config_path):
    with open(config_path) as f:
        config = yaml.safe_load(f)
    validate_config(config)
    return config
```

## Anti-Patterns to Avoid

### ❌ Don't: Swallow Exceptions

```python
# BAD
try:
    do_something()
except:
    pass
```

### ✅ Do: Handle Explicitly

```python
# GOOD
try:
    do_something()
except SpecificError as e:
    logger.warning(f"Expected error: {e}")
    return default_value
```

## Category-Specific Patterns: General

### Recommended Approach

1. Start with the simplest implementation
2. Add complexity only when needed
3. Test each addition
4. Document decisions

### Common Integration Points

- Configuration: `assets/config.yaml`
- Validation: `scripts/validate.py`
- Documentation: `references/GUIDE.md`

---

*Pattern library for machine-learning skill*
