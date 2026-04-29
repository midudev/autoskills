# Zod Best Practices Skill

A comprehensive guide for using Zod effectively in TypeScript applications. This skill provides 42 rules across 8 categories, organized by impact to help AI agents and developers write better validation code.

## Overview

Zod is a TypeScript-first schema declaration and validation library. This skill covers best practices for:

- **Schema Definition**: Choosing correct types, avoiding `z.any()`, proper string validations
- **Parsing & Validation**: Using `safeParse()`, async validation, error handling
- **Type Inference**: Leveraging `z.infer`, distinguishing input/output types
- **Error Handling**: Custom messages, internationalization, form error display
- **Object Schemas**: strict/strip modes, partial updates, discriminated unions
- **Schema Composition**: Reusable schemas, intersections, recursive types
- **Refinements & Transforms**: Custom validation, data transformation
- **Performance**: Caching, Zod Mini, lazy loading, batch validation

## Usage

### For Claude Code / AI Agents

The skill is automatically loaded when working with Zod code. Reference specific rules:

```
See rules/parse-use-safeparse.md for safeParse best practices
```

### For Developers

Read `SKILL.md` for a quick reference, or `AGENTS.md` for the full compiled guide.

## File Structure

```
zod/
├── SKILL.md          # Quick reference with rule index
├── AGENTS.md         # Full compiled guide (all rules)
├── metadata.json     # Version, categories, references
├── README.md         # This file
└── rules/
    ├── _sections.md  # Category definitions
    ├── _template.md  # Rule template
    ├── schema-*.md   # Schema definition rules
    ├── parse-*.md    # Parsing rules
    ├── type-*.md     # Type inference rules
    ├── error-*.md    # Error handling rules
    ├── object-*.md   # Object schema rules
    ├── compose-*.md  # Composition rules
    ├── refine-*.md   # Refinement rules
    └── perf-*.md     # Performance rules
```

## Rule Categories

| Priority | Category | Rules | Impact |
|----------|----------|-------|--------|
| 1 | Schema Definition | 6 | CRITICAL |
| 2 | Parsing & Validation | 6 | CRITICAL |
| 3 | Type Inference | 5 | HIGH |
| 4 | Error Handling | 5 | HIGH |
| 5 | Object Schemas | 6 | MEDIUM-HIGH |
| 6 | Schema Composition | 5 | MEDIUM |
| 7 | Refinements & Transforms | 5 | MEDIUM |
| 8 | Performance & Bundle | 5 | LOW-MEDIUM |

## Key Principles

1. **Type Safety First**: Always use `z.infer`, never duplicate types manually
2. **Validate at Boundaries**: Parse external data immediately at entry points
3. **User-Friendly Errors**: Provide custom messages, collect all issues
4. **Single Source of Truth**: Schema defines validation AND TypeScript types
5. **Composition Over Duplication**: Use extend, pick, omit, partial

## References

- [Zod Official Documentation](https://zod.dev/)
- [Zod v4 Release Notes](https://zod.dev/v4)
- [Zod GitHub](https://github.com/colinhacks/zod)
- [Zod Mini](https://zod.dev/packages/mini)
