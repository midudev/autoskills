# Security guardrails (plugin work)

Use this file when making security fixes or when handling any input/output.

## Nonces + permissions

- Nonces help prevent CSRF, not authorization.
- Always pair nonces with capability checks (`current_user_can()` or a more specific capability).

Upstream reference:

- https://developer.wordpress.org/apis/security/nonces/

## Sanitization and escaping

Golden rule:

- sanitize/validate on input, escape on output.

Practical rules:

- never process the entire `$_POST` / `$_GET` array; read explicit keys
- use `wp_unslash()` before sanitizing when needed
- use prepared statements for SQL; avoid interpolating user input into queries

Common review guidance:

- https://developer.wordpress.org/plugins/wordpress-org/detailed-plugin-guidelines/

