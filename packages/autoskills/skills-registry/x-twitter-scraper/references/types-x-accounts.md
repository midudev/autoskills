# Xquik TypeScript types: connected X accounts

```typescript

interface ConnectedXAccount {
  id: string;                 // Unique account ID
  username: string;           // X username
  displayName?: string;       // Display name on X
  isActive: boolean;          // Whether the connection is active
  createdAt: string;          // ISO 8601 timestamp
}

// Users connect X accounts in the Xquik dashboard.
// This Skill never handles X login material.

```
