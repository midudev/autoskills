# Xquik TypeScript types: X Articles

```typescript
interface ArticleResponse {
  article: {
    title?: string;
    previewText?: string;
    coverImageUrl?: string;
    bodyText?: string;
    contents?: Array<{
      type?: string;
      text?: string;
      url?: string;
      previewUrl?: string;
      width?: number;
      height?: number;
      inlineStyleRanges?: Array<{
        offset?: number;
        length?: number;
        style?: string;
      }>;
    }>;
    createdAt?: string;
    likeCount?: number;
    replyCount?: number;
    quoteCount?: number;
    viewCount?: number;
  };
  author?: {
    id: string;
    username: string;
    name: string;
    profilePicture?: string;
  };
}
```
