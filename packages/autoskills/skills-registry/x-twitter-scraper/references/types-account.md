# Xquik TypeScript types: account

```typescript

interface Account {
  plan: "active" | "inactive";
  monitorsAllowed: number;
  monitorsUsed: number;
  monitorUsage: {
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
  };
  xUsername?: string;
}

```
