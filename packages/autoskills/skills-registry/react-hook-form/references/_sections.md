# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Form Configuration (formcfg)

**Impact:** CRITICAL
**Description:** Initial useForm setup determines validation timing, re-render boundaries, and default value caching. Incorrect mode selection causes re-renders on every keystroke.

## 2. Field Subscription (sub)

**Impact:** CRITICAL
**Description:** Isolating field subscriptions prevents cascade re-renders across the form tree. Using watch() at root vs useWatch() in children is the #1 performance differentiator.

## 3. Controlled Components (ctrl)

**Impact:** HIGH
**Description:** Proper Controller/useController usage isolates re-renders to individual fields. Incorrect patterns cause N×M re-renders with controlled UI libraries.

## 4. Validation Patterns (valid)

**Impact:** HIGH
**Description:** Schema resolver caching, validation mode selection, and error handling patterns affect validation cost per keystroke.

## 5. Field Arrays (array)

**Impact:** MEDIUM-HIGH
**Description:** Dynamic field management requires proper key handling and state isolation to prevent stale data and excess re-renders during CRUD operations.

## 6. State Management (formstate)

**Impact:** MEDIUM
**Description:** FormState access via Proxy subscription optimization requires explicit destructuring. Accessing entire formState object disables optimization.

## 7. Integration Patterns (integ)

**Impact:** MEDIUM
**Description:** Third-party UI library integration (MUI, shadcn, Ant Design) requires specific wiring patterns to maintain uncontrolled component benefits.

## 8. Advanced Patterns (adv)

**Impact:** LOW
**Description:** FormProvider optimization with React.memo, DevTools performance impact awareness, and testing patterns for hook-based forms.
