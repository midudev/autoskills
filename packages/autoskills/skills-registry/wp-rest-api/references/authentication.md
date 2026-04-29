# Authentication (summary)

## Cookie authentication (in-dashboard / same-site)

- Standard for wp-admin and theme/plugin JS.
- Requires a REST nonce (`wp_rest`) sent as `X-WP-Nonce` header or `_wpnonce` param.
- If the nonce is missing, the request is treated as unauthenticated even if cookies exist.

## Application Passwords (external clients)

- Available in WordPress 5.6+.
- Use HTTPS + Basic Auth with the application password.
- Recommended over the legacy Basic Auth plugin.

## Auth plugins

- OAuth 1.0a or JWT plugins are common for external apps.
- Use only if required; follow plugin docs and security guidance.
