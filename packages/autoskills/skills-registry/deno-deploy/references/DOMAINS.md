# Custom Domains

## Default Domain

Every organization gets a default domain: `your-org.deno.net`

Apps are accessible at: `your-app.deno.dev`

## Adding a Custom Domain

1. Go to your organization's domains page in the Deno Deploy dashboard
2. Click "Add Domain"
3. Enter your domain (e.g., `example.com` or `*.example.com` for wildcards)
4. Click "Add Domain" to see DNS configuration

## DNS Configuration

You have three options for DNS setup:

### Option 1: ANAME/ALIAS (Recommended)

Best option if your registrar supports ANAME or ALIAS records.

| Record Type | Name | Value |
|-------------|------|-------|
| ANAME/ALIAS | `@` | `<your-app>.deno.dev` |
| CNAME | `_acme-challenge` | (provided in dashboard) |

### Option 2: CNAME

Works for subdomains (like `api.example.com`) but **not for apex domains** (like `example.com`).

| Record Type | Name | Value |
|-------------|------|-------|
| CNAME | `api` | `<your-app>.deno.dev` |
| CNAME | `_acme-challenge.api` | (provided in dashboard) |

### Option 3: A Record

Most compatible, works with any registrar.

| Record Type | Name | Value |
|-------------|------|-------|
| A | `@` | (IP provided in dashboard) |
| CNAME | `_acme-challenge` | (provided in dashboard) |

**Note:** IPv6 is not supported with the A record method.

## Cloudflare Users

If using Cloudflare, **disable proxying** (turn off the orange cloud) on the `_acme-challenge` CNAME record. Proxying prevents certificate verification from completing.

## SSL/TLS Certificates

### Automatic Certificates (Recommended)

After DNS verification completes:
1. Click "Provision Certificate" in the dashboard
2. Let's Encrypt generates your certificate
3. Certificates renew automatically

### Bring Your Own Certificate

If you need a specific certificate:
1. Upload your PEM-formatted certificate file
2. Upload your private key file
3. **You must manage renewal** - notifications arrive 14 days before expiration

**Warning:** Expired certificates cause your domain to stop working.

## Assigning Domains to Apps

1. Go to organization domains page
2. Find your domain and click to edit
3. Assign it to an application
4. Remove assignments from app settings if needed

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Verification stuck | Check DNS propagation (can take up to 48 hours) |
| Certificate won't provision | Ensure `_acme-challenge` CNAME is correct and not proxied |
| IPv6 not working | Use ANAME/ALIAS or CNAME instead of A record |

## Documentation

- Domains reference: https://docs.deno.com/deploy/reference/domains/
