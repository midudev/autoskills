---
name: generating-sorbet
description: Generates or updates Sorbet type signatures in separate .rbi files. Triggers when creating, updating, or maintaining type signatures for Ruby source files.
---

# Sorbet RBI Generation Skill

Generate or update Sorbet type signatures in separate `.rbi` files. Supports both full generation from scratch and partial updates for individual changed files. RBI files are used when you cannot or should not modify the original Ruby source - such as for gems, generated code, or legacy codebases.

# Instructions

When generating Sorbet RBI signatures, always follow these steps.

Copy this checklist and track your progress:

```
Sorbet RBI Generation Progress:
- [ ] Step 1: Analyze the Ruby source
- [ ] Step 2: Generate RBI files
- [ ] Step 3: Eliminate `T.untyped` in signatures
- [ ] Step 4: Review and refine signatures
- [ ] Step 5: Validate signatures with Sorbet
```

## Rules

- You MUST NOT run Ruby code of the project.
- You MUST NOT use `T.untyped`. Infer the proper type instead.
- You MUST NOT use `T.unsafe` - it bypasses type checking entirely.
- You MUST NOT use `T.cast` - it forces types without verification.
- You MUST ask the user to provide more details if something is not clear.
- You MUST prepend any command with `bundle exec` if the project has Gemfile.
- You MUST use `sig { }` block syntax for method signatures.
- You MUST add `extend T::Sig` to classes/modules before using `sig`.
- You MUST NOT add method bodies in RBI files - only signatures and empty method definitions.
- You MUST place RBI files in `./rbi` directory.
- You MUST use the tracking file when processing multiple files to ensure no files are missed.

## Multi-File Processing

When processing multiple Ruby files, create a tracking file to ensure all files are covered:

1. **Create tracking file** `.sorbet-rbi-generation-todo.tmp`:
   ```
   [ ] app/models/user.rb
   [ ] app/models/post.rb
   [ ] app/services/auth_service.rb
   ```

2. **Process files one by one**:
   - Take the next pending `[ ]` entry
   - Complete all steps (1-5) for that file
   - Mark as processed `[x]`
   - Save the tracking file
   - Continue to next pending entry

3. **Cleanup**: Remove the tracking file after all files are processed:
   ```bash
   rm .sorbet-rbi-generation-todo.tmp
   ```

If interrupted, the tracking file allows resuming from where you left off.

## 1. Analyze the Ruby Source

Always perform this step.

Read and understand the Ruby source file:
- Identify all classes, modules, methods, constants and instance variables.
- Note inheritance, module inclusion and definitions based on metaprogramming.
- Note visibility modifiers - `public`, `private`, `protected`.
- Note type parameters for generic classes.

## 2. Generate RBI Files

Always perform this step.

1. Determine the correct RBI directory:

    Place RBI files in `./rbi` directory. Sorbet reads all `.rbi` files from this location.

    RBI files are needed to describe code Sorbet cannot understand statically:
    - Gem definitions
    - Methods created with `define_method` or `method_missing`
    - Constants from `const_get`/`const_set`
    - Dynamic ancestors added via `extend`
    - DSL-generated methods (Rails, ActiveRecord, etc.)

2. Create the RBI file with typed sigil:
    ```ruby
    # typed: strict
    ```

3. Add `extend T::Sig` to each class/module:
    ```ruby
    class MyClass
      extend T::Sig
    end
    ```

4. Add method stubs with signatures (no method bodies):

**Example - Ruby Source:**
```ruby
class User
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def greet(greeting)
    "#{greeting}, #{@name}!"
  end
end
```

**Example - RBI File (`rbi/user.rbi`):**
```ruby
# typed: strict

class User
  extend T::Sig

  sig { returns(String) }
  attr_reader :name

  sig { returns(Integer) }
  attr_reader :age

  sig { params(name: String, age: Integer).void }
  def initialize(name, age); end

  sig { params(greeting: String).returns(String) }
  def greet(greeting); end
end
```

- RBI files mirror structure but contain only signatures and empty method stubs
- See [syntax.md](reference/syntax.md) for the full Sorbet RBI syntax guide

## 3. Eliminate `T.untyped` in Signatures

Always perform this step.

- Review all signatures and replace `T.untyped` with proper types.
- Use code context, method calls, and tests to infer types.
- Use `T.untyped` only as a last resort when type cannot be determined.

## 4. Review and Refine Signatures

Always perform this step.

- Verify signatures are correct, coherent, and complete.
- Remove unnecessary `T.untyped` types.
- Ensure all methods and attributes have signatures.
- Verify class hierarchy and module inclusions match the source.
- Fix any errors and repeat until signatures are correct.

## 5. Validate Signatures with Sorbet

Always perform this step.

Run Sorbet type checker to validate signatures:

```bash
srb tc
```

Or with bundle:

```bash
bundle exec srb tc
```

This checks:
- Signature syntax correctness
- Type consistency
- Method parameter/return type matching
- Class/module structure matching source

Fix any errors reported and repeat until validation passes.

# References

- [syntax.md](reference/syntax.md) - Sorbet RBI syntax guide
- [references/](reference/references/STRUCTURE.md) - Real-world RBI examples from stripe-ruby
- [Sorbet RBI documentation](https://sorbet.org/docs/rbi) - Official RBI docs
