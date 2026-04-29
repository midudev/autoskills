# Vue and Nuxt Testing

## Table of Contents

1. [Commands](#commands)
2. [Configuration](#configuration)
3. [Patterns](#patterns)
4. [Vue vs Nuxt Differences](#vue-vs-nuxt-differences)
5. [Component Testing Dependencies](#component-testing-dependencies)
6. [Testing v-model](#testing-v-model)
7. [Capturing Vue Warnings](#capturing-vue-warnings)
8. [Anti-Patterns](#anti-patterns)

> **When to use**: Testing Vue 3 applications with composition API, Pinia stores, Vue Router, Nuxt 3 apps, Teleport portals, and transitions.

## Commands

```bash
npm init playwright@latest
npm install -D @playwright/experimental-ct-vue
npx playwright test
npx playwright test -c playwright-ct.config.ts
```

## Configuration

### Vue with Vite

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  testMatch: '**/*.spec.ts',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? '50%' : undefined,

  use: {
    baseURL: 'http://localhost:5173',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'mobile', use: { ...devices['iPhone 14'] } },
  ],

  webServer: {
    command: process.env.CI
      ? 'npm run build && npx vite preview --port 5173'
      : 'npm run dev',
    url: 'http://localhost:5173',
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
  },
});
```

### Nuxt 3

Nuxt uses port 3000 and requires a build step before testing.

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  testMatch: '**/*.spec.ts',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,

  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
  ],

  webServer: {
    command: process.env.CI
      ? 'npx nuxi build && npx nuxi preview'
      : 'npx nuxi dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
    env: {
      NUXT_PUBLIC_API_BASE: 'http://localhost:3000/api',
    },
  },
});
```

### Component Testing

```typescript
// playwright-ct.config.ts
import { defineConfig, devices } from '@playwright/experimental-ct-vue';

export default defineConfig({
  testDir: './tests/components',
  testMatch: '**/*.ct.ts',

  use: {
    trace: 'on-first-retry',
    ctPort: 3100,
  },

  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
  ],
});
```

## Patterns

### Component Testing with Experimental CT

**Use when**: Testing complex interactive Vue components in isolation (data tables, form components, custom dropdowns).

**Avoid when**: Component depends heavily on Pinia stores, Vue Router, or backend data—use E2E tests instead.

```typescript
// tests/components/Stepper.ct.ts
import { test, expect } from '@playwright/experimental-ct-vue';
import Stepper from '../../src/components/Stepper.vue';

test('increments value on button click', async ({ mount }) => {
  const component = await mount(Stepper, {
    props: { value: 0 },
  });

  await expect(component.getByText('Value: 0')).toBeVisible();
  await component.getByRole('button', { name: '+' }).click();
  await expect(component.getByText('Value: 1')).toBeVisible();
});

test('emits change event', async ({ mount }) => {
  const changes: number[] = [];
  const component = await mount(Stepper, {
    props: { value: 10 },
    on: {
      change: (val: number) => changes.push(val),
    },
  });

  await component.getByRole('button', { name: '+' }).click();
  await component.getByRole('button', { name: '+' }).click();

  expect(changes).toEqual([11, 12]);
});

test('renders slot content', async ({ mount }) => {
  const component = await mount(Stepper, {
    props: { value: 0 },
    slots: {
      default: '<span class="label">Quantity</span>',
    },
  });

  await expect(component.getByText('Quantity')).toBeVisible();
});
```

### Pinia Store Testing Through UI

**Use when**: Verifying Pinia stores produce correct UI behavior. If the UI is correct, the store is correct.

**Avoid when**: Testing pure store logic with no UI side effect—use unit tests with Vitest.

```typescript
import { test, expect } from '@playwright/test';

test.describe('shopping cart store', () => {
  test('adding products updates cart badge', async ({ page }) => {
    await page.goto('/shop');

    const badge = page.getByTestId('cart-badge');
    await expect(badge).toHaveText('0');

    await page.getByRole('listitem')
      .filter({ hasText: 'Hoodie' })
      .getByRole('button', { name: 'Add' })
      .click();
    await expect(badge).toHaveText('1');

    await page.getByRole('listitem')
      .filter({ hasText: 'Cap' })
      .getByRole('button', { name: 'Add' })
      .click();
    await expect(badge).toHaveText('2');

    await page.getByRole('link', { name: 'Cart' }).click();
    await page.waitForURL('/cart');

    await expect(page.getByText('Hoodie')).toBeVisible();
    await expect(page.getByText('Cap')).toBeVisible();
  });

  test('persisted state survives reload', async ({ page }) => {
    await page.goto('/shop');

    await page.getByRole('listitem')
      .filter({ hasText: 'Hoodie' })
      .getByRole('button', { name: 'Add' })
      .click();

    await page.reload();

    await expect(page.getByTestId('cart-badge')).toHaveText('1');
  });
});
```

### Vue Router Navigation

**Use when**: Testing client-side routing, navigation guards, URL parameters, browser history.

```typescript
import { test, expect } from '@playwright/test';

test.describe('router navigation', () => {
  test('client-side navigation preserves state', async ({ page }) => {
    await page.goto('/');

    await page.evaluate(() => {
      (window as any).__marker = 'spa';
    });

    await page.getByRole('link', { name: 'Shop' }).click();
    await page.waitForURL('/shop');

    const marker = await page.evaluate(() => (window as any).__marker);
    expect(marker).toBe('spa');
  });

  test('dynamic route params render content', async ({ page }) => {
    await page.goto('/items/99');

    await expect(page.getByRole('heading', { level: 1 })).toBeVisible();
    await expect(page.getByText('Item #99')).toBeVisible();
  });

  test('navigation guard redirects unauthorized users', async ({ page }) => {
    await page.goto('/admin/dashboard');

    await expect(page).toHaveURL(/\/login/);
    await expect(page.getByRole('heading', { name: 'Login' })).toBeVisible();
  });

  test('browser history navigation works', async ({ page }) => {
    await page.goto('/');
    await page.getByRole('link', { name: 'Shop' }).click();
    await page.waitForURL('/shop');
    await page.getByRole('link', { name: 'Contact' }).click();
    await page.waitForURL('/contact');

    await page.goBack();
    await expect(page).toHaveURL(/\/shop/);

    await page.goBack();
    await expect(page).toHaveURL(/\/$/);

    await page.goForward();
    await expect(page).toHaveURL(/\/shop/);
  });

  test('query params update reactive state', async ({ page }) => {
    await page.goto('/items?sort=price&type=clothing');

    await expect(page.getByRole('heading', { name: 'Clothing' })).toBeVisible();

    await page.getByRole('combobox', { name: 'Sort' }).selectOption('name');
    await expect(page).toHaveURL(/sort=name/);
  });

  test('catch-all route shows 404', async ({ page }) => {
    await page.goto('/nonexistent-page');

    await expect(page.getByRole('heading', { name: 'Not Found' })).toBeVisible();
  });
});
```

### Teleport Components

**Use when**: Testing components rendered via `<Teleport>` (modals, notifications, overlay menus).

```typescript
import { test, expect } from '@playwright/test';

test.describe('teleported elements', () => {
  test('modal is visible and interactive', async ({ page }) => {
    await page.goto('/items');

    await page.getByRole('button', { name: 'Remove' }).first().click();

    const dialog = page.getByRole('dialog', { name: 'Confirm' });
    await expect(dialog).toBeVisible();

    await dialog.getByRole('button', { name: 'Cancel' }).click();
    await expect(dialog).toBeHidden();
  });

  test('notification auto-dismisses', async ({ page }) => {
    await page.goto('/profile');

    await page.getByRole('button', { name: 'Update' }).click();

    const alert = page.getByRole('alert');
    await expect(alert).toBeVisible();
    await expect(alert).toContainText('Saved');

    await expect(alert).toBeHidden({ timeout: 10_000 });
  });

  test('dropdown closes on outside click', async ({ page }) => {
    await page.goto('/home');

    await page.getByRole('button', { name: 'Menu' }).click();

    const menu = page.getByRole('menu');
    await expect(menu).toBeVisible();

    await page.locator('body').click({ position: { x: 10, y: 10 } });
    await expect(menu).toBeHidden();
  });
});
```

### Transitions and Animations

**Use when**: Verifying `<Transition>` and `<TransitionGroup>` work correctly. Focus on end state, not animation details.

```typescript
import { test, expect } from '@playwright/test';

test.describe('transitions', () => {
  test('item appears after add', async ({ page }) => {
    await page.goto('/tasks');

    await page.getByRole('textbox', { name: 'Task' }).fill('Write tests');
    await page.getByRole('button', { name: 'Add' }).click();

    await expect(page.getByText('Write tests')).toBeVisible();
  });

  test('item disappears after delete', async ({ page }) => {
    await page.goto('/tasks');

    await page.getByRole('textbox', { name: 'Task' }).fill('Temp item');
    await page.getByRole('button', { name: 'Add' }).click();
    await expect(page.getByText('Temp item')).toBeVisible();

    await page.getByRole('listitem')
      .filter({ hasText: 'Temp item' })
      .getByRole('button', { name: 'Remove' })
      .click();

    await expect(page.getByText('Temp item')).toBeHidden();
  });

  test('disable animations for faster tests', async ({ page }) => {
    await page.addStyleTag({
      content: `
        *, *::before, *::after {
          animation-duration: 0s !important;
          animation-delay: 0s !important;
          transition-duration: 0s !important;
          transition-delay: 0s !important;
        }
      `,
    });

    await page.goto('/tasks');

    await page.getByRole('textbox', { name: 'Task' }).fill('Quick task');
    await page.getByRole('button', { name: 'Add' }).click();

    await expect(page.getByText('Quick task')).toBeVisible();
  });
});
```

### Composition API Components

**Use when**: Testing components with `<script setup>` or `setup()`. From Playwright's perspective, Composition API and Options API are identical.

```typescript
import { test, expect } from '@playwright/test';

test.describe('composition API', () => {
  test('computed properties update reactively', async ({ page }) => {
    await page.goto('/pricing');

    await page.getByLabel('Amount').fill('50');
    await page.getByLabel('Qty').fill('4');

    await expect(page.getByTestId('sum')).toHaveText('$200.00');

    await page.getByLabel('Discount').fill('20');
    await expect(page.getByTestId('sum')).toHaveText('$160.00');
  });

  test('watcher triggers on change', async ({ page }) => {
    await page.goto('/preferences');

    await page.getByRole('combobox', { name: 'Locale' }).selectOption('de');

    await expect(page.getByRole('heading', { name: 'Einstellungen' })).toBeVisible();
  });

  test('composable provides debounced search', async ({ page }) => {
    await page.goto('/shop');

    const input = page.getByRole('textbox', { name: 'Search' });
    await input.pressSequentially('hoodie', { delay: 50 });

    await expect(page.getByRole('listitem')).toHaveCount(2);
    await expect(page.getByText('Black Hoodie')).toBeVisible();
  });

  test('provide/inject updates all consumers', async ({ page }) => {
    await page.goto('/home');

    await page.getByRole('switch', { name: 'Dark theme' }).click();

    await expect(page.locator('body')).toHaveClass(/dark/);
  });
});
```

### Nuxt-Specific Patterns

**Use when**: Testing Nuxt 3 with SSR, auto-imports, server routes, and middleware.

```typescript
import { test, expect } from '@playwright/test';

test.describe('nuxt features', () => {
  test('SSR renders server-fetched data', async ({ page }) => {
    await page.goto('/posts');

    await expect(page.getByRole('article')).toHaveCount(10);
    await expect(page.getByRole('article').first()).toContainText(/\w+/);
  });

  test('server route returns data', async ({ request }) => {
    const response = await request.get('/api/items');

    expect(response.ok()).toBeTruthy();
    const data = await response.json();
    expect(data).toBeInstanceOf(Array);
    expect(data[0]).toHaveProperty('id');
  });

  test('middleware redirects unauthorized', async ({ page }) => {
    await page.goto('/admin');

    await expect(page).toHaveURL(/\/login/);
  });

  test('NuxtLink enables SPA navigation', async ({ page }) => {
    await page.goto('/');

    await page.evaluate(() => {
      (window as any).__marker = 'spa';
    });

    await page.getByRole('link', { name: 'Posts' }).click();
    await page.waitForURL('/posts');

    const marker = await page.evaluate(() => (window as any).__marker);
    expect(marker).toBe('spa');
  });

  test('useHead sets meta tags', async ({ page }) => {
    await page.goto('/posts/hello-world');

    const title = await page.title();
    expect(title).toContain('Hello World');

    const desc = await page.locator('meta[name="description"]').getAttribute('content');
    expect(desc).toBeTruthy();
    expect(desc!.length).toBeGreaterThan(50);
  });
});
```

## Vue vs Nuxt Differences

| Aspect | Vue 3 (Vite) | Nuxt 3 |
| --- | --- | --- |
| Default port | `5173` | `3000` |
| Dev command | `npm run dev` | `npx nuxi dev` |
| Build + preview | `npm run build && npx vite preview` | `npx nuxi build && npx nuxi preview` |
| SSR | Optional | Built-in |
| API routes | External backend | `/server/api/` built-in |
| Env variables | `VITE_*` prefix | `NUXT_PUBLIC_*` (client), `NUXT_*` (server) |
| File-based routing | No | Yes |

## Component Testing Dependencies

Components depending on Pinia or Vue Router need these provided:

```typescript
// playwright/index.ts
import { beforeMount } from '@playwright/experimental-ct-vue/hooks';
import { createPinia } from 'pinia';
import { createMemoryHistory, createRouter } from 'vue-router';

beforeMount(async ({ app, hooksConfig }) => {
  const pinia = createPinia();
  app.use(pinia);

  if (hooksConfig?.routes) {
    const router = createRouter({
      history: createMemoryHistory(),
      routes: hooksConfig.routes,
    });
    app.use(router);
  }
});
```

## Testing v-model

`v-model` works through standard HTML events. Playwright methods trigger correct events automatically:

```typescript
await page.getByLabel('Email').fill('user@test.com');
await page.getByRole('checkbox', { name: 'Subscribe' }).check();
await page.getByRole('combobox', { name: 'Country' }).selectOption('US');
```

## Capturing Vue Warnings

```typescript
test('no Vue warnings during render', async ({ page }) => {
  const warnings: string[] = [];
  page.on('console', (msg) => {
    if (msg.type() === 'warning' && msg.text().includes('[Vue warn]')) {
      warnings.push(msg.text());
    }
  });

  await page.goto('/home');
  await expect(page.getByRole('heading', { name: 'Home' })).toBeVisible();

  expect(warnings).toEqual([]);
});
```

## Anti-Patterns

| Avoid | Problem | Instead |
| --- | --- | --- |
| `page.evaluate(() => app.__vue_app__.config.globalProperties.$store)` | Accesses Vue internals; breaks on upgrades | Assert on UI that state produces |
| `page.locator('[data-v-abc123]')` | Scoped style hashes change on every build | Use `getByRole`, `getByText`, `getByTestId` |
| Import `.vue` files in E2E tests | E2E tests run in Node.js; `.vue` needs compilation | Use `@playwright/experimental-ct-vue` for component tests |
| `page.waitForTimeout(300)` for transitions | Arbitrary waits are fragile | `await expect(locator).toBeVisible()` auto-waits |
| Mock Pinia by patching `window.__pinia` | Fragile; may not trigger reactivity | Control state through UI or mock API responses |
| Test composables via `page.evaluate` | Composables need Vue's setup context | Test through components or unit test with Vitest |
| `page.locator('.v-btn')` for Vuetify | Class names change between versions | `page.getByRole('button', { name: 'Submit' })` |
| Run Nuxt dev server in CI | Dev mode is slower with hot reload overhead | Use `npx nuxi build && npx nuxi preview` |
