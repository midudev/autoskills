# Authentication and JWT

## Authentication and JWT

```python
# auth.py
from flask import request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from functools import wraps
from models import User, db

def authenticate_user(email, password):
    user = User.query.filter_by(email=email).first()
    if user and user.verify_password(password):
        return user
    return None

def login_required(f):
    @wraps(f)
    @jwt_required()
    def decorated_function(*args, **kwargs):
        identity = get_jwt_identity()
        user = User.query.get(identity)
        if not user or not user.is_active:
            return jsonify({'error': 'User not found or inactive'}), 401
        request.current_user = user
        return f(*args, **kwargs)
    return decorated_function

def admin_required(f):
    @wraps(f)
    @login_required
    def decorated_function(*args, **kwargs):
        if request.current_user.role != 'admin':
            return jsonify({'error': 'Admin access required'}), 403
        return f(*args, **kwargs)
    return decorated_function

# routes/auth.py
from flask import Blueprint, request, jsonify
from auth import authenticate_user, login_required
from models import User, db
from flask_jwt_extended import create_access_token

auth_bp = Blueprint('auth', __name__, url_prefix='/api/auth')

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if not data or not data.get('email') or not data.get('password'):
        return jsonify({'error': 'Missing credentials'}), 400

    user = authenticate_user(data['email'], data['password'])
    if not user:
        return jsonify({'error': 'Invalid credentials'}), 401

    access_token = create_access_token(identity=str(user.id))
    return jsonify({
        'access_token': access_token,
        'user': user.to_dict()
    }), 200

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    if User.query.filter_by(email=data['email']).first():
        return jsonify({'error': 'Email already exists'}), 409

    user = User(email=data['email'], first_name=data.get('first_name'))
    user.set_password(data['password'])
    db.session.add(user)
    db.session.commit()

    return jsonify({'user': user.to_dict()}), 201

@auth_bp.route('/profile', methods=['GET'])
@login_required
def get_profile():
    return jsonify({'user': request.current_user.to_dict()}), 200
```
