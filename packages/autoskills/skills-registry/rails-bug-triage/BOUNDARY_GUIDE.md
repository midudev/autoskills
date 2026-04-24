# Bug Triage Boundary Guide

Maps common bug shapes to the highest-value first failing spec.

| Bug shape | Likely first spec | Path |
|-----------|-------------------|------|
| Wrong status code, params handling, JSON payload | Request spec | `spec/requests/` |
| Invalid state transition, validation, calculation | Model or service spec | `spec/models/` or `spec/services/` |
| Async side effect missing or duplicated | Job spec | `spec/jobs/` |
| Engine routing/install/generator regression | Engine spec | Dummy app path |
| Third-party mapping/parsing issue | Integration or client-layer spec | `spec/services/module_name/` |

## Diagnosing the Right Layer

- **HTTP symptoms** (wrong status, wrong JSON shape, redirect loops): start at request level
- **Data symptoms** (wrong value saved, wrong validation message): start at model or service
- **Timing symptoms** (missing email, job not enqueued): start at job or service spec
- **Engine symptoms** (routes not found, generator broke): use dummy app request spec

## When the Boundary Is Unclear

1. Write the spec at the highest visible symptom boundary first.
2. Run it — if it fails for the wrong reason (e.g., factory error), move down a layer.
3. The correct boundary is where the failure message directly names the missing behavior.
