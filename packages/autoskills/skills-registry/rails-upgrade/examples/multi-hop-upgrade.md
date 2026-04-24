# Example: Multi-Hop Upgrade

**Scenario:** Upgrading from Rails 5.2 to Rails 8.0

---

## User Request

"Help me upgrade my Rails app from 5.2 to 8.0"

---

## Claude Response

### Important: Sequential Upgrade Required

I'll help you upgrade from Rails 5.2 to 8.0! This is a multi-hop upgrade that requires going through each version sequentially. **You cannot skip versions.**

### Your Upgrade Path

```
5.2 → 6.0 → 6.1 → 7.0 → 7.1 → 7.2 → 8.0
 |     |     |     |     |     |
Hop1  Hop2  Hop3  Hop4  Hop5  Hop6
```

### Estimated Timeline

| Hop | From → To | Difficulty | Time | Key Challenge |
|-----|-----------|------------|------|---------------|
| 1 | 5.2 → 6.0 | Hard | 1-2 weeks | Zeitwerk autoloader |
| 2 | 6.0 → 6.1 | Medium | 3-5 days | Minor changes |
| 3 | 6.1 → 7.0 | Hard | 1-2 weeks | Hotwire/Turbo |
| 4 | 7.0 → 7.1 | Medium | 3-5 days | Composite keys |
| 5 | 7.1 → 7.2 | Medium | 3-5 days | Transaction jobs |
| 6 | 7.2 → 8.0 | Very Hard | 1-2 weeks | Propshaft |

**Total Estimated Time:** 6-10 weeks

### Ruby Upgrade Required

Before starting, you'll need to upgrade Ruby:
- Rails 5.2: Ruby 2.2.2+
- Rails 6.0: Ruby 2.5.0+ required
- Rails 7.0: Ruby 2.7.0+ required
- Rails 7.2+: Ruby 3.1.0+ recommended
- Rails 8.0: Ruby 3.1.0+ required

**Recommended:** Upgrade to Ruby 3.2+ before starting.

### My Recommendation

1. **Upgrade Ruby first** to 3.2+
2. **Complete Hop 1 (5.2 → 6.0)** - This is the biggest change
3. **Quick hops through 6.1 → 7.0** - Focus on Hotwire migration
4. **Finish with 7.x → 8.0** - Asset pipeline migration

### Let's Start with Hop 1: Rails 5.2 → 6.0

This is the most critical upgrade due to Zeitwerk. Let me generate a detection script for Rails 6.0 changes.

---

## Detection Script for Hop 1 (5.2 → 6.0)

```bash
#!/bin/bash
# Rails 6.0 Detection Script

OUTPUT_FILE="rails_60_upgrade_findings.txt"

echo "================================================"
echo "Rails 6.0 Upgrade - Breaking Changes Detection"
echo "Project: $(basename $(pwd))"
echo "================================================"
echo ""

echo "🔴 HIGH PRIORITY - BREAKING CHANGES"
echo "==================================="

# Check require_dependency
echo "🔍 Checking: require_dependency usage"
REQUIRE_DEP_COUNT=$(grep -r 'require_dependency' app/ lib/ 2>/dev/null | wc -l)
if [ "$REQUIRE_DEP_COUNT" -gt 0 ]; then
  echo "   ⚠️  Found: $REQUIRE_DEP_COUNT occurrences"
  grep -rl 'require_dependency' app/ lib/ 2>/dev/null | sed 's/^/   - /'
  echo "   Fix: Remove require_dependency - Zeitwerk auto-loads files"
else
  echo "   ✅ None found"
fi

# Check classic autoloader
echo "🔍 Checking: Classic autoloader config"
CLASSIC_COUNT=$(grep -r 'config.autoloader.*:classic' config/ 2>/dev/null | wc -l)
if [ "$CLASSIC_COUNT" -gt 0 ]; then
  echo "   ⚠️  Found: $CLASSIC_COUNT occurrences"
  echo "   Fix: Remove or change to :zeitwerk"
else
  echo "   ✅ None found"
fi

# Check update_attributes
echo "🔍 Checking: update_attributes (deprecated)"
UPDATE_ATTR_COUNT=$(grep -r 'update_attributes[^_]' app/ lib/ 2>/dev/null | wc -l)
if [ "$UPDATE_ATTR_COUNT" -gt 0 ]; then
  echo "   ⚠️  Found: $UPDATE_ATTR_COUNT occurrences"
  grep -rl 'update_attributes[^_]' app/ lib/ 2>/dev/null | sed 's/^/   - /'
  echo "   Fix: Replace with update"
else
  echo "   ✅ None found"
fi

# Check before_filter
echo "🔍 Checking: before_filter (removed)"
BEFORE_FILTER_COUNT=$(grep -r 'before_filter\|after_filter\|skip_before_filter' app/controllers/ 2>/dev/null | wc -l)
if [ "$BEFORE_FILTER_COUNT" -gt 0 ]; then
  echo "   ⚠️  Found: $BEFORE_FILTER_COUNT occurrences"
  grep -rl 'before_filter\|after_filter\|skip_before_filter' app/controllers/ 2>/dev/null | sed 's/^/   - /'
  echo "   Fix: Replace with before_action, after_action, skip_before_action"
else
  echo "   ✅ None found"
fi

# Check Ruby version
echo ""
echo "📋 RUBY VERSION CHECK"
if [ -f ".ruby-version" ]; then
  RUBY_VER=$(cat .ruby-version)
  echo "Current Ruby: $RUBY_VER"
  echo "Required for Rails 6.0: 2.5.0+"
  echo "Recommended: 2.7.0+"
fi

echo ""
echo "📊 PROJECT STATS"
MODEL_COUNT=$(find app/models -name "*.rb" 2>/dev/null | wc -l)
CONTROLLER_COUNT=$(find app/controllers -name "*_controller.rb" 2>/dev/null | wc -l)
echo "Models: $MODEL_COUNT"
echo "Controllers: $CONTROLLER_COUNT"

echo ""
echo "Report saved to: $OUTPUT_FILE"
```

Run this script and share the results. After completing Hop 1 successfully, we'll move to Hop 2.

---

## Milestone Tracking

Track your progress through each hop:

### Hop 1: 5.2 → 6.0 (Zeitwerk)
- [ ] Ruby upgraded to 2.5+
- [ ] require_dependency removed
- [ ] Zeitwerk compatible naming
- [ ] update_attributes → update
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 2: 6.0 → 6.1
- [ ] Rails 6.1 in Gemfile
- [ ] load_defaults 6.1
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 3: 6.1 → 7.0 (Hotwire)
- [ ] Ruby upgraded to 2.7+
- [ ] Webpacker → Import Maps/jsbundling
- [ ] Turbolinks → Turbo
- [ ] rails-ujs removed
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 4: 7.0 → 7.1
- [ ] Rails 7.1 in Gemfile
- [ ] load_defaults 7.1
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 5: 7.1 → 7.2
- [ ] Transaction-aware jobs handled
- [ ] show_exceptions updated
- [ ] secrets → credentials
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 6: 7.2 → 8.0 (Propshaft)
- [ ] Ruby upgraded to 3.1+
- [ ] Sprockets → Propshaft (or keep Sprockets)
- [ ] SSL config updated
- [ ] All tests passing
- [ ] Deployed to staging
- [ ] 🎉 UPGRADE COMPLETE!

---

## Tips for Multi-Hop Success

1. **Complete each hop fully** before starting the next
2. **Deploy to staging** after each hop
3. **Run production for 1-2 weeks** on each version if possible
4. **Fix deprecation warnings** as you go
5. **Update gems incrementally** with each Rails version
6. **Keep detailed notes** of changes made

Ready to start? Share your detection script results for Hop 1 (5.2 → 6.0)!
