# Enterprise SSO

Per-organization SAML or OIDC. Configured in the Clerk Dashboard today (future CLI support planned — revisit this ref once the Clerk CLI ships for scripted connection setup). New users from a matching domain auto-join via JIT Provisioning.

## Configuration Flow

1. Open Dashboard → Configure → **Enterprise Connections** (or per-org: Organizations → select org → **SSO Connections**).
2. Add a SAML or OIDC connection and choose which Organization scopes the connection.
3. Supply the customer's IdP metadata (SAML) or client credentials (OIDC). Clerk generates an ACS URL + Entity ID for the IdP admin to configure on their end.
4. Set the domain the connection enforces on (e.g. `acme.com`). Clerk routes any sign-in with that email domain through the connection.

Each org can have multiple SSO connections (e.g., SAML + OIDC, or SAML for two different IdPs). Each connection covers one domain.

> **Enterprise SSO ≠ Verified Domains.** These are distinct features. A domain used for Enterprise SSO cannot also be a Verified Domain for the same Organization. Use SSO for IdP-mandated auth; use Verified Domains for auto-invite / auto-suggest flows without SSO. See `docs/guides/organizations/add-members/sso.mdx` and `docs/guides/organizations/add-members/verified-domains.mdx`.

Permission required to manage: `org:sys_domains:manage`.

## Strategy Name

```typescript
// Current SDK (Core 3+)
strategy: 'enterprise_sso'
```

Used in `signIn.supportedFirstFactors` when building custom sign-in flows.

> **Core 2 ONLY (skip if current SDK):** Uses `strategy: 'saml'` and `user.samlAccounts` instead of the Core 3 names.

## Accessing SSO Info on the User

`provider` and protocol metadata live on the nested `enterpriseConnection`, not directly on the enterprise account. Correct paths:

```typescript
import { currentUser } from '@clerk/nextjs/server'

const user = await currentUser()
const ssoAccount = user?.enterpriseAccounts?.[0]

if (ssoAccount) {
  // Directly on EnterpriseAccount:
  ssoAccount.emailAddress           // the email used for SSO
  ssoAccount.active                 // boolean — is the account active
  ssoAccount.firstName, ssoAccount.lastName
  ssoAccount.lastAuthenticatedAt    // Date | null

  // Provider metadata lives on the nested EnterpriseAccountConnection:
  const conn = ssoAccount.enterpriseConnection
  conn?.provider    // 'saml_okta' | 'saml_google' | 'saml_microsoft' | 'saml_custom' | 'oauth_<provider>'
  conn?.protocol    // 'saml' | 'oauth'
  conn?.domain      // the verified domain
  conn?.name        // display name of the connection
  conn?.active
}
```

### Common Mistakes

```typescript
// ❌ Wrong — `provider` is not a field on EnterpriseAccount
ssoAccount.provider

// ✓ Right — `provider` lives on the nested connection
ssoAccount.enterpriseConnection?.provider
```

`enterpriseConnection` is `null` if the connection was deleted after the account was provisioned. Always guard with `?.`.

## Verified Domains (separate feature — short reference)

Verified Domains are a different feature from Enterprise SSO and **cannot coexist on the same domain for the same Organization**. Short reference:

- Purpose: auto-invite or auto-suggest users from a matching email domain to join an org, without IdP-mandated SSO.
- Ownership verification: Clerk sends a verification code to an address at that domain (handled inside the `<OrganizationSwitcher />` / `<OrganizationProfile />` flow).
- Enrollment modes: Manual invitation, Automatic invitation, Automatic suggestion.
- Permission: `org:sys_domains:manage`.
- Full reference: [docs/guides/organizations/add-members/verified-domains.mdx](https://clerk.com/docs/guides/organizations/add-members/verified-domains).

## JIT Provisioning (how SSO users auto-join)

When a user signs in via an Enterprise SSO connection scoped to an org, Clerk's [Just-in-Time (JIT) Provisioning](https://clerk.com/docs/guides/configure/auth-strategies/enterprise-connections/jit-provisioning) automatically adds them as a member of that org and assigns the org's Default Role. No invitation is required.

JIT runs on the Enterprise Connection, not on the Verified Domain. The two features enforce different pathways and are mutually exclusive per-domain.

## Custom Sign-In Flow with SSO

Typical pattern (Core 3 canonical):

```typescript
const { signIn } = useSignIn()

const { error } = await signIn.sso({
  strategy: 'enterprise_sso',
  identifier: emailAddress,
  redirectUrl: '/dashboard',                 // where to land on successful sign-in
  redirectCallbackUrl: '/sign-in/callback',  // where to land when additional requirements are needed
})
```

The `identifier` is the user's email. Clerk uses the domain to route to the correct Enterprise SSO connection. If no matching connection exists, the sign-in falls back to standard email/password or returns an error.

> **Core 2 / legacy:** `signIn.authenticateWithRedirect({ strategy: 'enterprise_sso', identifier, redirectUrl, redirectUrlComplete })` still exists on the SDK for backwards compatibility, but for new code use `signIn.sso()` per the current enterprise-connections custom flow doc.

## Key Rules

- **`provider` is nested.** Always `enterpriseAccounts[i].enterpriseConnection?.provider` — not directly on the account.
- **SSO connection owns the domain.** The domain the SSO connection enforces on is set on the connection itself; it does NOT require a separate Verified Domain (and in fact the two features are mutually exclusive per-domain).
- **Strategy name matters.** Core 3 uses `'enterprise_sso'`; Core 2 used `'saml'`. They are NOT interchangeable.
- **Multiple connections per org is fine.** Typical enterprise: one SAML connection to Okta + one OIDC to Azure AD for different user segments / domains.
- **Auto-join via JIT Provisioning.** Users who authenticate via an Organization's Enterprise SSO connection are added to the org automatically with the org's Default Role. No invitation step.
- **Setup is Dashboard-only today.** CLI support is planned; once it ships, scripted connection setup will be possible. Until then, scripted management goes through the Backend API.
