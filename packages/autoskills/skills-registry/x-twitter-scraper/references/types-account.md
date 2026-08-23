# Xquik TypeScript types: account

```typescript

interface Account {
  plan: "active" | "inactive";
  monitorsAllowed: number;
  monitorsUsed: number;
  monitorBilling: {
    activeDailyEstimate: string;
    activeHourlyBurn: string;
    creditsPerActiveMonitorDay: string;
    creditsPerActiveMonitorHour: string;
    eventsIncluded: boolean;
    instantCheckIntervalSeconds: number;
    unlimitedSlots: boolean;
  };
  creditInfo?: {
    balance: string;
    lifetimePurchased: string;
    lifetimeUsed: string;
    autoTopupEnabled: boolean;
    autoTopupAmountDollars: number;
    autoTopupThreshold: string;
  };
  xUsername?: string;
}

```
