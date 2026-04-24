# Rails 4.2 → 5.0 Upgrade Guide

**Ruby Requirement:** 2.2.2+ (2.3+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Rails 5.0 is a major release with significant changes:
- **ActionCable** for WebSockets
- **API Mode** for JSON APIs
- **ApplicationRecord** base class
- **belongs_to required by default**
- **Turbolinks 5**
- **Rails command** instead of rake

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Ruby 2.2.2+ Required

**What Changed:**
Rails 5.0 requires Ruby 2.2.2 or later.

**Fix:**
```bash
rbenv install 2.3.8
rbenv local 2.3.8
```

**Common Issue:**
If you see `cannot load such file -- test/unit/assertions`, add:
```ruby
# Gemfile
gem 'test-unit'
```

---

#### 2. ApplicationRecord Base Class

**What Changed:**
Models now inherit from `ApplicationRecord` instead of `ActiveRecord::Base`.

**Fix:**

1. Create the ApplicationRecord class:
```ruby
# app/models/application_record.rb

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

2. Update all models:
```ruby
# BEFORE
class User < ActiveRecord::Base
end

# AFTER
class User < ApplicationRecord
end
```

---

#### 3. belongs_to Required by Default

**What Changed:**
`belongs_to` associations now require the associated record to exist.

**Detection Pattern:**
```ruby
class Post < ApplicationRecord
  belongs_to :author  # Now required!
end
```

**Fix:**

Add `optional: true` for nullable associations:
```ruby
# BEFORE (allowed nil)
belongs_to :parent_category

# AFTER (explicit optional)
belongs_to :parent_category, optional: true
```

Or disable globally (not recommended):
```ruby
# config/application.rb
config.active_record.belongs_to_required_by_default = false
```

---

#### 4. Strong Parameters Required

**What Changed:**
`protected_attributes` gem no longer works in Rails 5.

**Detection Pattern:**
```ruby
# Gemfile
gem 'protected_attributes'

# Models
attr_accessible :name, :email
```

**Fix:**
You MUST migrate to Strong Parameters before upgrading:

```ruby
# Remove from Gemfile
# gem 'protected_attributes'

# Remove from models
# attr_accessible :name, :email

# Add to controllers
class UsersController < ApplicationController
  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
```

**Tool:** Use [rails_upgrader](https://github.com/fastruby/rails_upgrader) gem to help automate this.

---

#### 5. Parameters No Longer HashWithIndifferentAccess

**What Changed:**
`params` is now `ActionController::Parameters`, not a hash.

**Detection Pattern:**
```ruby
# These may break
params.slice(:name, :email)
params.except(:id)
params.fetch(:user)
```

**Fix:**
Permit parameters first, then call hash methods:

```ruby
# BEFORE
params[:user].slice(:name, :email)

# AFTER
params.require(:user).permit(:name, :email).to_h.slice(:name, :email)
```

---

### 🟡 MEDIUM PRIORITY

#### 6. Controller Tests Changed

**What Changed:**
`assigns` and `assert_template` are extracted to a gem.

**Detection Pattern:**
```ruby
# In tests
assigns(:user)
assert_template 'index'
```

**Fix:**
```ruby
# Gemfile
gem 'rails-controller-testing', group: :test
```

---

#### 7. File Upload Testing Changed

**What Changed:**
Use `Rack::Test::UploadedFile` instead of `ActionDispatch::Http::UploadedFile`.

**Fix:**
```ruby
# BEFORE
ActionDispatch::Http::UploadedFile.new(...)

# AFTER
Rack::Test::UploadedFile.new(file_path, 'image/png')
```

---

#### 8. Callback Halting Changed

**What Changed:**
Returning `false` from a callback no longer halts the chain.

**Detection Pattern:**
```ruby
before_save :check_something

def check_something
  return false if invalid_condition  # No longer halts!
end
```

**Fix:**
```ruby
# BEFORE
def check_something
  return false if invalid_condition
end

# AFTER
def check_something
  throw :abort if invalid_condition
end
```

---

#### 9. Rails Command Replaces Rake

**What Changed:**
Use `rails` instead of `rake` for many commands.

**Old vs New:**
```bash
# BEFORE
rake db:migrate
rake test
rake routes

# AFTER (both work, but rails is preferred)
rails db:migrate
rails test
rails routes
```

---

## Gem Compatibility

Check gems at [RailsBump](https://railsbump.org/) before upgrading.

Common gems that need updating:

| Gem | Rails 4.2 | Rails 5.0 |
|-----|-----------|-----------|
| devise | 3.5+ | 4.2+ |
| cancancan | 1.15+ | 2.0+ |
| ransack | 1.7+ | 1.8+ |
| activeadmin | 1.0+ | 1.1+ |

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-50-upgrade

# Ensure Ruby 2.2.2+
ruby -v

# Check gem compatibility
# Visit railsbump.org
```

### Phase 2: Pre-requisites
1. **Migrate to Strong Parameters** (if using protected_attributes)
2. **Update callbacks** that return false
3. **Check gem compatibility**

### Phase 3: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 5.0.0'

# Add for testing
gem 'rails-controller-testing', group: :test
```

```bash
bundle update rails
```

### Phase 4: Create ApplicationRecord
```ruby
# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

Update all models to inherit from `ApplicationRecord`.

### Phase 5: Fix belongs_to
Add `optional: true` to associations that can be nil.

### Phase 6: Configuration
```bash
rails app:update
```

### Phase 7: Testing
- Run full test suite
- Test all forms and validations
- Test model associations
- Test callbacks

---

## belongs_to Migration Checklist

For each model with `belongs_to`:

- [ ] Check if association can be nil
- [ ] Add `optional: true` if nullable
- [ ] Test create/update without the association
- [ ] Verify validation messages

---

## Common Issues

### Issue: Validation Failed - Association Must Exist

**Error:** `Author must exist`

**Cause:** `belongs_to` is now required by default

**Fix:**
```ruby
belongs_to :author, optional: true
```

### Issue: ForbiddenAttributesError

**Error:** `ActiveModel::ForbiddenAttributesError`

**Cause:** Using params directly without permit

**Fix:**
```ruby
User.new(user_params)  # Use permitted params
```

### Issue: Callback Doesn't Stop Save

**Cause:** Returning `false` doesn't halt anymore

**Fix:**
```ruby
throw :abort  # Instead of return false
```

---

## New Features to Explore

After upgrading, consider using:

- **ActionCable** for real-time features
- **API Mode** for JSON-only APIs
- **ActiveRecord::Attributes** for custom types
- **ApplicationRecord** for shared model logic

---

## Resources

- [Rails 5.0 Release Notes](https://guides.rubyonrails.org/5_0_release_notes.html)
- [RailsDiff 4.2 to 5.0](http://railsdiff.org/4.2.10/5.0.7)
- [Strong Parameters Guide](https://guides.rubyonrails.org/action_controller_overview.html#strong-parameters)
