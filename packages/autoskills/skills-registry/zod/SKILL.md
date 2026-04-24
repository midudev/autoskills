---
name: zod
description: Zod schema validation best practices for type safety, parsing, and error handling. This skill should be used when defining z.object schemas, using z.string validations, safeParse, or z.infer. This skill does NOT cover React Hook Form integration patterns (use react-hook-form skill) or OpenAPI client generation (use orval skill).
---

# Zod Best Practices

Comprehensive schema validation guide for Zod in TypeScript applications. Contains 43 rules across 8 categories, prioritized by impact to guide automated refactoring and code generation.

## When to Apply

Reference these guidelines when:
- Writing new Zod schemas
- Choosing between parse() and safeParse()
- Implementing type inference with z.infer
- Handling validation errors for user feedback
- Composing complex object schemas
- Using refinements and transforms
- Optimizing bundle size and validation performance
- Reviewing Zod code for best practices

## Rule Categories by Priority

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Schema Definition | CRITICAL | `schema-` |
| 2 | Parsing & Validation | CRITICAL | `parse-` |
| 3 | Type Inference | HIGH | `type-` |
| 4 | Error Handling | HIGH | `error-` |
| 5 | Object Schemas | MEDIUM-HIGH | `object-` |
| 6 | Schema Composition | MEDIUM | `compose-` |
| 7 | Refinements & Transforms | MEDIUM | `refine-` |
| 8 | Performance & Bundle | LOW-MEDIUM | `perf-` |

## Quick Reference

### 1. Schema Definition (CRITICAL)

- `schema-use-primitives-correctly` - Use correct primitive schemas for each type
- `schema-use-unknown-not-any` - Use z.unknown() instead of z.any() for type safety
- `schema-avoid-optional-abuse` - Avoid overusing optional fields
- `schema-string-validations` - Apply string validations at schema definition
- `schema-use-enums` - Use enums for fixed string values
- `schema-coercion-for-form-data` - Use coercion for form and query data

### 2. Parsing & Validation (CRITICAL)

- `parse-use-safeparse` - Use safeParse() for user input
- `parse-async-for-async-refinements` - Use parseAsync for async refinements
- `parse-handle-all-issues` - Handle all validation issues not just first
- `parse-validate-early` - Validate at system boundaries
- `parse-avoid-double-validation` - Avoid validating same data twice
- `parse-never-trust-json` - Never trust JSON.parse output

### 3. Type Inference (HIGH)

- `type-use-z-infer` - Use z.infer instead of manual types
- `type-input-vs-output` - Distinguish z.input from z.infer for transforms
- `type-export-schemas-and-types` - Export both schemas and inferred types
- `type-branded-types` - Use branded types for domain safety
- `type-enable-strict-mode` - Enable TypeScript strict mode

### 4. Error Handling (HIGH)

- `error-custom-messages` - Provide custom error messages
- `error-use-flatten` - Use flatten() for form error display
- `error-path-for-nested` - Use issue.path for nested error location
- `error-i18n` - Implement internationalized error messages
- `error-avoid-throwing-in-refine` - Return false instead of throwing in refine

### 5. Object Schemas (MEDIUM-HIGH)

- `object-strict-vs-strip` - Choose strict() vs strip() for unknown keys
- `object-partial-for-updates` - Use partial() for update schemas
- `object-pick-omit` - Use pick() and omit() for schema variants
- `object-extend-for-composition` - Use extend() for adding fields
- `object-optional-vs-nullable` - Distinguish optional() from nullable()
- `object-discriminated-unions` - Use discriminated unions for type narrowing

### 6. Schema Composition (MEDIUM)

- `compose-shared-schemas` - Extract shared schemas into reusable modules
- `compose-intersection` - Use intersection() for type combinations
- `compose-lazy-recursive` - Use z.lazy() for recursive schemas
- `compose-preprocess` - Use preprocess() for data normalization
- `compose-pipe` - Use pipe() for multi-stage validation

### 7. Refinements & Transforms (MEDIUM)

- `refine-vs-superrefine` - Choose refine() vs superRefine() correctly
- `refine-transform-coerce` - Distinguish transform() from refine() and coerce()
- `refine-add-path` - Add path to refinement errors
- `refine-defaults` - Use default() for optional fields with defaults
- `refine-catch` - Use catch() for fault-tolerant parsing

### 8. Performance & Bundle (LOW-MEDIUM)

- `perf-cache-schemas` - Cache schema instances
- `perf-zod-mini` - Use Zod Mini for bundle-sensitive applications
- `perf-avoid-dynamic-creation` - Avoid dynamic schema creation in hot paths
- `perf-lazy-loading` - Lazy load large schemas
- `perf-arrays` - Optimize large array validation

## How to Use

Read individual reference files for detailed explanations and code examples:

- [Section definitions](references/_sections.md) - Category structure and impact levels
- [Rule template](assets/templates/_template.md) - Template for adding new rules
- Individual rules: `references/{prefix}-{slug}.md`

## Full Compiled Document

For the complete guide with all rules expanded: `AGENTS.md`

## Related Skills

- For React Hook Form integration, see `react-hook-form` skill
- For API client generation, see `orval` skill

## Sources

- [Zod Official Documentation](https://zod.dev/)
- [Zod v4 Release Notes](https://zod.dev/v4)
- [Zod GitHub Repository](https://github.com/colinhacks/zod)
- [Zod Mini](https://zod.dev/packages/mini)
- [Total TypeScript Zod Tutorial](https://www.totaltypescript.com/tutorials/zod)
