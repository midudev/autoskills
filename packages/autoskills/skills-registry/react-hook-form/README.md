# React Hook Form Best Practices Skill

Performance optimization guidelines for React Hook Form applications.

## Overview

This skill provides 41 performance rules across 8 categories, designed to help AI agents and developers write performant React Hook Form code.

### Directory Structure

```
react-hook-form/
├── SKILL.md           # Entry point with quick reference
├── AGENTS.md          # Compiled comprehensive guide
├── metadata.json      # Version, org, references
├── README.md          # This file
└── rules/
    ├── _sections.md   # Category definitions
    ├── _template.md   # Rule template
    ├── config-*.md    # Form configuration rules (6)
    ├── sub-*.md       # Field subscription rules (7)
    ├── ctrl-*.md      # Controlled component rules (5)
    ├── valid-*.md     # Validation pattern rules (6)
    ├── array-*.md     # Field array rules (5)
    ├── state-*.md     # State management rules (5)
    ├── integ-*.md     # Integration pattern rules (4)
    └── adv-*.md       # Advanced pattern rules (3)
```

## Getting Started

### Installation

```bash
pnpm install
```

### Build AGENTS.md

```bash
pnpm build
```

### Validate Skill

```bash
pnpm validate
```

## Creating a New Rule

1. Choose the appropriate category prefix:

| Category | Prefix | Impact |
|----------|--------|--------|
| Form Configuration | `config-` | CRITICAL |
| Field Subscription | `sub-` | CRITICAL |
| Controlled Components | `ctrl-` | HIGH |
| Validation Patterns | `valid-` | HIGH |
| Field Arrays | `array-` | MEDIUM-HIGH |
| State Management | `state-` | MEDIUM |
| Integration Patterns | `integ-` | MEDIUM |
| Advanced Patterns | `adv-` | LOW |

2. Create a new file: `rules/{prefix}-{description}.md`

3. Use the rule template from `rules/_template.md`

## Rule File Structure

```markdown
---
title: Rule Title Here
impact: CRITICAL|HIGH|MEDIUM-HIGH|MEDIUM|LOW-MEDIUM|LOW
impactDescription: Quantified impact (e.g., "2-10× improvement")
tags: prefix, keyword1, keyword2
---

## Rule Title Here

Brief explanation of WHY this matters (1-3 sentences).

**Incorrect (description of problem):**

\`\`\`typescript
// Bad code with comment on key line
\`\`\`

**Correct (description of solution):**

\`\`\`typescript
// Good code with minimal diff from incorrect
\`\`\`

Reference: [Documentation Link](https://example.com)
```

## File Naming Convention

Rules follow the pattern: `{prefix}-{slug}.md`

- **prefix**: Category identifier (3-8 chars) from `_sections.md`
- **slug**: Kebab-case description of the rule

Examples:
- `config-validation-mode.md`
- `sub-usewatch-over-watch.md`
- `ctrl-usecontroller-isolation.md`

## Impact Levels

| Level | Description |
|-------|-------------|
| CRITICAL | Cascade effect on entire form performance |
| HIGH | Significant impact on specific operations |
| MEDIUM-HIGH | Notable improvement for common patterns |
| MEDIUM | Measurable improvement in specific scenarios |
| LOW-MEDIUM | Minor optimization for edge cases |
| LOW | Best practice with minimal performance impact |

## Scripts

| Command | Description |
|---------|-------------|
| `pnpm build` | Compile rules into AGENTS.md |
| `pnpm validate` | Check skill against quality guidelines |

## Contributing

1. Read existing rules in the same category for style consistency
2. Ensure incorrect/correct examples have minimal diff
3. Quantify impact where possible
4. Include authoritative reference links
5. Run validation before submitting

## Acknowledgments

Based on official React Hook Form documentation and community best practices.
