---
name: wp-performance
description: "Use when investigating or improving WordPress performance (backend-only agent): profiling and measurement (WP-CLI profile/doctor, Server-Timing, Query Monitor via REST headers), database/query optimization, autoloaded options, object caching, cron, HTTP API calls, and safe verification."
compatibility: "Targets WordPress 6.9+ (PHP 7.2.24+). Backend-only agent; prefers WP-CLI (doctor/profile) when available."
---

# WP Performance (backend-only)

## When to use

Use this skill when:

- a WordPress site/page/endpoint is slow (frontend TTFB, admin, REST, WP-Cron)
- you need a profiling plan and tooling recommendations (WP-CLI profile/doctor, Query Monitor, Xdebug/XHProf, APMs)
- you’re optimizing DB queries, autoloaded options, object caching, cron tasks, or remote HTTP calls

This skill assumes the agent cannot use a browser UI. Prefer WP-CLI, logs, and HTTP requests.

## Inputs required

- Environment and safety: dev/staging/prod, any restrictions (no writes, no plugin installs).
- How to target the install:
  - WP root `--path=<path>`
  - (multisite/site targeting) `--url=<url>`
- The performance symptom and scope:
  - which URL/REST route/admin screen
  - when it happens (always vs sporadic; logged-in vs logged-out)

## Procedure

### 0) Guardrails: measure first, avoid risky ops

1. Confirm whether you may run write operations (plugin installs, config changes, cache flush).
2. Pick a reproducible target (URL or REST route) and capture a baseline:
   - TTFB/time with `curl` if possible
   - WP-CLI profiling if available

Read:
- `references/measurement.md`

### 1) Generate a backend-only performance report (deterministic)

Run:

- `node skills/wp-performance/scripts/perf_inspect.mjs --path=<path> [--url=<url>]`

This detects:

- WP-CLI availability and core version
- whether `wp doctor` / `wp profile` are available
- autoloaded options size (if possible)
- object-cache drop-in presence

### 2) Fast wins: run diagnostics before deep profiling

If you have WP-CLI access, prefer:

- `wp doctor check`

It catches common production foot-guns (autoload bloat, SAVEQUERIES/WP_DEBUG, plugin counts, updates).

Read:
- `references/wp-cli-doctor.md`

### 3) Deep profiling (no browser required)

Preferred order:

1. `wp profile stage` to see where time goes (bootstrap/main_query/template).
2. `wp profile hook` (optionally with `--url=`) to find slow hooks/callbacks.
3. `wp profile eval` for targeted code paths.

Read:
- `references/wp-cli-profile.md`

### 4) Query Monitor (backend-only usage)

Query Monitor is normally UI-driven, but it can be used headlessly via REST API response headers and `_envelope` responses:

- Authenticate (nonce or Application Password).
- Request REST responses and inspect headers (`x-qm-*`) and/or the `qm` property when using `?_envelope`.

Read:
- `references/query-monitor-headless.md`

### 5) Fix by category (choose the dominant bottleneck)

Use the profile output to pick *one* primary bottleneck category:

- **DB queries** → reduce query count, fix N+1 patterns, improve indexes, avoid expensive meta queries.
  - `references/database.md`
- **Autoloaded options** → identify the biggest autoloaded options and stop autoloading large blobs.
  - `references/autoload-options.md`
- **Object cache misses** → introduce caching or fix cache key/group usage; add persistent object cache where appropriate.
  - `references/object-cache.md`
- **Remote HTTP calls** → add timeouts, caching, batching; avoid calling remote APIs on every request.
  - `references/http-api.md`
- **Cron** → reduce due-now spikes, de-duplicate events, move heavy tasks out of request paths.
  - `references/cron.md`

### 6) Verify (repeat the same measurement)

- Re-run the same `wp profile` / `wp doctor` / REST request.
- Confirm the performance delta and that behavior is unchanged.
- If the fix is risky, ship behind a feature flag or staged rollout when possible.

## WordPress 6.9 performance improvements

Be aware of these 6.9 changes when profiling:

**On-demand CSS for classic themes:**
- Classic themes now get on-demand CSS loading (previously only block themes had this).
- Reduces CSS payload by 30-65% by only loading styles for blocks actually used on the page.
- If you're profiling a classic theme, this should already be helping.

**Block themes with no render-blocking resources:**
- Block themes that don't define custom stylesheets (like Twenty Twenty-Three/Four) can now load with zero render-blocking CSS.
- Styles come from global styles (theme.json) and separate block styles, all inlined.
- This significantly improves LCP (Largest Contentful Paint).

**Inline CSS limit increased:**
- The threshold for inlining small stylesheets has been raised, reducing render-blocking resources.

Reference: https://make.wordpress.org/core/2025/11/18/wordpress-6-9-frontend-performance-field-guide/

## Verification

- Baseline vs after numbers are captured (same environment, same URL/route).
- `wp doctor check` is clean (or improved) when applicable.
- No new PHP errors or warnings in logs.
- No cache flush is required for correctness (cache flush should be last resort).

## Failure modes / debugging

- “No change” after code changes:
  - you measured a different URL/site (`--url` mismatch), caches masked results, or opcode cache is stale
- Profiling data is noisy:
  - eliminate background tasks, test with warmed caches, run multiple samples
- `SAVEQUERIES`/Query Monitor causes overhead:
  - don’t run in production unless explicitly approved

## Escalation

- If this is production and you don’t have explicit approval, do not:
  - install plugins, enable `SAVEQUERIES`, run load tests, or flush caches during traffic
- If you need system-level profiling (APM, PHP profiler extensions), coordinate with ops/hosting.
