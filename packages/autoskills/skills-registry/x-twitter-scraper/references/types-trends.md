# Xquik TypeScript types: trends

```typescript

interface Trend {
  name: string;
  description?: string;
  rank?: number;
  query?: string;
  promotedContent?: string | null;
  tweetVolume?: number | null;
  url?: string;
}

interface TrendList {
  trends: Trend[];
  total: number;
  woeid: number;
}

```
