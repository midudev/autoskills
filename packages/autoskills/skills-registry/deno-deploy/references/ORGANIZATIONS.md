# Organizations

## What is an Organization?

In Deno Deploy, an organization is a group where users collectively own apps and domains. Every user belongs to an organization - all resources (apps, domains, environment variables) exist at the organization level.

Each organization has:
- **Name:** Displayed in the dashboard
- **Slug:** Part of your default domain (e.g., `acme-inc.deno.net`)

**Important:** The slug cannot be changed after creation.

## Creating an Organization

Organizations are created automatically during Deno Deploy signup:

1. Visit https://console.deno.com
2. Sign in with GitHub
3. Create your organization as part of setup

## Finding Your Organization

Your org name appears in the console URL:
```
https://console.deno.com/YOUR-ORG-NAME
```

Use this for CLI commands:
```bash
deno deploy create --org YOUR-ORG-NAME
deno deploy --org YOUR-ORG-NAME --prod
```

## Managing Members

### Inviting Users

1. Go to organization settings in the dashboard
2. Click "+ Invite User"
3. Enter the person's GitHub username (e.g., `ry`)
4. Optionally add their email address
5. Send the invitation

The invitee receives an email with a link to accept.

### Removing Members

1. Go to organization settings
2. Find the user in the members table
3. Click remove and confirm

### Canceling Invitations

Pending invitations can be cancelled before the person accepts.

## Permissions

Currently, **all members have owner permissions**. Every member can:
- Invite and remove other members
- Create and delete apps
- Manage domains
- Configure environment variables
- Deploy to production

There is no tiered permission system yet.

## Organization Deletion

Organizations **cannot be deleted through the dashboard**. Contact Deno support if you need to delete an organization.

## Best Practices

- **Choose your slug carefully** - it's permanent and visible in URLs
- **Limit membership** - since all members have full access
- **Use descriptive app names** - they become part of URLs too

## Documentation

- Organizations reference: https://docs.deno.com/deploy/reference/organizations/
