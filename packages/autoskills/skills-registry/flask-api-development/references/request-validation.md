# Request Validation

## Request Validation

```python
# validators.py
from flask import request, jsonify
from functools import wraps

def validate_json(*required_fields):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if not request.is_json:
                return jsonify({'error': 'Request body must be JSON'}), 400

            data = request.get_json()
            missing = [field for field in required_fields if field not in data]

            if missing:
                return jsonify({
                    'error': 'Missing required fields',
                    'missing_fields': missing
                }), 400

            return f(*args, **kwargs)
        return decorated_function
    return decorator

def validate_email(email):
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

# Usage
@users_bp.route('', methods=['POST'])
@validate_json('email', 'password', 'first_name')
def create_user():
    data = request.get_json()
    if not validate_email(data['email']):
        return jsonify({'error': 'Invalid email format'}), 400
    # ... rest of logic
```
