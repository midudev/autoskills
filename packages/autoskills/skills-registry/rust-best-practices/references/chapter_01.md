# Chapter 1 - Coding Styles and Idioms

## 1.1 Borrowing Over Cloning

Rust's ownership system encourages **borrow** (`&T`) instead of **cloning** (`T.clone()`). 
> ❗ Performance recommendation

### ✅ When to `Clone`:

* You need to change the object AND preserve the original object (immutable snapshots).
* When you have `Arc` or `Rc` pointers.
* When data is shared across threads, usually `Arc`.
* Avoid massive refactoring of non performance critical code.
* When caching results (dummy example below):
```rust
fn get_config(&self) -> Config {
    self.cached_config.clone()
}
```
* When the underlying API expects Owned Data.

### 🚨 `Clone` traps to avoid:

* Auto-cloning inside loops `.map(|x| x.clone)`, prefer to call `.cloned()` or `.copied()` at the end of the iterator.
* Cloning large data structures like `Vec<T>` or `HashMap<K, V>`.
* Clone because of bad API design instead of adjusting lifetimes.
* Prefer `&[T]` instead of `Vec<T>` or `&Vec<T>`.
* Prefer `&str` or `&String` instead of `String`.
* Prefer `&T` instead of `T`.
* Clone a reference argument, if you need ownership, make it explicit in the arguments for the caller. Example:
```rust
fn take_a_borrow(thing: &Thing) {
    let thing_cloned = thing.clone(); // the caller should have passed ownership instead
}
```

### ✅ Prefer borrowing:
```rust
fn process(name: &str) {
    println!("Hello {name}");
}

let user = String::from("foo");
process(&user);
```

### ❌ Avoid redundant cloning:
```rust
fn process_string(name: String) {
    println!("Hello {name}");
}

let user = String::from("foo");
process(user.clone()); // Unnecessary clone
```

## 1.2 When to pass by value? (Copy trait)

Not all types should be passed by reference (`&T`). If a type is **small** and it is **cheap to copy**, it is often better to **pass it by value**. Rust makes it explicit via the `Copy` trait.

### ✅ When to pass by value, `Copy`:
* The type **implements** `Copy` (`u32`, `bool`, `f32`, small structs).
* The cost of moving the value is negligible.

```rust
fn increment(x: u32) -> u32 {
    x + 1
}

let num = 1;
let new_num = increment(num); // `num` still usable after this point
```

### ❓ Which structs should be `Copy`?
* When to consider declaring `Copy` on your own types:
* All fields are `Copy` themselves.
* The struct is `small`, up to 2 (maybe 3) words of memory or 24 bytes (each word is 64 bits/8bytes).
* The struct **represents a "plain data object"**, without resourcing to ownership (no heap allocations. Example: `Vec` and `Strings`).

❗**Rust Arrays are stack allocated.** Which means they can be copied if their underlying type is `Copy`, but this will be allocated in the program stack which can easily become a stack overflow. More on [Chapter 3 - Stack vs Heap](./chapter_03.md#33-stack-vs-heap-be-size-smart)

For reference, each primitive type size in bytes:

#### Integers:

| Type | Size |
|------------- |---------- |
| i8 u8 | 1 byte |
| i16 u16 | 2 bytes |
| i32 u32 | 4 bytes |
| i64 u64 | 8 bytes |
| isize usize | Arch |
| i128 u128 | 16 bytes |

#### Floating Point:

| Type | Size |
|---------- |---------- |
| f32 | 4 bytes |
| f64 | 8 bytes |


#### Other:

| Type | Size |
|---------- |---------- |
| bool | 1 byte |
| char | 4 bytes |


### ✅ Good struct to derive `Copy`:
```rust
#[derive(Debug, Copy, Clone)]
struct Point {
    x: f32,
    y: f32,
    z: f32
}
```

### ❌ Bad struct to derive `Copy`:
```rust
#[derive(Debug, Clone)]
struct BadIdea {
    age: i32,
    name: String, // String is not `Copy`
}
```

### ❓Which Enums should be `Copy`?
* If your enum acts like tags and atoms.
* The enum payloads are all `Copy`.
* **❗Enums size are based on their largest element.**

### ✅ Good Enum to derive
```rust
#[derive(Debug, Copy, Clone)]
enum Direction {
    North,
    South,
    East,
    West,
}
```

## 1.3 Handling `Option<T>` and `Result<T, E>`
Rust 1.65 introduced a better way to safely unpack Option and Result types with the `let Some(x) = … else { … }` or `let Ok(x) = … else { … }` when you have a default `return` value, `continue` or `break` default else case. It allows early returns when the missing case is **expected and normal**, not exceptional.

### ✅ Cases to use each pattern matching for Option and Return
* Use `match` when you want to pattern match against the inner types `T` and `E`
```rust
match self {
    Ok(Direction::South) => { … },
    Ok(Direction::North) => { … },
    Ok(Direction::East) => { … },
    Ok(Direction::West) => { … },
    Err(E::One) => { … },
    Err(E::Two) => { … },
}

match self {
    Some(3|5) => { … }
    Some(x) if x > 10 => { … }
    Some(x) => { … }
    None => { … }
}
```

* Use `match` when your type is transformed into something more complex Like `Result<T, E>` becoming `Result<Option<T>, E>`.
```rust
match self {
    Ok(t) => Ok(Some(t)),
    Err(E::Empty) => Ok(None),
    Err(err) => Err(err),
}
```

* Use `let PATTERN = EXPRESSION else { DIVERGING_CODE; }` when the divergent code doesn't need to know about the failed pattern matches or doesn't need extra computation:
```rust
let Some(&Direction::North) = self.direction.as_ref() else {
    return Err(DirectionNotAvailable(self.direction));
}
```

* Use `let PATTERN = EXPRESSION else { DIVERGING_CODE; }` when you want to break or continue a pattern match
```rust
for x in self {
    let Some(x) = x else {
        continue;
    }
}
```

* Use `if let PATTERN = EXPRESSION else { DIVERGING_CODE; }` when `DIVERGING_CODE` needs extra computation:
```rust
if let Some(x) = self.next() {
    // computation
} else {
    // computation when `None/Err` or not matched
}
```

❗**If you don't care about the value of the `Err` case, please use `?` to propagate the `Err` to the caller.**

### ❌ Bad Option/Return pattern matching:

* Conversion between Result and Option (prefer `.ok()`,`.ok_or()`, and `ok_or_else()`)
```rust
match self {
    Ok(t) => Some(t),
    Err(_) => None
}
```

* `if let PATTERN = EXPRESSION else { DIVERGING_CODE; }` when divergent code is a default or pre-computed value (prefer `let PATTERN = EXPRESSION else { DIVERGING_CODE; }`):
```rust
if let Some(values) = self.next() {
    // computation
    (Some(..), values)
} else {
    (None, Vec::new())
}
```

* Using `unwrap` or `expect` outside tests:
```rust
let port = config.port.unwrap();
```

## 1.4 Prevent Early Allocation

When dealing with functions like `or`, `map_or`, `unwrap_or`, `ok_or`, consider that they have special cases for when memory allocation is required, like creating a new string, creating a collection or even calling functions that manage some state, so they can be replaced with their `_else` counter-part:

### ✅ Good cases

```rust
let x = None;
assert_eq!(x.ok_or(ParseError::ValueAbsent), Err(ParseError::ValueAbsent));

let x = None;
assert_eq!(x.ok_or_else(|| ParseError::ValueAbsent(format!("this is a value {x}"))), Err(ParseError::ValueAbsent));


let x: Result<_, &str> = Ok("foo");
assert_eq!(x.map_or(42, |v| v.len()), 3);


let x : Result<_, String> = Ok("foo");
assert_eq!(x.map_or_else(|e|format!("Error: {e}"), |v| v.len()), 3);

let x = "1,2,3,4";
assert_eq!(x.parse_to_option_vec.unwrap_or_else(Vec::new), Ok(vec![1, 2, 3, 4]));
```

### ❌ Bad cases

```rust
let x : Result<_, String> = Ok("foo");
assert_eq!(x.map_or(format!("Error with uninformed content"), |v| v.len()), 3);

let x = "1,2,3,4";
assert_eq!(x.parse_to_option_vec.unwrap_or(Vec::new()), Ok(vec![1, 2, 3, 4])); // could be replaced with `.unwrap_or_default`

let x = None;
assert_eq!(x.ok_or(ParseError::ValueAbsent(format!("this is a value {x}"))), Err(ParseError::ValueAbsent));
```

### Mapping Err

When dealing with Result::Err, sometimes is necessary to log and transform the Err into a more abstract or more detailed error, this can be done with `inspect_err` and `map_err`:

```rust
let x = Err(ParseError::InvalidContent(...));

x
    .inspect_err(|err| tracing::error!("function_name: {err}"))
    .map_err(|err| GeneralError::from(("function_name", err)))?;
```

## 1.5 Iterator, `.iter` vs `for`

First we need to understand a basic loop with each one of them. Let's consider the following problem, we need to sum all even numbers between 0 and 10 incremented by 1:

* `for`:
```rust
let mut sum = 0;
for x in 0..=10 {
    if x % 2 == 0 {
        sum += x + 1;
    }
}
```

* `iter`:
```rust
let sum: i32 = (0..=10)
    .filter(|x| x % 2 == 0)
    .map(|x| x + 1)
    .sum();
```

> Both versions do the same thing and are correct and idiomatic, but each shines in different contexts.

### When to prefer `for` loops
* When you need **early exits** (`break`, `continue`, `return`).
* **Simple iteration** with side-effects (e.g., logging, IO)
    * logging can be done correctly in `Iterators` using `inspect` and `inspect_err` functions.
* When readability matters more than simplicity or chaining.

#### Example:
```rust
for value in &mut value {
    if *value == 0 {
        break;
    }
    *value += fancy_equation();
}
```

### When to prefer `iterators` loops (`.iter()` and `.into_iter()`)
* When you are `transforming collections` or `Option/Results`.
* You can **compose multiple steps** elegantly.
* No need for early exits.
* You need support for indexed values with `.enumerate`.
```rust
let values: Vec<_> = vec.into_iter()
    .enumerate()
    .filter(|(_index, value)| value % 2 == 0)
    .map(|(index, value)| value % index)
    .collect()
```
* You need to use collections functions like `.windows` or `chunks`.
* You need to combine data from multiple sources and don't want to allocate multiple collections.
* Iterators can be combined with `for` loops:
```rust
for value in vec.iter().enumerate()
    .filter(|(index, value)| value % index == 0) {
    // ...
}
```

> #### ❗REMEMBER: Iterators are Lazy
>
> * `.iter`, `.map`, `.filter` don't do anything until you call its consumer, e.g. `.collect`, `.sum`, `.for_each`.
> * **Lazy Evaluation** means that iterator chains are fused into one loop at compile time.

### 🚨 Anti-patterns to AVOID

* Don't chain without formatting. Prefer each chained function on its own line with the correct indentation (`rustfmt` should take care of this).
* Don't chain if it makes the code unreadable.
* Avoid needlessly collect/allocate of a collection (e.g. vector) just to throw it away later by some larger operation or by another iteration.
* Prefer `iter` over `into_iter` unless you don't need the ownership of the collection.
* Prefer `iter` over `into_iter` for collections that inner type implements `Copy`, e.g. `Vec<i32>`.
* For summing numbers prefer `.sum` over `.fold`. `.sum` is specialized for summing values, so the compiler knows it can make optimizations on that front, while fold has a blackbox closure that needs to be applied at every step. If you need to sum by an initial value, just added in the expression `let my_sum = [1, 2, 3].sum() + 3`.

## 1.6 Comments: Context, not Clutter

> "Context are for why, not what or how"

Well-written Rust code, with expressive types and good naming, often speaks for itself. Many high-quality codebases thrive on **few or no comments**. And that's a good thing.

Still, there are **moments where code alone isn't enough** - when there are performance quirks, external constraints, or non-obvious tradeoffs that require a nudge to the reader. In those cases, a concise comment can prevent hours of head-scratching or searching git history.

### ✅ Good comments 

* Safety concerns:
```rust
// SAFETY: We have checked that the pointer is valid and non-null. @Function xyz.
unsafe { std::ptr::copy_nonoverlapping(src, dst, len); }
```

* Performance quirks:
```rust
// This algorithm is a fast square root approximation
const THREE_HALVES: f32 = 1.5;
fn q_rsqrt(number: f32 ) -> f32 {
    let mut i: i32 = number.to_bits() as i32;
    i = 0x5F375A86_i32.wrapping_sub(i >> 1);
    let y = f32::from_bits(i as u32);
    y * (THREE_HALVES - (number * 0.5 * y * y))
}
```

* Clear code beats comments. However, when the why isn't obvious, say it plainly - or link to where:
```rust
// PERF: Generating the root store per subgraph caused high TLS startup latency on MacOS
// This works as a caching alternative. See: [ADR-123](link/to/adr-123)
let subgraph_tls_root_store: RootCertStore = configuration
    .tls
    .subgraph
    .all
    .create_certificate_store()
    .transpose()?
    .unwrap_or_else(crate::services::http::HttpClientService::native_roots_store);
```

### ❌ Bad comments

* Wall-of-text explanations: long comments and multiline comments
```rust
// Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
// Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
// when an unknown printer took a galley
fn do_something_odd() {
    …
}
```
> Prefer `/// doc` comment if it's describing the function.

* Comments that could be better represented as functions or are plain obvious
```rust
fn computation() {
    // increment i by 1
    i += 1;
}
```

### ✅ Breaking up long functions over commenting them

If you find yourself writing a long comment explaining "what", "how" or "each step" in a function, it might be time to split it. So the suggestion is to refactor. This can be beneficial not only for readability, but testability:

#### ❌ Instead of:
```rust
fn process_request(request: T) {
    // We first need to validate request, because of corner case x, y, z
    // As the payload can only be decoded when they are valid
    // Then we can perform authorization on the payload
    // lastly with the authorized payload we can dispatch to handler
}
```

#### ✅ Prefer
```rust
fn process_request(request: T) -> Result<(), Error> {
    validate_request_headers(&request)?;
    let payload = decode_payload(&request);
    authorize(&payload)?;
    dispatch_to_handler(payload)
}

#[cfg(test)]
mod tests {
    #[test]
    fn validate_request_happy_path() { ... }

    #[test]
    fn validate_request_fails_on_x() { ... }

    #[test]
    fn validate_request_fails_on_y() { ... }

    #[test]
    fn decode_validated_request() { ... }

    #[test]
    fn authorize_payload_xyz() { ... }
}
```

Let **structure** and **naming** replace commentary, and enhance its documentation with **tests as living documentation**.

### 📝 TODOs are not comments - track them properly

Avoid leaving lingering `// TODO: Lorem Ipsum` comments in the code. Instead:
* Turn them into Jira or Github Issues.
* If needed, to avoid future confusion, reference the issue in the code and the code in the issue.

```rust
// See issue #123: support hyper 2.0
```

This helps keeping the code clean and making sure tasks are not forgotten.

### Comments as Living Documentation

There are a few gotchas when calling comments "living documentation":
* Code evolves.
* Context changes.
* Comments get stale.
* Many large comments make people avoid reading them.
* Team becomes fearful of delete irrelevant comments.

If you find a comment, **don't trust it blindly**. Read it in context. If it's wrong or outdated, fix or remove it. A misleading comment is worse than no comments at all. 

> Comments should bother you - they demand re-verification, just like stale tests.

When deeper justification is needed, prefer to:
* **Link to a Design Doc or an ADR**, business logic lives well in design docs while performance tradeoffs live well in ADRs.
* Move runtime example and usage docs into Rust Docs, `/// doc comment`, where they can be tested and kept up-to-date by tools like `cargo doc`.

> Doc-comments and Doc-testing, `///` and `//!` in [Chapter 8 - Comments vs Documentation](./chapter_08.md)

## 1.7 Use Declarations - "imports"

Different languages have different ways of sorting their imports, in the Rust ecosystem the [standard way](https://github.com/rust-lang/rustfmt/issues/4107) is:

- `std` (`core`, `alloc` would also fit here).
- External crates (what is in your Cargo.toml `[dependencies]`).
- Workspace crates (workspace member crates).
- This module `super::`.
- This module `crate::`.

```rust
// std
use std::sync::Arc;

// external crates
use chrono::Utc;
use juniper::{FieldError, FieldResult};
use uuid::Uuid;

// crate code lives in workspace
use broker::database::PooledConnection;

// super:: / crate::
use super::schema::{Context, Payload};
use super::update::convert_publish_payload;
use crate::models::Event;
```

Some enterprise solutions opt to include their core packages after `std`, so all external packages that start with enterprise name are located before the others:

```rust
// std
use std::sync::Arc;

// enterprise external crates
use enterprise_crate_name::some_module::SomeThing;

// external crates
use chrono::Utc;
use juniper::{FieldError, FieldResult};
use uuid::Uuid;

// crate code lives in workspace
use broker::database::PooledConnection;

// super:: / crate::
use super::schema::{Context, Payload};
use super::update::convert_publish_payload;
use crate::models::Event;
```

One way of not having to manually control this is using the following arguments in your `rustfmt.toml`:

```toml
reorder_imports = true
imports_granularity = "Crate"
group_imports = "StdExternalCrate"
```

> As of Rust version 1.88, it is necessary to execute rustfmt in nightly to correctly reorder code `cargo +nightly fmt`.
