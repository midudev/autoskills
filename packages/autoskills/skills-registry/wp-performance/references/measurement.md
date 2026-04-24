# Measurement (profiling vs benchmarking)

Backend-only measurement options:

- **WP-CLI profiling** (`wp profile`): best for pinpointing slow hooks/stages without a browser.
- **WP-CLI doctor** (`wp doctor`): best for quick diagnostics (autoload bloat, debug constants, updates).
- **Query Monitor via REST**: use authenticated REST requests and inspect `x-qm-*` headers / `qm` envelope data.
- **Server-Timing** (Performance Lab): inspect `Server-Timing` headers via `curl -I` (when enabled).
- **APM/profilers**: New Relic, Datadog, Blackfire, Tideways, XHProf/Xdebug (requires server support).

Best practices:

- Always capture a baseline first.
- Keep the test scenario fixed (same URL/route, same user state, same data).
- Prefer multiple samples and medians over single runs.

References:

- Measuring performance handbook: https://make.wordpress.org/performance/handbook/measuring-performance/
- Benchmarking with Server-Timing: https://make.wordpress.org/performance/handbook/measuring-performance/benchmarking-server-timing/

