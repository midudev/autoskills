# Xquik REST API endpoints: compose

## Compose tweet

```http
POST /compose
```

Compose, refine, and score tweets with Xquik style signals. Run each step separately.

Send this body:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `step` | string | Yes | `compose`, `refine`, or `score` |
| `topic` | string | No | Tweet topic for compose or refine |
| `goal` | string | No | `engagement`, `followers`, `authority`, `conversation` |
| `styleUsername` | string | No | Cached style username for compose |
| `tone` | string | No | Desired tone for refine |
| `additionalContext` | string | No | Extra context or URLs for refine |
| `callToAction` | string | No | Desired call to action for refine |
| `mediaType` | string | No | `photo`, `video`, or `none` for refine |
| `draft` | string | For `score` | Tweet text to evaluate for score |
| `hasLink` | boolean | No | Whether score evaluates a link |
| `hasMedia` | boolean | No | Whether score evaluates media |

For `step=compose`, the API returns `contentRules`, `scorerWeights`, `followUpQuestions`, `algorithmInsights`, `engagementMultipliers`, and `topPenalties`.

For `step=refine`, the API returns `compositionGuidance` and `examplePatterns`.

For `step=score`, the API returns `totalChecks`, `passedCount`, `topSuggestion`, and `checklist[]`. Each checklist item contains `factor`, `passed`, and `suggestion`.

`step=score` requires a nonempty `draft`. Do not send a score request without
the final text to check.

---
