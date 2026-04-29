# Blueprints for Modular API Design

## Blueprints for Modular API Design

```python
# routes/users.py
from flask import Blueprint, request, jsonify
from auth import login_required, admin_required
from models import User, db
from sqlalchemy import or_

users_bp = Blueprint('users', __name__, url_prefix='/api/users')

@users_bp.route('', methods=['GET'])
@login_required
def list_users():
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 20, type=int)
    search = request.args.get('q', '', type=str)

    query = User.query
    if search:
        query = query.filter(or_(
            User.email.ilike(f'%{search}%'),
            User.first_name.ilike(f'%{search}%')
        ))

    paginated = query.paginate(page=page, per_page=limit)
    return jsonify({
        'data': [user.to_dict() for user in paginated.items],
        'pagination': {
            'page': page,
            'limit': limit,
            'total': paginated.total,
            'pages': paginated.pages
        }
    }), 200

@users_bp.route('/<user_id>', methods=['GET'])
@login_required
def get_user(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'User not found'}), 404
    return jsonify({'user': user.to_dict()}), 200

@users_bp.route('/<user_id>', methods=['PATCH'])
@login_required
def update_user(user_id):
    if str(request.current_user.id) != user_id:
        return jsonify({'error': 'Unauthorized'}), 403

    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'User not found'}), 404

    data = request.get_json()
    if 'first_name' in data:
        user.first_name = data['first_name']
    if 'last_name' in data:
        user.last_name = data['last_name']

    db.session.commit()
    return jsonify({'user': user.to_dict()}), 200

@users_bp.route('/<user_id>', methods=['DELETE'])
@admin_required
def delete_user(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'User not found'}), 404

    db.session.delete(user)
    db.session.commit()
    return '', 204
```
