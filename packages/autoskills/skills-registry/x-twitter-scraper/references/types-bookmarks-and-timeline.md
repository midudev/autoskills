# Xquik TypeScript types: bookmarks & timeline

```typescript

interface BookmarksResponse {
  tweets: Tweet[];
  has_next_page: boolean;
  next_cursor?: string;
}

interface BookmarkFolder {
  id: string;
  name: string;
}

interface BookmarkFoldersResponse {
  folders: BookmarkFolder[];
}

interface NotificationsResponse {
  notifications: Notification[];
  has_next_page: boolean;
  next_cursor?: string;
}

interface TimelineResponse {
  tweets: Tweet[];
  has_next_page: boolean;
  next_cursor?: string;
}

interface DmHistoryResponse {
  messages: DmMessage[];
  has_next_page: boolean;
  next_cursor?: string;
}

interface DmMessage {
  id: string;
  text: string;
  senderId: string;
  createdAt: string;
  media?: TweetMediaItem[];
}

```
