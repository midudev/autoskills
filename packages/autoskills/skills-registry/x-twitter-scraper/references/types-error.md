# Xquik TypeScript types: error

```typescript
type ApiErrorType =
  | "api_error"
  | "authentication_error"
  | "billing_error"
  | "dependency_error"
  | "invalid_request_error"
  | "permission_error"
  | "rate_limit_error";

interface ApiError {
  error:
    | string
    | { message: string; type: ApiErrorType; code: string };
  message?: string;
  reason?: string;
  retryAfter?: number;
  retryAfterMs?: number;
}
```

OpenAPI enumerates 112 codes, including `closed`, `expired`, `missing_url`, and
`user_not_found`. Generated SDKs use that enum. This reference keeps strings
forward-compatible.

Default v1 errors use the string form. Send
`xquik-api-contract: 2026-04-29` to receive the structured form.
