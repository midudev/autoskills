# Sorbet RBI Syntax Guide

Source: https://sorbet.org/docs/rbi

## Contents

- [RBI File Structure](#rbi-file-structure)
- [Typed Sigils](#typed-sigils)
- [Basic Signature Syntax](#basic-signature-syntax)
- [Return Types](#return-types) - `returns()`, `void`
- [Parameter Types](#parameter-types) - required, optional, keyword, rest, block
- [Type Constructors](#type-constructors) - `T.nilable`, `T.any`, `T.all`, `T.untyped`
- [Collection Types](#collection-types) - `T::Array`, `T::Hash`, `T::Set`, `T::Range`
- [Type Assertions in RBI](#type-assertions-in-rbi) - `T.let` for class/instance variables
- [Class Methods](#class-methods) - `def self.` and `class << self`
- [Attributes](#attributes) - `attr_reader`, `attr_writer`, `attr_accessor`
- [Abstract Methods](#abstract-methods)
- [Override Methods](#override-methods)
- [Interfaces and Mixins](#interfaces-and-mixins)
- [Generics](#generics)
- [Special Types](#special-types)

## RBI File Structure

RBI files mirror Ruby source structure but contain only type information:

```ruby
# typed: strict

class MyClass
  extend T::Sig

  sig { params(x: Integer).returns(String) }
  def my_method(x); end  # Empty body - just semicolon
end
```

Key differences from inline signatures:
- Method bodies are empty (use `; end` or just `end`)
- No implementation code
- Only type declarations and structure

## Typed Sigils

Every RBI file should have a typed sigil at the top:

```ruby
# typed: strict
```

Use `strict` for RBI files to ensure all methods have signatures.

Levels (least to most strict): `ignore` < `false` < `true` < `strict` < `strong`

## Basic Signature Syntax

```ruby
sig { params(x: Type, y: Type).returns(ReturnType) }
def method_name(x, y); end
```

## Return Types

### returns()
```ruby
sig { returns(String) }
def name; end
```

### void
For methods where only side effects matter:
```ruby
sig { void }
def greet(name); end
```

## Parameter Types

### Required Parameters
```ruby
sig { params(name: String, age: Integer).returns(String) }
def greet(name, age); end
```

### Optional Parameters
```ruby
sig { params(name: String, greeting: String).returns(String) }
def greet(name, greeting = "Hello"); end
```

### Keyword Parameters
```ruby
sig { params(name: String, age: Integer).returns(String) }
def greet(name:, age:); end
```

### Rest Parameters (*args)
```ruby
sig { params(args: Integer).void }
def sum(*args); end
```

### Keyword Rest Parameters (**kwargs)
```ruby
sig { params(kwargs: String).void }
def process(**kwargs); end
```

### Block Parameters
```ruby
sig { params(blk: T.proc.params(x: Integer).returns(String)).returns(T::Array[String]) }
def map_numbers(&blk); end

# Void block
sig { params(blk: T.proc.void).void }
def with_block(&blk); end
```

## Type Constructors

### T.nilable - Optional/Nullable
```ruby
sig { params(name: T.nilable(String)).void }
def greet(name); end
```

### T.any - Union Types
```ruby
sig { params(id: T.any(String, Integer)).returns(User) }
def find(id); end
```

### T.all - Intersection Types
```ruby
sig { params(obj: T.all(Enumerable, Comparable)).void }
def process(obj); end
```

### T.untyped - Unknown Type (avoid!)
```ruby
sig { params(data: T.untyped).returns(T.untyped) }
def process(data); end
```

## Collection Types

### T::Array
```ruby
sig { returns(T::Array[String]) }
def names; end
```

### T::Hash
```ruby
sig { returns(T::Hash[Symbol, Integer]) }
def scores; end
```

### T::Set
```ruby
sig { returns(T::Set[String]) }
def unique_names; end
```

### T::Range
```ruby
sig { returns(T::Range[Integer]) }
def valid_range; end
```

### T::Enumerable
```ruby
sig { params(items: T::Enumerable[String]).void }
def process(items); end
```

## Type Assertions in RBI

In RBI files, use `T.let` to declare types for class/instance variables:

```ruby
class MyClass
  extend T::Sig

  # Class variable
  @@count = T.let(0, Integer)

  # Instance variable declarations (in initialize signature context)
  sig { void }
  def initialize
    @name = T.let("", String)
    @users = T.let([], T::Array[User])
  end
end
```

## Class Methods

### Style 1: def self.method
```ruby
class User
  extend T::Sig

  sig { params(id: Integer).returns(User) }
  def self.find(id); end
end
```

### Style 2: class << self
```ruby
class User
  class << self
    extend T::Sig

    sig { params(id: Integer).returns(User) }
    def find(id); end
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
def to_s; end
```

## Interfaces and Mixins

### Interface Definition
```ruby
module Printable
  extend T::Sig
  extend T::Helpers

  interface!

  sig { abstract.returns(String) }
  def to_print; end
end
```

### Mixin with requires_ancestor
```ruby
module Loggable
  extend T::Sig
  extend T::Helpers

  requires_ancestor { Kernel }

  sig { params(message: String).void }
  def log(message); end
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
  def initialize(value); end

  sig { returns(Elem) }
  def value; end
end
```

### Generic with Bounds
```ruby
class Container
  extend T::Generic

  Elem = type_member { { upper: Comparable } }
end
```

## Special Types

- `T::Boolean` - true or false
- `T.noreturn` - method never returns (raises or loops forever)
- `T.self_type` - returns self
- `T.attached_class` - for class methods returning instances
- `T.class_of(MyClass)` - the class itself, not instances
- `T.type_parameter(:U)` - reference to a type parameter
