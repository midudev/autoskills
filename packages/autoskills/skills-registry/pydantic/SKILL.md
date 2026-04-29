---
name: pydantic
description: Python data validation using type hints and runtime type checking with Pydantic v2's Rust-powered core for high-performance validation in FastAPI, Django, and configuration management.
user-invocable: false
disable-model-invocation: true
progressive_disclosure:
  entry_point:
    - summary
    - when_to_use
    - quick_start
  full_content: all
token_estimates:
  entry_point: 70
  full: 5500
---

# Pydantic Validation Skill

## Summary
Python data validation using type hints and runtime type checking with Pydantic v2's Rust-powered core for high-performance validation.

## When to Use
- API request/response validation (FastAPI, Django)
- Settings and configuration management (env variables, config files)
- ORM model validation (SQLAlchemy integration)
- Data parsing and serialization (JSON, dict, custom formats)
- Type-safe data classes with automatic validation
- CLI argument parsing with type safety

## Quick Start

```python
from pydantic import BaseModel, Field, EmailStr
from datetime import datetime

class User(BaseModel):
    id: int
    name: str = Field(..., min_length=1, max_length=100)
    email: EmailStr
    created_at: datetime = Field(default_factory=datetime.now)
    is_active: bool = True

# Validate data
user = User(id=1, name="Alice", email="alice@example.com")
print(user.model_dump())  # {'id': 1, 'name': 'Alice', ...}

# Automatic type coercion
user2 = User(id="2", name="Bob", email="bob@example.com")
assert user2.id == 2  # String "2" coerced to int

# Validation error
try:
    User(id=3, name="", email="invalid")
except ValidationError as e:
    print(e.errors())
```

---

## Core Concepts

### BaseModel Foundation

```python
from pydantic import BaseModel, ConfigDict

class Product(BaseModel):
    model_config = ConfigDict(
        str_strip_whitespace=True,
        validate_assignment=True,
        use_enum_values=True,
        arbitrary_types_allowed=False
    )

    name: str
    price: float
    quantity: int = 0

# Usage
product = Product(name="  Widget  ", price=19.99)
assert product.name == "Widget"  # Whitespace stripped

# Validate on assignment
product.price = "29.99"  # Auto-converts to float
```

### Field Configuration

```python
from pydantic import Field, field_validator
from typing import Annotated

class Item(BaseModel):
    # Field constraints
    sku: str = Field(pattern=r'^[A-Z]{3}-\d{4}$')
    price: float = Field(gt=0, le=10000)
    stock: int = Field(ge=0, default=0)

    # Annotated types (Pydantic v2)
    quantity: Annotated[int, Field(ge=1, le=100)]

    # Descriptions and examples
    description: str = Field(
        ...,
        description="Product description",
        examples=["High-quality widget"]
    )

    # Deprecated fields
    old_field: str | None = Field(None, deprecated=True)

    @field_validator('sku')
    @classmethod
    def validate_sku(cls, v: str) -> str:
        if not v.startswith('ABC'):
            raise ValueError('SKU must start with ABC')
        return v
```

## Pydantic v2 Improvements

### Migration from v1

```python
# Pydantic v1
class OldModel(BaseModel):
    class Config:
        validate_assignment = True
        json_encoders = {datetime: lambda v: v.isoformat()}

# Pydantic v2
class NewModel(BaseModel):
    model_config = ConfigDict(
        validate_assignment=True,
        # json_encoders replaced by serializers
    )

    @model_serializer
    def ser_model(self) -> dict:
        return {...}

# Key changes:
# - .dict() → .model_dump()
# - .json() → .model_dump_json()
# - .parse_obj() → .model_validate()
# - .parse_raw() → .model_validate_json()
# - @validator → @field_validator
# - @root_validator → @model_validator
```

### Performance Improvements

```python
# v2 uses Rust core (pydantic-core) for 5-50x speedup
from pydantic import BaseModel
import time

class Data(BaseModel):
    values: list[int]
    names: list[str]

# Benchmark
data = {'values': list(range(10000)), 'names': ['item'] * 10000}
start = time.perf_counter()
for _ in range(1000):
    Data.model_validate(data)
elapsed = time.perf_counter() - start
print(f"Validated 1000 iterations in {elapsed:.2f}s")
```

## Field Types

### Built-in Types

```python
from pydantic import (
    BaseModel, EmailStr, HttpUrl, UUID4,
    FilePath, DirectoryPath, Json, SecretStr,
    PositiveInt, NegativeFloat, conint, constr
)
from typing import Literal
from pathlib import Path

class Example(BaseModel):
    # Email validation
    email: EmailStr

    # URL validation
    website: HttpUrl

    # UUID
    id: UUID4

    # File system paths
    config_file: FilePath
    data_dir: DirectoryPath

    # JSON string → parsed object
    metadata: Json[dict[str, str]]

    # Secret (won't print in logs)
    api_key: SecretStr

    # Constrained types
    age: PositiveInt
    balance: NegativeFloat
    username: constr(min_length=3, max_length=20, pattern=r'^[a-z]+$')
    code: conint(ge=1000, le=9999)

    # Literal types
    status: Literal['pending', 'approved', 'rejected']
```

### Custom Types

```python
from pydantic import GetCoreSchemaHandler, GetJsonSchemaHandler
from pydantic_core import core_schema
from typing import Any

class Color:
    def __init__(self, r: int, g: int, b: int):
        self.r, self.g, self.b = r, g, b

    @classmethod
    def __get_pydantic_core_schema__(
        cls, source_type: Any, handler: GetCoreSchemaHandler
    ) -> core_schema.CoreSchema:
        return core_schema.no_info_after_validator_function(
            cls.validate,
            core_schema.str_schema()
        )

    @classmethod
    def validate(cls, v: str) -> 'Color':
        if not v.startswith('#') or len(v) != 7:
            raise ValueError('Invalid hex color')
        r = int(v[1:3], 16)
        g = int(v[3:5], 16)
        b = int(v[5:7], 16)
        return cls(r, g, b)

class Design(BaseModel):
    primary_color: Color

# Usage
design = Design(primary_color='#FF5733')
assert design.primary_color.r == 255
```

## Validators

### Field Validators

```python
from pydantic import field_validator, model_validator

class Account(BaseModel):
    username: str
    password: str
    password_confirm: str

    @field_validator('username')
    @classmethod
    def username_alphanumeric(cls, v: str) -> str:
        if not v.isalnum():
            raise ValueError('must be alphanumeric')
        return v

    @field_validator('password')
    @classmethod
    def password_strong(cls, v: str) -> str:
        if len(v) < 8:
            raise ValueError('must be at least 8 characters')
        if not any(c.isupper() for c in v):
            raise ValueError('must contain uppercase letter')
        return v

    # Validate multiple fields
    @field_validator('username', 'password')
    @classmethod
    def not_empty(cls, v: str) -> str:
        if not v or not v.strip():
            raise ValueError('must not be empty')
        return v.strip()
```

### Model Validators

```python
from pydantic import model_validator
from typing import Self

class DateRange(BaseModel):
    start_date: datetime
    end_date: datetime

    @model_validator(mode='after')
    def check_dates(self) -> Self:
        if self.end_date < self.start_date:
            raise ValueError('end_date must be after start_date')
        return self

class Order(BaseModel):
    items: list[str]
    total: float
    discount: float = 0

    @model_validator(mode='before')
    @classmethod
    def calculate_total(cls, data: dict) -> dict:
        # Pre-processing before validation
        if isinstance(data, dict) and 'total' not in data:
            data['total'] = len(data.get('items', [])) * 10.0
        return data
```

### Root Validators (Wrap)

```python
from pydantic import model_validator, ValidationInfo

class Config(BaseModel):
    env: Literal['dev', 'prod']
    debug: bool = False

    @model_validator(mode='wrap')
    @classmethod
    def validate_config(cls, values: Any, handler, info: ValidationInfo):
        # Call default validation
        result = handler(values)

        # Post-validation logic
        if result.env == 'prod' and result.debug:
            raise ValueError('debug cannot be True in production')

        return result
```

## Type Coercion and Strict Mode

```python
from pydantic import BaseModel, ConfigDict, ValidationError

# Coercive mode (default)
class CoerciveModel(BaseModel):
    count: int
    price: float

data = CoerciveModel(count="42", price="19.99")
assert data.count == 42  # String → int
assert data.price == 19.99  # String → float

# Strict mode
class StrictModel(BaseModel):
    model_config = ConfigDict(strict=True)

    count: int
    price: float

try:
    StrictModel(count="42", price="19.99")  # Raises ValidationError
except ValidationError as e:
    print("Strict mode: no coercion allowed")

# Per-field strict mode
class MixedModel(BaseModel):
    flexible: int  # Allows coercion
    strict: Annotated[int, Field(strict=True)]  # No coercion

MixedModel(flexible="1", strict=2)  # OK
# MixedModel(flexible="1", strict="2")  # ValidationError
```

## Nested Models and Recursive Types

```python
from pydantic import BaseModel
from typing import ForwardRef

# Nested models
class Address(BaseModel):
    street: str
    city: str
    country: str

class Company(BaseModel):
    name: str
    address: Address

company = Company(
    name="ACME Corp",
    address={'street': '123 Main St', 'city': 'NYC', 'country': 'USA'}
)

# Recursive types (tree structure)
class TreeNode(BaseModel):
    value: int
    children: list['TreeNode'] = []

TreeNode.model_rebuild()  # Required for forward references

tree = TreeNode(
    value=1,
    children=[
        TreeNode(value=2, children=[TreeNode(value=4)]),
        TreeNode(value=3)
    ]
)

# Self-referencing with ForwardRef
class Category(BaseModel):
    name: str
    parent: 'Category | None' = None
    subcategories: list['Category'] = []

Category.model_rebuild()
```

## Generic Models

```python
from pydantic import BaseModel
from typing import Generic, TypeVar

T = TypeVar('T')

class Response(BaseModel, Generic[T]):
    success: bool
    data: T
    message: str = ''

class User(BaseModel):
    id: int
    name: str

# Usage with concrete type
user_response = Response[User](
    success=True,
    data=User(id=1, name='Alice')
)

# List response
list_response = Response[list[User]](
    success=True,
    data=[User(id=1, name='Alice'), User(id=2, name='Bob')]
)

# Generic repository pattern
class Repository(BaseModel, Generic[T]):
    items: list[T]

    def add(self, item: T) -> None:
        self.items.append(item)

user_repo = Repository[User](items=[])
user_repo.add(User(id=1, name='Alice'))
```

## Serialization

### Model Dump

```python
from pydantic import BaseModel, Field, field_serializer

class Article(BaseModel):
    title: str
    content: str
    tags: list[str]
    metadata: dict[str, Any] = {}

    # Serialization customization
    @field_serializer('tags')
    def serialize_tags(self, tags: list[str]) -> str:
        return ','.join(tags)

article = Article(
    title='Pydantic Guide',
    content='...',
    tags=['python', 'validation']
)

# Dump to dict
data = article.model_dump()
# {'title': 'Pydantic Guide', 'tags': 'python,validation', ...}

# Exclude fields
data = article.model_dump(exclude={'metadata'})

# Include only specific fields
data = article.model_dump(include={'title', 'tags'})

# Exclude unset fields
article2 = Article(title='Test', content='...', tags=[])
data = article2.model_dump(exclude_unset=True)  # metadata excluded

# By alias
class AliasModel(BaseModel):
    internal_name: str = Field(alias='externalName')

model = AliasModel(externalName='value')
model.model_dump(by_alias=True)  # {'externalName': 'value'}
```

### JSON Serialization

```python
from datetime import datetime
from pydantic import BaseModel, field_serializer

class Event(BaseModel):
    name: str
    timestamp: datetime

    @field_serializer('timestamp')
    def serialize_dt(self, dt: datetime) -> str:
        return dt.isoformat()

event = Event(name='Deploy', timestamp=datetime.now())

# Dump to JSON string
json_str = event.model_dump_json()
# '{"name":"Deploy","timestamp":"2025-11-30T..."}'

# Pretty print
json_str = event.model_dump_json(indent=2)

# Parse from JSON
event2 = Event.model_validate_json(json_str)
```

### Custom Serializers

```python
from pydantic import model_serializer

class User(BaseModel):
    id: int
    username: str
    password: SecretStr

    @model_serializer
    def ser_model(self) -> dict[str, Any]:
        return {
            'id': self.id,
            'username': self.username,
            # Never serialize password
        }

user = User(id=1, username='alice', password='secret123')
assert 'password' not in user.model_dump()
```

## Settings Management

### BaseSettings

```python
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import Field

class AppSettings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file='.env',
        env_file_encoding='utf-8',
        env_prefix='APP_',
        case_sensitive=False
    )

    # Environment variables
    database_url: str
    redis_url: str = 'redis://localhost:6379'
    secret_key: SecretStr
    debug: bool = False

    # Nested settings
    class SMTPSettings(BaseModel):
        host: str
        port: int = 587
        username: str
        password: SecretStr

    smtp: SMTPSettings

# Reads from environment variables:
# APP_DATABASE_URL, APP_REDIS_URL, APP_SECRET_KEY, APP_DEBUG
# APP_SMTP__HOST, APP_SMTP__PORT, etc.

settings = AppSettings()
```

### Multi-Environment Settings

```python
from functools import lru_cache

class Settings(BaseSettings):
    environment: Literal['dev', 'staging', 'prod'] = 'dev'
    database_url: str
    api_key: SecretStr

    model_config = SettingsConfigDict(
        env_file='.env',
        extra='ignore'
    )

    @property
    def is_production(self) -> bool:
        return self.environment == 'prod'

@lru_cache
def get_settings() -> Settings:
    return Settings()

# Usage in FastAPI
from fastapi import Depends

@app.get('/config')
def get_config(settings: Settings = Depends(get_settings)):
    return {'env': settings.environment}
```

## FastAPI Integration

### Request/Response Models

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr

app = FastAPI()

class UserCreate(BaseModel):
    username: str = Field(min_length=3, max_length=50)
    email: EmailStr
    password: str = Field(min_length=8)

class UserResponse(BaseModel):
    id: int
    username: str
    email: EmailStr

    model_config = ConfigDict(from_attributes=True)

@app.post('/users', response_model=UserResponse)
def create_user(user: UserCreate):
    # FastAPI auto-validates request body
    # Returns only fields in UserResponse (password excluded)
    return UserResponse(
        id=1,
        username=user.username,
        email=user.email
    )
```

### Query Parameters

```python
from pydantic import BaseModel, Field
from fastapi import Query

class PaginationParams(BaseModel):
    skip: int = Field(0, ge=0)
    limit: int = Field(10, ge=1, le=100)

class SearchParams(BaseModel):
    q: str = Field(..., min_length=1)
    category: str | None = None
    sort_by: Literal['date', 'relevance'] = 'relevance'

@app.get('/search')
def search(params: SearchParams = Query()):
    return {'query': params.q, 'sort': params.sort_by}
```

### Response Model Customization

```python
class DetailedUser(BaseModel):
    id: int
    username: str
    email: EmailStr
    created_at: datetime
    last_login: datetime | None

@app.get('/users/{user_id}', response_model=DetailedUser)
def get_user(user_id: int, include_dates: bool = False):
    user = DetailedUser(
        id=user_id,
        username='alice',
        email='alice@example.com',
        created_at=datetime.now(),
        last_login=None
    )

    if not include_dates:
        return user.model_dump(exclude={'created_at', 'last_login'})
    return user
```

## SQLAlchemy Integration

### ORM Models with Pydantic

```python
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.orm import DeclarativeBase
from pydantic import BaseModel, ConfigDict

class Base(DeclarativeBase):
    pass

# SQLAlchemy ORM model
class UserDB(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    username = Column(String(50), unique=True)
    email = Column(String(100))
    created_at = Column(DateTime, default=datetime.utcnow)

# Pydantic model for validation
class UserSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    username: str
    email: EmailStr
    created_at: datetime

# Usage
from sqlalchemy.orm import Session

def get_user(db: Session, user_id: int) -> UserSchema:
    user = db.query(UserDB).filter(UserDB.id == user_id).first()
    return UserSchema.model_validate(user)  # ORM → Pydantic
```

### Hybrid Approach

```python
from pydantic import BaseModel

class UserBase(BaseModel):
    username: str
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserUpdate(BaseModel):
    username: str | None = None
    email: EmailStr | None = None
    password: str | None = None

class UserInDB(UserBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created_at: datetime
    password_hash: str

# CRUD operations
def create_user(db: Session, user: UserCreate) -> UserInDB:
    db_user = UserDB(
        username=user.username,
        email=user.email,
        password_hash=hash_password(user.password)
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return UserInDB.model_validate(db_user)
```

## Django Integration

### Django Model Validation

```python
from django.db import models
from pydantic import BaseModel, field_validator

# Django model
class Article(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    published = models.BooleanField(default=False)

# Pydantic schema
class ArticleSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    title: str = Field(max_length=200)
    content: str
    published: bool = False

    @field_validator('content')
    @classmethod
    def validate_content(cls, v: str) -> str:
        if len(v) < 100:
            raise ValueError('Content too short')
        return v

# Usage in Django views
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods

@require_http_methods(['POST'])
def create_article(request):
    try:
        data = ArticleSchema.model_validate_json(request.body)
        article = Article.objects.create(**data.model_dump())
        return JsonResponse({'id': article.id})
    except ValidationError as e:
        return JsonResponse({'errors': e.errors()}, status=400)
```

## Computed Fields

```python
from pydantic import computed_field

class Rectangle(BaseModel):
    width: float
    height: float

    @computed_field
    @property
    def area(self) -> float:
        return self.width * self.height

    @computed_field
    @property
    def perimeter(self) -> float:
        return 2 * (self.width + self.height)

rect = Rectangle(width=10, height=5)
assert rect.area == 50
assert rect.perimeter == 30

# Computed fields in serialization
data = rect.model_dump()
# {'width': 10.0, 'height': 5.0, 'area': 50.0, 'perimeter': 30.0}
```

## Custom Errors

```python
from pydantic import BaseModel, field_validator, ValidationError
from pydantic_core import PydanticCustomError

class StrictUser(BaseModel):
    username: str
    age: int

    @field_validator('username')
    @classmethod
    def validate_username(cls, v: str) -> str:
        if len(v) < 3:
            raise PydanticCustomError(
                'username_too_short',
                'Username must be at least 3 characters',
                {'min_length': 3, 'actual_length': len(v)}
            )
        return v

    @field_validator('age')
    @classmethod
    def validate_age(cls, v: int) -> int:
        if v < 18:
            raise PydanticCustomError(
                'underage',
                'User must be at least 18 years old',
                {'age': v, 'minimum_age': 18}
            )
        return v

# Custom error handling
try:
    StrictUser(username='ab', age=16)
except ValidationError as e:
    for error in e.errors():
        print(f"{error['type']}: {error['msg']}")
        print(f"Context: {error.get('ctx')}")
```

## Performance Optimization

### V2 Rust Core Benefits

```python
# Pydantic v2 uses pydantic-core (Rust) for:
# - 5-50x faster validation
# - Lower memory usage
# - Better error messages
# - Improved JSON parsing

import timeit
from pydantic import BaseModel

class Data(BaseModel):
    values: list[int]
    names: list[str]
    metadata: dict[str, Any]

# Benchmark
data_dict = {
    'values': list(range(1000)),
    'names': ['item'] * 1000,
    'metadata': {'key': 'value'}
}

def validate():
    Data.model_validate(data_dict)

time_taken = timeit.timeit(validate, number=10000)
print(f"10000 validations: {time_taken:.2f}s")
```

### Optimization Techniques

```python
from pydantic import BaseModel, ConfigDict

class OptimizedModel(BaseModel):
    model_config = ConfigDict(
        # Validate assignment only when needed
        validate_assignment=False,

        # Disable validation for internal use
        validate_default=False,

        # Use slots for memory efficiency
        # (Not available in Pydantic v2 BaseModel directly)
    )

    data: list[int]

# Reuse validators
from functools import lru_cache

@lru_cache(maxsize=128)
def get_validator(model_class):
    return model_class.model_validate

# Bulk validation
def validate_bulk(items: list[dict]) -> list[Data]:
    validator = get_validator(Data)
    return [validator(item) for item in items]
```

## JSON Schema Generation

```python
from pydantic import BaseModel, Field

class Product(BaseModel):
    """Product model for catalog"""

    id: int = Field(description="Unique product identifier")
    name: str = Field(description="Product name", examples=["Widget"])
    price: float = Field(gt=0, description="Price in USD")
    tags: list[str] = Field(default=[], description="Product tags")

# Generate JSON Schema
schema = Product.model_json_schema()
print(json.dumps(schema, indent=2))
# {
#   "title": "Product",
#   "description": "Product model for catalog",
#   "type": "object",
#   "properties": {
#     "id": {"type": "integer", "description": "Unique product identifier"},
#     "name": {"type": "string", "description": "Product name"},
#     ...
#   },
#   "required": ["id", "name", "price"]
# }

# OpenAPI compatible
from fastapi import FastAPI

app = FastAPI()

@app.post('/products')
def create_product(product: Product):
    return product

# FastAPI auto-generates OpenAPI schema from Pydantic models
```

## Dataclass Integration

```python
from pydantic.dataclasses import dataclass
from pydantic import Field

@dataclass
class User:
    id: int
    name: str = Field(min_length=1)
    email: str = Field(pattern=r'.+@.+\..+')

# Works like Pydantic BaseModel with validation
user = User(id=1, name='Alice', email='alice@example.com')

# Validation on construction
try:
    User(id=2, name='', email='invalid')
except ValidationError as e:
    print(e.errors())

# Convert to Pydantic BaseModel
from pydantic import BaseModel

class UserModel(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    email: str

user_model = UserModel.model_validate(user)
```

## Testing Strategies

### Unit Testing Models

```python
import pytest
from pydantic import ValidationError

def test_user_validation():
    # Valid data
    user = User(id=1, name='Alice', email='alice@example.com')
    assert user.name == 'Alice'

    # Invalid data
    with pytest.raises(ValidationError) as exc_info:
        User(id='invalid', name='Bob', email='bob@example.com')

    errors = exc_info.value.errors()
    assert errors[0]['type'] == 'int_parsing'

def test_user_serialization():
    user = User(id=1, name='Alice', email='alice@example.com')
    data = user.model_dump()

    assert data == {
        'id': 1,
        'name': 'Alice',
        'email': 'alice@example.com'
    }

def test_nested_validation():
    company = Company(
        name='ACME',
        address={'street': '123 Main', 'city': 'NYC', 'country': 'USA'}
    )
    assert company.address.city == 'NYC'
```

### Testing with Fixtures

```python
@pytest.fixture
def sample_user_data():
    return {
        'id': 1,
        'name': 'Alice',
        'email': 'alice@example.com'
    }

@pytest.fixture
def sample_user(sample_user_data):
    return User(**sample_user_data)

def test_with_fixtures(sample_user):
    assert sample_user.name == 'Alice'

def test_invalid_email(sample_user_data):
    sample_user_data['email'] = 'invalid'
    with pytest.raises(ValidationError):
        User(**sample_user_data)
```

### Property-Based Testing

```python
from hypothesis import given, strategies as st

@given(
    id=st.integers(min_value=1),
    name=st.text(min_size=1, max_size=100),
    email=st.emails()
)
def test_user_always_valid(id, name, email):
    user = User(id=id, name=name, email=email)
    assert user.id == id
    assert user.name == name
    assert user.email == email
```

## Migration Guide (v1 → v2)

### Key Changes

```python
# v1
from pydantic import BaseModel

class OldModel(BaseModel):
    class Config:
        validate_assignment = True
        arbitrary_types_allowed = True

    # Validators
    @validator('field')
    def validate_field(cls, v):
        return v

    @root_validator
    def validate_model(cls, values):
        return values

    # Serialization
    data = model.dict()
    json_str = model.json()

    # Parsing
    model = OldModel.parse_obj(data)
    model = OldModel.parse_raw(json_str)

# v2
from pydantic import BaseModel, ConfigDict, field_validator, model_validator

class NewModel(BaseModel):
    model_config = ConfigDict(
        validate_assignment=True,
        arbitrary_types_allowed=True
    )

    # Field validators
    @field_validator('field')
    @classmethod
    def validate_field(cls, v):
        return v

    # Model validators
    @model_validator(mode='after')
    def validate_model(self):
        return self

    # Serialization
    data = model.model_dump()
    json_str = model.model_dump_json()

    # Parsing
    model = NewModel.model_validate(data)
    model = NewModel.model_validate_json(json_str)
```

### Migration Checklist

- [ ] Replace `class Config` with `model_config = ConfigDict()`
- [ ] Update `.dict()` → `.model_dump()`
- [ ] Update `.json()` → `.model_dump_json()`
- [ ] Update `.parse_obj()` → `.model_validate()`
- [ ] Update `.parse_raw()` → `.model_validate_json()`
- [ ] Update `@validator` → `@field_validator` with `@classmethod`
- [ ] Update `@root_validator` → `@model_validator(mode='after')`
- [ ] Review `json_encoders` → use `@field_serializer`
- [ ] Test strict mode behavior changes
- [ ] Update custom types to use `__get_pydantic_core_schema__`

## Best Practices

### Model Organization

```python
# Separate schemas by use case
class UserBase(BaseModel):
    """Shared fields"""
    username: str
    email: EmailStr

class UserCreate(UserBase):
    """API request for creating user"""
    password: str

class UserUpdate(BaseModel):
    """API request for updating user (all optional)"""
    username: str | None = None
    email: EmailStr | None = None
    password: str | None = None

class UserInDB(UserBase):
    """Database representation"""
    model_config = ConfigDict(from_attributes=True)

    id: int
    password_hash: str
    created_at: datetime

class UserResponse(UserBase):
    """API response (excludes sensitive data)"""
    id: int
    created_at: datetime
```

### Validation Best Practices

```python
# Use Field for constraints, not validators
class Good(BaseModel):
    age: int = Field(ge=0, le=150)
    email: EmailStr

class Bad(BaseModel):
    age: int
    email: str

    @field_validator('age')
    @classmethod
    def validate_age(cls, v):
        if v < 0 or v > 150:
            raise ValueError('invalid age')
        return v

# Prefer composition over inheritance
class TimestampMixin(BaseModel):
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)

class User(TimestampMixin):
    username: str
    email: EmailStr
```

### Error Handling

```python
from pydantic import ValidationError

def safe_validate(data: dict) -> User | None:
    try:
        return User.model_validate(data)
    except ValidationError as e:
        # Log validation errors
        logger.error(f"Validation failed: {e.errors()}")
        return None

def validate_with_details(data: dict):
    try:
        return User.model_validate(data)
    except ValidationError as e:
        # Return user-friendly errors
        return {
            'success': False,
            'errors': [
                {
                    'field': '.'.join(str(loc) for loc in err['loc']),
                    'message': err['msg'],
                    'type': err['type']
                }
                for err in e.errors()
            ]
        }
```

## Common Patterns

### API Response Wrapper

```python
from typing import Generic, TypeVar

T = TypeVar('T')

class APIResponse(BaseModel, Generic[T]):
    success: bool
    data: T | None = None
    error: str | None = None
    metadata: dict[str, Any] = {}

# Usage
user_response = APIResponse[User](
    success=True,
    data=User(id=1, name='Alice', email='alice@example.com')
)

error_response = APIResponse[User](
    success=False,
    error='User not found'
)
```

### Pagination

```python
class PaginatedResponse(BaseModel, Generic[T]):
    items: list[T]
    total: int
    page: int
    page_size: int

    @computed_field
    @property
    def total_pages(self) -> int:
        return (self.total + self.page_size - 1) // self.page_size

users = PaginatedResponse[User](
    items=[...],
    total=100,
    page=1,
    page_size=10
)
assert users.total_pages == 10
```

### Audit Fields

```python
class AuditMixin(BaseModel):
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)
    created_by: int | None = None
    updated_by: int | None = None

class Document(AuditMixin):
    title: str
    content: str

    @model_validator(mode='before')
    @classmethod
    def update_timestamp(cls, data: dict) -> dict:
        if isinstance(data, dict):
            data['updated_at'] = datetime.utcnow()
        return data
```

## Related Skills

When using Pydantic, consider these complementary skills:

- **fastapi-local-dev**: FastAPI development server patterns with Pydantic integration
- **sqlalchemy**: SQLAlchemy ORM patterns for database models with Pydantic validation
- **django**: Django framework integration with Pydantic schemas
- **pytest**: Testing strategies for Pydantic models and validation

### Quick FastAPI Integration Reference (Inlined for Standalone Use)

```python
# FastAPI with Pydantic (basic pattern)
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr

app = FastAPI()

class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: int
    username: str
    email: EmailStr

    model_config = ConfigDict(from_attributes=True)

@app.post('/users', response_model=UserResponse)
def create_user(user: UserCreate):
    # FastAPI auto-validates using Pydantic
    # response_model filters out password
    return UserResponse(id=1, username=user.username, email=user.email)
```

### Quick SQLAlchemy Integration Reference (Inlined for Standalone Use)

```python
# SQLAlchemy 2.0 with Pydantic validation
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import DeclarativeBase
from pydantic import BaseModel, ConfigDict

class Base(DeclarativeBase):
    pass

class UserDB(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    username = Column(String(50))
    email = Column(String(100))

class UserSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    username: str
    email: str

# Convert ORM to Pydantic
user_orm = db.query(UserDB).first()
user_validated = UserSchema.model_validate(user_orm)
```

### Quick Pytest Testing Reference (Inlined for Standalone Use)

```python
# Testing Pydantic models with pytest
import pytest
from pydantic import ValidationError

def test_user_validation():
    user = User(id=1, name='Alice', email='alice@example.com')
    assert user.name == 'Alice'

def test_validation_error():
    with pytest.raises(ValidationError) as exc_info:
        User(id='invalid', name='Bob', email='bob@example.com')
    errors = exc_info.value.errors()
    assert errors[0]['type'] == 'int_parsing'

@pytest.fixture
def sample_user():
    return User(id=1, name='Alice', email='alice@example.com')
```

[Full integration patterns available in respective skills if deployed together]

## Additional Resources
- [Pydantic Documentation](https://docs.pydantic.dev/)
- [Migration Guide v1→v2](https://docs.pydantic.dev/latest/migration/)
- [Performance Benchmarks](https://docs.pydantic.dev/latest/concepts/performance/)
- [JSON Schema Integration](https://docs.pydantic.dev/latest/concepts/json_schema/)
