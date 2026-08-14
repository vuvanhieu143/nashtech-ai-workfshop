# Playwright Accessible E2E

Use Playwright for browser-level verification of approved acceptance criteria.

## When to Use

Use this skill for:

- End-to-end user flows.
- Accessibility-sensitive interactions.
- Authentication/session flows.
- URL shortening and redirect flows.
- Link management flows.
- Acceptance-criteria verification.

Do not use E2E tests when a unit or integration test can verify the behavior more directly.

## Test Structure

Organize tests by user story or feature.

Prefer:

```text
tests/e2e/
├── auth/
├── links/
└── redirect/
```

Keep each test focused on one behavior or acceptance criterion.

## Locators

Prefer accessible, user-facing locators:

```typescript
page.getByRole(...)
page.getByLabel(...)
page.getByPlaceholder(...)
page.getByText(...)
```

Use CSS selectors only when an accessible locator is not practical.

Avoid:

```typescript
page.locator('.btn-primary')
page.locator('#some-generated-id')
```

Avoid selectors coupled to implementation details.

## Assertions

Assert observable user-facing behavior.

Prefer:

```typescript
await expect(page.getByRole('heading', {name: 'Links'})).toBeVisible();
await expect(page.getByRole('link', {name: /example/i})).toBeVisible();
```

Do not use arbitrary sleeps.

Avoid:

```typescript
await page.waitForTimeout(1000);
```

Wait for a meaningful condition instead:

```typescript
await expect(page.getByRole('heading', {name: 'Links'})).toBeVisible();
```

## Authentication

Use the project's existing authentication/session mechanism.

Do not hard-code real credentials.

Prefer reusable authenticated test setup when multiple tests require the same authenticated state.

Never commit:

- passwords;
- OAuth client secrets;
- access tokens;
- refresh tokens;
- session cookies.

Use test-only credentials supplied through the test environment.

## Test Data

Prefer deterministic, isolated test data.

Test data may be created through:

1. Existing application APIs intended for test setup.
2. Dedicated test fixtures.
3. Direct database setup when no suitable application-level mechanism exists.

Do not depend on manually created records.

Each test should avoid modifying data required by another test.

## URL Shortener Tests

For URL creation, verify the complete observable flow:

1. Authenticate when required.
2. Submit a valid long URL.
3. Verify the short URL is displayed.
4. Open the short URL.
5. Verify the redirect reaches the expected destination.

Also cover important negative cases defined by the approved requirements, such as invalid or unsupported URLs.

## Link Management Tests

Verify only behaviors required by the approved acceptance criteria, for example:

- viewing links;
- deleting a link;
- verifying the deleted link is no longer available.

Do not add tests for functionality outside the approved story.

## OAuth2 Tests

Verify the observable authentication flow:

- unauthenticated access behaves correctly;
- login redirects to the expected provider flow;
- successful authentication creates the expected session;
- protected resources require authentication;
- logout invalidates the authenticated state.

Use test providers/mocks where appropriate. Do not call production OAuth providers from automated tests.

## Accessibility

Prefer accessible roles, labels, names, and keyboard-compatible interactions.

A test should fail if the intended user-facing control cannot be located through its accessible interface.

Do not add accessibility assertions unrelated to the current acceptance criteria unless the test is explicitly an accessibility test.

## Isolation

Tests should be independent.

Do not rely on:

- execution order;
- state left by another test;
- a previous browser session;
- manually seeded production-like data.

Use unique test data where concurrent execution could cause collisions.

## Failure Diagnostics

When tests fail, preserve useful diagnostics through the existing Playwright configuration.

Prefer:

- trace on failure;
- screenshot on failure;
- relevant console/network information.

Do not add custom logging unless it materially improves diagnosis.

## Verification Rules

Before reporting Stage 5 Verify as passed:

- Run the relevant E2E tests.
- Confirm the test corresponds to the approved acceptance criterion.
- Confirm relevant regression tests pass.
- Record concrete evidence.
- Report infrastructure failures separately from application failures.

Do not modify production code while acting as Tester.

## Guardrails

- Do not weaken assertions to make tests pass.
- Do not delete failing tests.
- Do not use arbitrary waits.
- Do not use production credentials or services.
- Do not test functionality outside the approved scope.
- Do not treat a passing E2E test as human approval.