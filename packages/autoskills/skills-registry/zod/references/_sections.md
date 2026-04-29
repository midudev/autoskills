# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Schema Definition (schema)

**Impact:** CRITICAL
**Description:** Schema definition is the foundation of all Zod validation; incorrect or overly permissive schemas cascade errors through your entire application, allowing invalid data to corrupt downstream logic.

## 2. Parsing & Validation (parse)

**Impact:** CRITICAL
**Description:** Parsing is the core Zod operation; using `parse()` vs `safeParse()` incorrectly causes either unhandled exceptions crashing your app or silent failures that let invalid data through.

## 3. Type Inference (type)

**Impact:** HIGH
**Description:** Zod's TypeScript integration eliminates duplicate type definitions; poor inference practices force manual type declarations that drift from schemas, losing the core benefit of Zod.

## 4. Error Handling (error)

**Impact:** HIGH
**Description:** Error handling determines user experience; poorly structured error handling produces cryptic messages that harm UX and make debugging validation failures nearly impossible.

## 5. Object Schemas (object)

**Impact:** MEDIUM-HIGH
**Description:** Objects are the most common schema type; misconfiguring strict/passthrough/strip modes either leaks unexpected data to clients or fails validation on legitimate requests.

## 6. Schema Composition (compose)

**Impact:** MEDIUM
**Description:** Schema composition enables reuse and maintainability; poor composition patterns lead to duplicated schemas that drift apart or deeply nested structures that are impossible to maintain.

## 7. Refinements & Transforms (refine)

**Impact:** MEDIUM
**Description:** Refinements and transforms handle custom validation and data coercion; choosing the wrong method causes performance issues, incorrect error aggregation, or async parsing failures.

## 8. Performance & Bundle (perf)

**Impact:** LOW-MEDIUM
**Description:** Zod's performance and bundle size affect application startup and validation throughput; understanding when to use Zod Mini or cache schemas prevents unnecessary overhead in performance-critical paths.
