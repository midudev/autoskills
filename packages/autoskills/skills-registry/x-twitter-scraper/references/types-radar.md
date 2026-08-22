# Xquik TypeScript types: radar

```typescript

type RadarSource =
  | "github"
  | "google_trends"
  | "hacker_news"
  | "polymarket"
  | "reddit"
  | "trustmrr"
  | "wikipedia";

type RadarCategory =
  | "general"
  | "tech"
  | "dev"
  | "science"
  | "culture"
  | "politics"
  | "business"
  | "entertainment";

interface RadarItem {
  id: string;
  title: string;
  description?: string;
  url?: string;
  imageUrl?: string;
  source: RadarSource;
  sourceId: string;
  category: RadarCategory;
  region: string;
  language: string;
  score: number;
  metadata: Record<string, unknown>;
  publishedAt: string;
  createdAt: string;
}

interface RadarPage {
  items: RadarItem[];
  hasMore: boolean;
  nextCursor?: string;
}

```
