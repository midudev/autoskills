# Sorbet Inline Signature Syntax Guide

Source: https://sorbet.org/docs/sigs

## Contents

- [Setup](#setup)
- [Typed Sigils](#typed-sigils)
- [Basic Signature Syntax](#basic-signature-syntax)
- [Return Types](#return-types) - `returns()`, `void`
- [Parameter Types](#parameter-types) - required, optional, keyword, rest, block
- [Multi-line Signatures](#multi-line-signatures)
- [Type Constructors](#type-constructors) - `T.nilable`, `T.any`, `T.all`, `T.untyped`
- [Collection Types](#collection-types) - `T::Array`, `T::Hash`, `T::Set`, `T::Range`, `T::Enumerable`
- [Type Assertions](#type-assertions) - `T.let`, `T.cast`, `T.must`, `T.bind`
- [Class Methods](#class-methods) - `def self.` and `class << self`
- [Attributes](#attributes) - `attr_reader`, `attr_writer`, `attr_accessor`
- [Abstract Methods](#abstract-methods)
- [Override Methods](#override-methods)
- [Generics](#generics)
- [Special Types](#special-types) - `T::Boolean`, `T.noreturn`, `T.self_type`, etc.

## Setup

Add `extend T::Sig` to use signatures in a class or module:

```ruby
class MyClass
  extend T::Sig
end
```

## Typed Sigils

Every file should have a typed sigil at the top:

```ruby
# typed: strict
```

Levels (from least to most strict):
- `ignore` - Sorbet ignores the file
- `false` - Only syntax errors reported
- `true` - Type errors reported, untyped code allowed
- `strict` - All methods must have signatures
- `strong` - No `T.untyped` allowed anywhere

## Basic Signature Syntax

```ruby
sig { params(x: Type, y: Type).returns(ReturnType) }
def method_name(x, y)
end
```

## Return Types

### returns()
```ruby
sig { returns(String) }
def name
  @name
end
```

### void
For methods where only side effects matter:
```ruby
sig { void }
def greet(name)
  puts "Hello, #{name}!"
end
```

## Parameter Types

### Required Parameters
```ruby
sig { params(name: String, age: Integer).returns(String) }
def greet(name, age)
end
```

### Optional Parameters
```ruby
sig { params(name: String, greeting: String).returns(String) }
def greet(name, greeting = "Hello")
end
```

### Keyword Parameters
```ruby
sig { params(name: String, age: Integer).returns(String) }
def greet(name:, age:)
end
```

### Rest Parameters (*args)
```ruby
sig { params(args: Integer).void }
def sum(*args)
  # args is T::Array[Integer] inside the method
end
```

### Keyword Rest Parameters (**kwargs)
```ruby
sig { params(kwargs: String).void }
def process(**kwargs)
  # kwargs is T::Hash[Symbol, String] inside the method
end
```

### Block Parameters
```ruby
sig { params(blk: T.proc.params(x: Integer).returns(String)).returns(T::Array[String]) }
def map_numbers(&blk)
end

# Void block
sig { params(blk: T.proc.void).void }
def with_block(&blk)
end
```

## Multi-line Signatures

```ruby
sig do
  params(
    name: String,
    age: Integer,
    email: T.nilable(String)
  )
  .returns(User)
end
def create_user(name, age, email = nil)
end
```

## Type Constructors

### T.nilable - Optional/Nullable
```ruby
sig { params(name: T.nilable(String)).void }
def greet(name)
  # name can be String or nil
end
```

### T.any - Union Types
```ruby
sig { params(id: T.any(String, Integer)).returns(User) }
def find(id)
end
```

### T.all - Intersection Types
```ruby
sig { params(obj: T.all(Enumerable, Comparable)).void }
def process(obj)
end
```

### T.untyped - Unknown Type (avoid!)
```ruby
sig { params(data: T.untyped).returns(T.untyped) }
def process(data)
end
```

## Collection Types

### T::Array
```ruby
sig { returns(T::Array[String]) }
def names
  ["Alice", "Bob"]
end
```

### T::Hash
```ruby
sig { returns(T::Hash[Symbol, Integer]) }
def scores
  { alice: 100, bob: 95 }
end
```

### T::Set
```ruby
sig { returns(T::Set[String]) }
def unique_names
  Set.new(["Alice", "Bob"])
end
```

### T::Range
```ruby
sig { returns(T::Range[Integer]) }
def valid_range
  1..100
end
```

### T::Enumerable
```ruby
sig { params(items: T::Enumerable[String]).void }
def process(items)
end
```

## Type Assertions

### T.let - Declare Variable Types
```ruby
# Instance variables
@name = T.let("", String)
@users = T.let([], T::Array[User])

# Constants
TIMEOUT = T.let(30, Integer)

# Class variables
@@count = T.let(0, Integer)
```

### T.cast - Force Type (unsafe)
```ruby
user = T.cast(data, User)
```

### T.must - Assert Non-nil
```ruby
name = T.must(params[:name])  # raises if nil
```

### T.bind - Bind Self Type
```ruby
sig { params(blk: T.proc.bind(MyClass).void).void }
def with_context(&blk)
end
```

## Class Methods

### Style 1: def self.method
```ruby
class User
  extend T::Sig

  sig { params(id: Integer).returns(User) }
  def self.find(id)
  end
end
```

### Style 2: class << self
```ruby
class User
  class << self
    extend T::Sig

    sig { params(id: Integer).returns(User) }
    def find(id)
    end
  end
end
```

## Attributes

### attr_reader
```ruby
sig { returns(String) }
attr_reader :name
```

### attr_writer
```ruby
sig { params(name: String).returns(String) }
attr_writer :name
```

### attr_accessor
```ruby
sig { returns(String) }
attr_accessor :name
```

## Abstract Methods

```ruby
class AbstractClass
  extend T::Sig
  extend T::Helpers

  abstract!

  sig { abstract.returns(String) }
  def name; end
end
```

## Override Methods

```ruby
sig { override.returns(String) }
def to_s
  "MyClass"
end
```

## Generics

### Generic Class
```ruby
class Box
  extend T::Sig
  extend T::Generic

  Elem = type_member

  sig { params(value: Elem).void }
  def initialize(value)
    @value = T.let(value, Elem)
  end

  sig { returns(Elem) }
  def value
    @value
  end
end
```

## Special Types

- `T::Boolean` - true or false
- `T.noreturn` - method never returns (raises or loops forever)
- `T.self_type` - returns self
- `T.attached_class` - for class methods returning instances
- `T.class_of(MyClass)` - the class itself, not instances
