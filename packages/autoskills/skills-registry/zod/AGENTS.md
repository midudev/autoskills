# Zod

**Version 1.0.0**  
community  
January 2026

> **Note:**  
> This document is mainly for agents and LLMs to follow when maintaining,  
> generating, or refactoring codebases. Humans may also find it useful,  
> but guidance here is optimized for automation and consistency by AI-assisted workflows.

---

## Abstract

Comprehensive schema validation guide for Zod in TypeScript applications, designed for AI agents and LLMs. Contains 43 rules across 8 categories, prioritized by impact from critical (schema definition, parsing) to incremental (performance, bundle optimization). Each rule includes detailed explanations, real-world examples comparing incorrect vs. correct implementations, and specific impact metrics to guide automated refactoring and code generation.

---

## Table of Contents

1. [Schema Definition](references/_sections.md#1-schema-definition) — **CRITICAL**
   - 1.1 [Apply String Validations at Schema Definition](references/schema-string-validations.md) — CRITICAL (Unvalidated strings allow SQL injection, XSS, and malformed data; validating at schema level catches issues at the boundary)
   - 1.2 [Avoid Overusing Optional Fields](references/schema-avoid-optional-abuse.md) — CRITICAL (Excessive optional fields create schemas that accept almost anything; forces null checks throughout codebase)
   - 1.3 [Use Coercion for Form and Query Data](references/schema-coercion-for-form-data.md) — CRITICAL (Form data and query params are always strings; without coercion, z.number() rejects "42" and z.boolean() rejects "true")
   - 1.4 [Use Enums for Fixed String Values](references/schema-use-enums.md) — CRITICAL (Plain strings accept any value including typos; enums restrict to valid values and enable autocomplete)
   - 1.5 [Use Primitive Schemas Correctly](references/schema-use-primitives-correctly.md) — CRITICAL (Incorrect primitive selection causes validation to pass on wrong types; using z.any() or z.unknown() loses all type safety)
   - 1.6 [Use z.unknown() Instead of z.any()](references/schema-use-unknown-not-any.md) — CRITICAL (z.any() bypasses TypeScript's type system entirely; z.unknown() forces type narrowing before use)
2. [Parsing & Validation](references/_sections.md#2-parsing-&-validation) — **CRITICAL**
   - 2.1 [Avoid Double Validation](references/parse-avoid-double-validation.md) — HIGH (Parsing the same data twice wastes CPU cycles; in hot paths this adds measurable latency)
   - 2.2 [Handle All Validation Issues Not Just First](references/parse-handle-all-issues.md) — CRITICAL (Showing only the first error forces users to fix-submit-fix repeatedly; collecting all errors improves UX dramatically)
   - 2.3 [Never Trust JSON.parse Output](references/parse-never-trust-json.md) — CRITICAL (JSON.parse returns any type; unvalidated JSON allows type confusion attacks and runtime crashes)
   - 2.4 [Use parseAsync for Async Refinements](references/parse-async-for-async-refinements.md) — CRITICAL (Using parse() with async refinements throws an error; async validation silently fails or crashes the application)
   - 2.5 [Use safeParse() for User Input](references/parse-use-safeparse.md) — CRITICAL (parse() throws exceptions on invalid data; unhandled exceptions crash servers and expose stack traces to users)
   - 2.6 [Validate at System Boundaries](references/parse-validate-early.md) — CRITICAL (Validating deep in business logic allows corrupt data to propagate; validating at boundaries catches issues before they spread)
3. [Type Inference](references/_sections.md#3-type-inference) — **HIGH**
   - 3.1 [Distinguish z.input from z.infer for Transforms](references/type-input-vs-output.md) — HIGH (Using wrong type with transforms causes TypeScript errors; z.input captures pre-transform shape, z.infer captures post-transform)
   - 3.2 [Enable TypeScript Strict Mode](references/type-enable-strict-mode.md) — HIGH (Without strict mode, Zod's type inference is unreliable; undefined and null slip through, defeating the purpose of validation)
   - 3.3 [Export Both Schemas and Inferred Types](references/type-export-schemas-and-types.md) — HIGH (Exporting only schemas forces consumers to derive types themselves; exporting both reduces boilerplate and improves DX)
   - 3.4 [Use Branded Types for Domain Safety](references/type-branded-types.md) — HIGH (Plain string IDs are interchangeable, allowing userId where orderId is expected; branded types catch these bugs at compile time)
   - 3.5 [Use z.infer Instead of Manual Types](references/type-use-z-infer.md) — HIGH (Manual type definitions drift from schemas over time; z.infer guarantees types match validation exactly)
4. [Error Handling](references/_sections.md#4-error-handling) — **HIGH**
   - 4.1 [Implement Internationalized Error Messages](references/error-i18n.md) — HIGH (Hardcoded English messages exclude non-English users; error maps enable localized messages for global applications)
   - 4.2 [Provide Custom Error Messages](references/error-custom-messages.md) — HIGH (Default messages like "Expected string, received number" confuse users; custom messages like "Email is required" are actionable)
   - 4.3 [Return False Instead of Throwing in Refine](references/error-avoid-throwing-in-refine.md) — HIGH (Throwing in refine stops validation early, hiding other errors; returning false allows Zod to collect all issues)
   - 4.4 [Use flatten() for Form Error Display](references/error-use-flatten.md) — HIGH (Raw ZodError.issues requires manual path parsing; flatten() provides field-keyed errors ready for form display)
   - 4.5 [Use issue.path for Nested Error Location](references/error-path-for-nested.md) — HIGH (Without path information, users can't identify which nested field failed; path provides exact location in complex objects)
5. [Object Schemas](references/_sections.md#5-object-schemas) — **MEDIUM-HIGH**
   - 5.1 [Choose strict() vs strip() for Unknown Keys](references/object-strict-vs-strip.md) — MEDIUM-HIGH (Default passthrough mode leaks unexpected data; strict() catches schema mismatches, strip() silently removes extras)
   - 5.2 [Distinguish optional() from nullable()](references/object-optional-vs-nullable.md) — MEDIUM-HIGH (Confusing undefined and null semantics causes "property does not exist" vs "property is null" bugs; choose deliberately)
   - 5.3 [Use Discriminated Unions for Type Narrowing](references/object-discriminated-unions.md) — MEDIUM-HIGH (Regular unions require manual type guards; discriminated unions enable TypeScript's automatic narrowing and Zod's optimized parsing)
   - 5.4 [Use extend() for Adding Fields](references/object-extend-for-composition.md) — MEDIUM-HIGH (Merging objects manually loses type information; extend() preserves types and allows overriding fields safely)
   - 5.5 [Use partial() for Update Schemas](references/object-partial-for-updates.md) — MEDIUM-HIGH (Creating separate update schemas duplicates definitions; partial() derives update schema from base, staying in sync)
   - 5.6 [Use pick() and omit() for Schema Variants](references/object-pick-omit.md) — MEDIUM-HIGH (Copying fields between schemas creates duplication; pick/omit derive variants that stay in sync with base schema)
6. [Schema Composition](references/_sections.md#6-schema-composition) — **MEDIUM**
   - 6.1 [Extract Shared Schemas into Reusable Modules](references/compose-shared-schemas.md) — MEDIUM (Duplicating schemas across files leads to inconsistency; shared schemas ensure single source of truth)
   - 6.2 [Use intersection() for Type Combinations](references/compose-intersection.md) — MEDIUM (Manual field combination loses type relationships; intersection creates proper TypeScript intersection types)
   - 6.3 [Use pipe() for Multi-Stage Validation](references/compose-pipe.md) — MEDIUM (Chaining transforms loses intermediate type info; pipe() explicitly shows data flow through validation stages)
   - 6.4 [Use preprocess() for Data Normalization](references/compose-preprocess.md) — MEDIUM (Validating before cleaning data causes false rejections; preprocess() normalizes input before schema validation runs)
   - 6.5 [Use z.lazy() for Recursive Schemas](references/compose-lazy-recursive.md) — MEDIUM (Recursive types reference themselves before definition; z.lazy() defers evaluation to enable self-referential schemas)
7. [Refinements & Transforms](references/_sections.md#7-refinements-&-transforms) — **MEDIUM**
   - 7.1 [Add Path to Refinement Errors](references/refine-add-path.md) — MEDIUM (Errors without path show at object level; adding path highlights the specific field that failed)
   - 7.2 [Choose refine() vs superRefine() Correctly](references/refine-vs-superrefine.md) — MEDIUM (refine() only reports one error; superRefine() enables multiple issues and custom error codes)
   - 7.3 [Distinguish transform() from refine() and coerce()](references/refine-transform-coerce.md) — MEDIUM (Using wrong method causes validation to pass with wrong data; each method has distinct purpose)
   - 7.4 [Use catch() for Fault-Tolerant Parsing](references/refine-catch.md) — MEDIUM (parse() fails on first invalid field; catch() provides fallback values, enabling partial success with degraded data)
   - 7.5 [Use default() for Optional Fields with Defaults](references/refine-defaults.md) — MEDIUM (Manual default handling spreads logic across codebase; .default() centralizes defaults in schema)
8. [Performance & Bundle](references/_sections.md#8-performance-&-bundle) — **LOW-MEDIUM**
   - 8.1 [Avoid Dynamic Schema Creation in Hot Paths](references/perf-avoid-dynamic-creation.md) — LOW-MEDIUM (Zod 4's JIT compilation makes schema creation slower; creating schemas in loops adds ~0.15ms per creation)
   - 8.2 [Cache Schema Instances](references/perf-cache-schemas.md) — LOW-MEDIUM (Creating schemas on every render/call wastes CPU; module-level or memoized schemas are created once)
   - 8.3 [Lazy Load Large Schemas](references/perf-lazy-loading.md) — LOW-MEDIUM (Large schemas increase initial bundle and parse time; dynamic imports defer loading until needed)
   - 8.4 [Optimize Large Array Validation](references/perf-arrays.md) — LOW-MEDIUM (Validating 10,000 items takes ~100ms; early exits, sampling, or batching reduce time for large datasets)
   - 8.5 [Use Zod Mini for Bundle-Sensitive Applications](references/perf-zod-mini.md) — LOW-MEDIUM (Full Zod is ~17kb gzipped; Zod Mini is ~1.9kb - 85% smaller for frontend-critical bundles)

---

## References

1. [https://zod.dev/](https://zod.dev/)
2. [https://zod.dev/v4](https://zod.dev/v4)
3. [https://github.com/colinhacks/zod](https://github.com/colinhacks/zod)
4. [https://zod.dev/packages/mini](https://zod.dev/packages/mini)
5. [https://www.totaltypescript.com/tutorials/zod](https://www.totaltypescript.com/tutorials/zod)
6. [https://zod.dev/error-handling](https://zod.dev/error-handling)
7. [https://zod.dev/api](https://zod.dev/api)

---

## Source Files

This document was compiled from individual reference files. For detailed editing or extension:

| File | Description |
|------|-------------|
| [references/_sections.md](references/_sections.md) | Category definitions and impact ordering |
| [assets/templates/_template.md](assets/templates/_template.md) | Template for creating new rules |
| [SKILL.md](SKILL.md) | Quick reference entry point |
| [metadata.json](metadata.json) | Version and reference URLs |