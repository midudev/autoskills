# Server-Timing (Performance Lab)

Use this file when you can enable Server-Timing metrics and want backend-only inspection via HTTP headers.

Performance Lab plugin:

- https://wordpress.org/plugins/performance-lab/

Benchmarking guidance:

- https://make.wordpress.org/performance/handbook/measuring-performance/benchmarking-server-timing/

Backend-only approach:

- Enable the relevant module/standalone plugin.
- Request a URL and inspect the `Server-Timing` header:
  - `curl -sS -D - https://example.test/ -o /dev/null | rg -i \"^server-timing:\"`

Guardrails:

- Don’t enable experimental modules in production without approval.

