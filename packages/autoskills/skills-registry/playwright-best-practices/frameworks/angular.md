# Angular Testing with Playwright

## Table of Contents

1. [Configuration](#configuration)
2. [Locator Strategies](#locator-strategies)
3. [Reactive Forms](#reactive-forms)
4. [Angular Material Components](#angular-material-components)
5. [Router Navigation](#router-navigation)
6. [Lazy-Loaded Modules](#lazy-loaded-modules)
7. [Signals and Observables](#signals-and-observables)
8. [Zone.js and Change Detection](#zonejs-and-change-detection)
9. [SSR Testing](#ssr-testing)
10. [Protractor Migration Reference](#protractor-migration-reference)
11. [Build Configurations](#build-configurations)
12. [CDK Overlay Container](#cdk-overlay-container)
13. [Anti-Patterns](#anti-patterns)
14. [Related](#related)

> **When to use**: Testing Angular applications with reactive forms, Angular Material components, Router navigation, lazy-loaded modules, signals, observables, and Zone.js change detection.
> **Prerequisites**: [core/configuration.md](../core/configuration.md), [core/locators.md](../core/locators.md)

## Configuration

### Playwright Config

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  testMatch: '**/*.spec.ts',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? '50%' : undefined,

  use: {
    baseURL: 'http://localhost:4200',
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
      ? 'npx ng build && npx http-server dist/my-app/browser -p 4200 -s'
      : 'npx ng serve',
    url: 'http://localhost:4200',
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
  },
});
```

### Project Structure

```text
my-angular-app/
  src/
  e2e/
    tests/
      dashboard.spec.ts
      login.spec.ts
    fixtures/
      auth.fixture.ts
  playwright.config.ts
  angular.json
```

### Package Scripts

```json
{
  "scripts": {
    "e2e": "playwright test",
    "e2e:headed": "playwright test --headed",
    "e2e:debug": "playwright test --debug",
    "e2e:report": "playwright show-report"
  }
}
```

## Locator Strategies

Angular generates internal attributes (`_ngcontent-*`, `_nghost-*`, `ng-reflect-*`) that change every build. Always use semantic locators.

```typescript
test('use semantic locators for Angular apps', async ({ page }) => {
  await page.goto('/projects');

  // Role-based locators work with Angular Material and native HTML
  await page.getByRole('button', { name: 'New project' }).click();
  await expect(page.getByRole('heading', { name: 'Create Project' })).toBeVisible();

  // Label-based for form fields
  await page.getByLabel('Project title').fill('Alpha');

  // Test IDs for complex components without semantic roles
  const chart = page.getByTestId('metrics-chart');
  await expect(chart).toBeVisible();

  // Scope locators within component boundaries
  const projectTable = page.getByRole('table', { name: 'Projects' });
  const activeRow = projectTable.getByRole('row').filter({
    has: page.getByRole('cell', { name: 'Active' }),
  });
  await activeRow.getByRole('button', { name: 'Edit' }).click();
});
```

## Reactive Forms

Playwright interacts with the rendered DOM, so reactive forms (`FormGroup`, `FormControl`, `FormArray`) are transparent.

```typescript
test.describe('form validation', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/signup');
  });

  test('displays validation errors on blur', async ({ page }) => {
    const emailField = page.getByLabel('Email');
    await emailField.click();
    await emailField.blur();
    await expect(page.getByText('Email is required')).toBeVisible();

    await emailField.fill('invalid');
    await emailField.blur();
    await expect(page.getByText('Invalid email format')).toBeVisible();
  });

  test('validates password confirmation', async ({ page }) => {
    await page.getByLabel('Password', { exact: true }).fill('Secret123!');
    await page.getByLabel('Confirm password').fill('Mismatch');
    await page.getByLabel('Confirm password').blur();

    await expect(page.getByText('Passwords must match')).toBeVisible();

    await page.getByLabel('Confirm password').fill('Secret123!');
    await expect(page.getByText('Passwords must match')).toBeHidden();
  });

  test('handles FormArray add/remove', async ({ page }) => {
    await page.goto('/contacts/edit');

    await page.getByRole('button', { name: 'Add email' }).click();
    const emailInputs = page.getByLabel(/Email address/);
    await expect(emailInputs).toHaveCount(2);

    await emailInputs.nth(1).fill('backup@example.com');
    await page.getByRole('button', { name: 'Remove email 1' }).click();

    await expect(emailInputs).toHaveCount(1);
    await expect(emailInputs.first()).toHaveValue('backup@example.com');
  });

  test('disables submit until form is valid', async ({ page }) => {
    const submitBtn = page.getByRole('button', { name: 'Register' });
    await expect(submitBtn).toBeDisabled();

    await page.getByLabel('Name').fill('Alice');
    await page.getByLabel('Email').fill('alice@test.com');
    await page.getByLabel('Password', { exact: true }).fill('Secret123!');
    await page.getByLabel('Confirm password').fill('Secret123!');
    await page.getByLabel('Accept terms').check();

    await expect(submitBtn).toBeEnabled();
  });

  test('shows async validator loading state', async ({ page }) => {
    await page.route('**/api/username-check*', async (route) => {
      await new Promise((r) => setTimeout(r, 800));
      await route.fulfill({ json: { available: true } });
    });

    await page.getByLabel('Username').fill('alice');
    await page.getByLabel('Username').blur();

    await expect(page.getByTestId('username-loading')).toBeVisible();
    await expect(page.getByTestId('username-loading')).toBeHidden();
    await expect(page.getByText('Username available')).toBeVisible();
  });
});
```

## Angular Material Components

Angular Material uses proper ARIA attributes. Use role-based locators instead of CSS classes like `.mat-mdc-button`.

```typescript
test.describe('Material components', () => {
  test('mat-select dropdown', async ({ page }) => {
    await page.goto('/preferences');

    await page.getByRole('combobox', { name: 'Language' }).click();
    await page.getByRole('option', { name: 'Spanish' }).click();

    await expect(page.getByRole('combobox', { name: 'Language' })).toContainText('Spanish');
  });

  test('mat-autocomplete suggestions', async ({ page }) => {
    await page.goto('/members/add');

    const roleField = page.getByRole('combobox', { name: 'Role' });
    await roleField.fill('dev');

    await expect(page.getByRole('option', { name: 'Developer' })).toBeVisible();
    await expect(page.getByRole('option', { name: 'DevOps' })).toBeVisible();

    await page.getByRole('option', { name: 'Developer' }).click();
    await expect(roleField).toHaveValue('Developer');
  });

  test('mat-dialog interaction', async ({ page }) => {
    await page.goto('/items');

    await page.getByRole('button', { name: 'Remove item' }).first().click();

    const dialog = page.getByRole('dialog');
    await expect(dialog).toBeVisible();
    await expect(dialog.getByText('Confirm deletion?')).toBeVisible();

    await dialog.getByRole('button', { name: 'Cancel' }).click();
    await expect(dialog).toBeHidden();
  });

  test('mat-table sorting', async ({ page }) => {
    await page.goto('/members');

    await page.getByRole('columnheader', { name: 'Name' }).click();
    const header = page.getByRole('columnheader', { name: 'Name' });
    await expect(header).toHaveAttribute('aria-sort', 'ascending');

    await page.getByRole('columnheader', { name: 'Name' }).click();
    await expect(header).toHaveAttribute('aria-sort', 'descending');
  });

  test('mat-paginator navigation', async ({ page }) => {
    await page.goto('/members');

    await expect(page.getByText('1 - 10 of 100')).toBeVisible();

    await page.getByRole('button', { name: 'Next page' }).click();
    await expect(page.getByText('11 - 20 of 100')).toBeVisible();

    await page.getByRole('combobox', { name: 'Items per page' }).click();
    await page.getByRole('option', { name: '50' }).click();
    await expect(page.getByText('1 - 50 of 100')).toBeVisible();
  });

  test('mat-snack-bar notification', async ({ page }) => {
    await page.goto('/preferences');

    await page.getByRole('button', { name: 'Save' }).click();
    await expect(page.getByText('Changes saved')).toBeVisible();

    await page.getByRole('button', { name: 'Close' }).click();
    await expect(page.getByText('Changes saved')).toBeHidden();
  });

  test('mat-stepper wizard', async ({ page }) => {
    await page.goto('/wizard');

    await expect(page.getByText('Step 1 of 3')).toBeVisible();
    await page.getByLabel('Name').fill('Bob');
    await page.getByRole('button', { name: 'Next' }).click();

    await expect(page.getByText('Step 2 of 3')).toBeVisible();
    await page.getByLabel('Organization').fill('Acme');
    await page.getByRole('button', { name: 'Next' }).click();

    await expect(page.getByText('Step 3 of 3')).toBeVisible();
    await expect(page.getByText('Bob')).toBeVisible();
    await expect(page.getByText('Acme')).toBeVisible();
  });
});
```

## Router Navigation

```typescript
test.describe('Angular Router', () => {
  test('lazy-loaded module loads on navigation', async ({ page }) => {
    await page.goto('/');

    await page.getByRole('link', { name: 'Reports' }).click();
    await page.waitForURL('/reports');

    await expect(page.getByRole('heading', { name: 'Reports Dashboard' })).toBeVisible();
  });

  test('route guard redirects unauthorized users', async ({ page }) => {
    await page.goto('/admin/settings');

    await expect(page).toHaveURL(/\/login/);
    await expect(page.getByRole('heading', { name: 'Sign in' })).toBeVisible();
  });

  test('resolver prefetches data', async ({ page }) => {
    const resolverPromise = page.waitForResponse('**/api/items/*');
    await page.goto('/items/42');
    await resolverPromise;

    await expect(page.getByRole('heading', { level: 1 })).toContainText('Item');
  });

  test('nested router-outlet renders children', async ({ page }) => {
    await page.goto('/account/profile');

    await expect(page.getByRole('heading', { name: 'Account' })).toBeVisible();
    await expect(page.getByRole('heading', { name: 'Profile', level: 2 })).toBeVisible();

    await page.getByRole('link', { name: 'Security' }).click();
    await page.waitForURL('/account/security');

    await expect(page.getByRole('heading', { name: 'Account' })).toBeVisible();
    await expect(page.getByRole('heading', { name: 'Security', level: 2 })).toBeVisible();
  });

  test('query parameters drive filters', async ({ page }) => {
    await page.goto('/products?type=hardware&page=3');

    await expect(page.getByRole('heading', { name: 'Hardware' })).toBeVisible();
    await expect(page.getByText('Page 3')).toBeVisible();
  });

  test('browser back navigates history', async ({ page }) => {
    await page.goto('/');
    await page.getByRole('link', { name: 'Products' }).click();
    await page.waitForURL('/products');
    await page.getByRole('link', { name: 'About' }).click();
    await page.waitForURL('/about');

    await page.goBack();
    await expect(page).toHaveURL(/\/products/);

    await page.goBack();
    await expect(page).toHaveURL(/\/$/);
  });
});
```

## Lazy-Loaded Modules

```typescript
test('lazy module loads without chunk errors', async ({ page }) => {
  const consoleErrors: string[] = [];
  page.on('console', (msg) => {
    if (msg.type() === 'error') consoleErrors.push(msg.text());
  });

  await page.goto('/');

  const chunkRequest = page.waitForResponse((r) =>
    r.url().includes('.js') && r.status() === 200
  );
  await page.getByRole('link', { name: 'Analytics' }).click();
  await chunkRequest;

  await page.waitForURL('/analytics');
  await expect(page.getByRole('heading', { name: 'Analytics' })).toBeVisible();

  const chunkErrors = consoleErrors.filter(
    (e) => e.includes('ChunkLoadError') || e.includes('Loading chunk')
  );
  expect(chunkErrors).toEqual([]);
});
```

## Signals and Observables

Playwright cannot subscribe to observables or read signals directly. Test through the rendered output.

```typescript
test.describe('signals through UI', () => {
  test('signal-based counter updates DOM', async ({ page }) => {
    await page.goto('/counter');

    await expect(page.getByTestId('value')).toHaveText('0');

    await page.getByRole('button', { name: 'Increment' }).click();
    await expect(page.getByTestId('value')).toHaveText('1');

    await page.getByRole('button', { name: 'Reset' }).click();
    await expect(page.getByTestId('value')).toHaveText('0');
  });

  test('computed signal updates derived values', async ({ page }) => {
    await page.goto('/cart');
    await expect(page.getByTestId('total')).toHaveText('$0.00');

    await page.goto('/catalog');
    await page.getByRole('listitem')
      .filter({ hasText: '$19.99' })
      .getByRole('button', { name: 'Add' })
      .click();

    await page.getByRole('link', { name: 'Cart' }).click();
    await expect(page.getByTestId('total')).toHaveText('$19.99');
  });
});

test.describe('observables through UI', () => {
  test('debounced search batches API calls', async ({ page }) => {
    await page.goto('/search');

    const apiCalls: string[] = [];
    await page.route('**/api/search*', async (route) => {
      apiCalls.push(route.request().url());
      await route.continue();
    });

    await page.getByRole('textbox', { name: 'Search' }).pressSequentially('playwright', {
      delay: 50,
    });

    await expect(page.getByRole('listitem')).toHaveCount(5);
    expect(apiCalls.length).toBeLessThanOrEqual(2);
  });

  test('switchMap cancels stale requests', async ({ page }) => {
    await page.goto('/search');

    await page.getByRole('textbox', { name: 'Search' }).fill('initial');
    await page.getByRole('textbox', { name: 'Search' }).fill('final');

    await expect(page.getByRole('listitem').first()).toContainText(/final/i);
  });
});
```

## Zone.js and Change Detection

Angular uses Zone.js for change detection. Playwright does not depend on Zone.js and interacts with the DOM directly.

- **Change detection timing**: After interactions, Angular schedules change detection via Zone.js. Playwright's auto-waiting handles this.
- **Zoneless Angular**: Angular 17+ supports zoneless change detection. Tests work identically since Playwright waits for DOM changes.
- **Long-running async**: `setInterval` or long-running observables keep Angular "not stable." This does not affect Playwright (unlike Protractor).

## SSR Testing

```typescript
// playwright.config.ts for SSR
webServer: {
  command: process.env.CI
    ? 'npx ng build --ssr && node dist/my-app/server/server.mjs'
    : 'npx ng serve --ssr',
  url: 'http://localhost:4200',
  reuseExistingServer: !process.env.CI,
  timeout: 180_000,
},
```

```typescript
test('no hydration errors', async ({ page }) => {
  const errors: string[] = [];
  page.on('console', (msg) => {
    if (msg.type() === 'error' && msg.text().includes('hydration')) {
      errors.push(msg.text());
    }
  });

  await page.goto('/');
  await page.getByRole('button', { name: 'Get started' }).click();

  expect(errors).toEqual([]);
});
```

## Protractor Migration Reference

| Protractor | Playwright |
|---|---|
| `element(by.css('.btn'))` | `page.getByRole('button', { name: '...' })` |
| `element(by.id('login'))` | `page.getByTestId('login')` |
| `element(by.buttonText('Submit'))` | `page.getByRole('button', { name: 'Submit' })` |
| `element(by.model('user.name'))` | `page.getByLabel('Name')` |
| `element(by.binding('user.name'))` | `page.getByText(expectedValue)` |
| `element(by.repeater('item in items'))` | `page.getByRole('listitem')` |
| `browser.waitForAngular()` | Not needed — Playwright auto-waits |
| `browser.sleep(3000)` | `await expect(locator).toBeVisible()` |
| `browser.get('/path')` | `await page.goto('/path')` |
| `protractor.ExpectedConditions` | `await expect(locator).toBeVisible()` |

## Build Configurations

| Scenario | Command | Notes |
|---|---|---|
| Local dev | `npx ng serve` | Fast rebuild, source maps |
| CI production | `npx ng build && npx http-server dist/app/browser -p 4200 -s` | Tests production bundle |
| CI SSR | `npx ng build --ssr && node dist/app/server/server.mjs` | Tests server-side rendering |
| Staging | No `webServer` | Point `baseURL` to staging URL |

The `-s` flag on `http-server` enables SPA fallback for Angular Router.

## CDK Overlay Container

Angular Material and CDK render overlays (dialogs, menus, selects) in a special container outside the component tree. Playwright sees these as regular DOM elements:

```typescript
const dialog = page.getByRole('dialog');
const menu = page.getByRole('menu');
const listbox = page.getByRole('listbox');
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|---|---|---|
| `page.locator('[_ngcontent-xyz]')` | Scoped style attributes change every build | Use `getByRole`, `getByLabel`, `getByTestId` |
| `page.locator('[ng-reflect-model]')` | Only exists in dev mode | Test rendered value: `expect(input).toHaveValue()` |
| `page.locator('app-my-component')` | Component selectors are implementation details | Target rendered content with semantic locators |
| `page.locator('.mat-mdc-button')` | Material classes change between versions | `page.getByRole('button', { name: '...' })` |
| `page.evaluate(() => window.ng)` | Not available in production builds | Test through the DOM |
| `await page.waitForTimeout(500)` | Zone.js timing varies | Use auto-retrying assertions |
| `browser.waitForAngular()` | Does not exist in Playwright | Remove entirely |
| `ng serve` in CI | Slower, includes debug code | Use `ng build && http-server` |

## Related

- [core/locators.md](../core/locators.md) — locator strategies for Angular Material
- [core/assertions-waiting.md](../core/assertions-waiting.md) — auto-waiting assertions
- [core/forms-validation.md](../testing-patterns/forms-validation.md) — form testing patterns
- [architecture/test-architecture.md](../architecture/test-architecture.md) — E2E vs unit tests with TestBed
