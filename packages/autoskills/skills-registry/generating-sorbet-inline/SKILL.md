---
name: generating-sorbet-inline
description: Generates or updates Sorbet inline type signatures directly in Ruby source files using sig blocks. Triggers when creating, updating, or maintaining inline type signatures for Ruby source files.
---

# Sorbet Inline Generation Skill

Generate or update Sorbet type signatures using `sig {}` blocks directly in Ruby source files. Supports both full generation from scratch and partial updates for individual changed files. Sorbet signatures are valid Ruby code that enable both static and runtime type checking.

# Instructions

When generating Sorbet inline signatures, always follow these steps.

Copy this checklist and track your progress:

```
Sorbet Inline Generation Progress:
- [ ] Step 1: Analyze the Ruby source
- [ ] Step 2: Add Sorbet signatures
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
- You MUST focus on method signatures only. Skip local variables, intermediate expressions, and other non-method annotations.
- You MUST NOT use or generate `.rbi` files. This skill is for inline signatures only.
- You MUST preserve the existing `# typed:` sigil level if one exists. Do not upgrade or change strictness without explicit user consent.
- You MUST use the tracking file when processing multiple files to ensure no files are missed.

## Multi-File Processing

When processing multiple Ruby files, create a tracking file to ensure all files are covered:

1. **Create tracking file** `.sorbet-inline-generation-todo.tmp`:
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
   rm .sorbet-inline-generation-todo.tmp
   ```

If interrupted, the tracking file allows resuming from where you left off.

## 1. Analyze the Ruby Source

Always perform this step.

Read and understand the Ruby source file:
- Identify all classes, modules, methods, constants and instance variables.
- Note inheritance, module inclusion and definitions based on metaprogramming.
- Note visibility modifiers - `public`, `private`, `protected`.
- Note existing `# typed:` sigil level at the top of the file.
- Note type parameters for generic classes.

## 2. Add Sorbet Signatures

Always perform this step.

1. First, check if the file already has a `# typed:` sigil at the top:
    - **If sigil exists**: Preserve the existing level. Do not change it without user consent.
    - **If no sigil exists**: Add `# typed: true` as a sensible default (allows gradual typing).

    Sigil levels (least to most strict): `ignore` < `false` < `true` < `strict` < `strong`

2. Add `extend T::Sig` to the class/module:
    ```ruby
    class MyClass
      extend T::Sig
    end
    ```

3. Then add type signatures using `sig {}` blocks:

**Example - Before:**
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

**Example - After:**
```ruby
# typed: true

class User
  extend T::Sig

  sig { returns(String) }
  attr_reader :name

  sig { returns(Integer) }
  attr_reader :age

  sig { params(name: String, age: Integer).void }
  def initialize(name, age)
    @name = name
    @age = age
  end

  sig { params(greeting: String).returns(String) }
  def greet(greeting)
    "#{greeting}, #{@name}!"
  end
end
```

- Focus on method and attribute signatures only
- See [syntax.md](reference/syntax.md) for the full Sorbet syntax guide

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
- Instance variable initialization

Fix any errors reported and repeat until validation passes.

# References

- [syntax.md](reference/syntax.md) - Sorbet signature syntax guide
- [sorbet_examples/](reference/sorbet_examples/STRUCTURE.md) - Real-world Sorbet examples from production gems
- [Sorbet documentation](https://sorbet.org/docs/overview) - Official Sorbet docs
