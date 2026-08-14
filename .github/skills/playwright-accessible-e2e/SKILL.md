# Skill: Accessible and Isolated Playwright E2E Testing

> **File Path:** `.github/skills/playwright-accessible-e2e/SKILL.md`

## Overview

Adopted from Moodle's rigorous Behat testing philosophy, E2E tests in this repository must prioritize **isolation, performance through backend data seeding, and accessibility-driven locators** over fragile UI automation hacks.

---

## Core Principles

### 1. Test One Thing Per Spec
* **Goal:** Each test block (`test('...')`) verifies just one specific piece of functionality.
* **Benefit:** If a test fails, the test name tells you precisely what bug was introduced, ensuring any single bug causes only one test to fail rather than cascading failures across unrelated flows.
* **Rule:** Keep assertions focused. Avoid long, multi-purpose user journeys in a single test unless validating a complete core integration flow (like the full OAuth login + shorten loop).

### 2. Set-up via Database/API, Not the UI
* **Rule:** The setup phase of a test should never use the UI. Setup is not what you are testing, so it must be as quick and reliable as possible.
* **Why:** UI-based setup is slow, brittle, and prone to flakiness due to rendering states or network latency.
* **Implementation:** Use test hooks (`beforeEach`) or direct database seeding scripts/API endpoints to insert test data (e.g., pre-creating users or short links directly in SQLite) before navigating to the target view.

### 3. Avoid Raw XPath or CSS Selectors — Fix Accessibility Issues Instead
* **Rule:** Playwright should interact with the page the way a screen-reader or keyboard user experiences it. If the only way to identify an element is via a raw XPath or deep CSS selector, it is almost always a sign of an **Accessibility issue** (missing labels, ARIA attributes, or semantic tags).
* **Locate by Semantics:** Always prefer Playwright's built-in accessibility-first locators:
  * `page.getByRole()`
  * `page.getByLabel()`
  * `page.getByPlaceholder()`
  * `page.getByText()`

---

## Code Conventions: Don't vs. Do

### ❌ Don't (Fragile & Inaccessible)
```typescript
// Relies on raw XPath or deep CSS selectors, signaling poor markup accessibility
await page.locator('//textarea[@name="long_url"]').fill('[https://example.com/long-path](https://example.com/long-path)');
await page.click('#submit-btn-1 .spinner-overlay');
await expect(page.locator('.alert-success')).toHaveText('Short link created');
// Relies on accessible roles, labels, and text matching user perception
await page.getByLabel('Answer').fill('frog');
await page.getByRole('radio', { name: 'True' }).click();