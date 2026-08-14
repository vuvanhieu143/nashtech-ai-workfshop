---
name: js-alpine-reactive
description: Alpine.js reactive UI patterns for this project's frontend — reusable across screens, not tied to a specific page
---

# Alpine.js Reactive Patterns

**Trigger:** any change under `resources/js/` or inline `x-data` in `public/views/`.

## Local component state

Scope `x-data` to the smallest element that needs it — a form, a card, a list — not the whole page.

```html
<div x-data="{ loading: false, error: null }">
  ...
</div>
```

For anything non-trivial, define the `x-data` object in `resources/js/components/<name>.js` and register it, rather than inlining a large object in HTML.

## API calls (loading/error pattern)

Every `fetch()` call follows this shape — no bare fetches without loading/error handling:

```js
async function submit() {
  this.loading = true;
  this.error = null;
  try {
    const res = await fetch('/links', { method: 'POST', body: JSON.stringify(this.form) });
    if (!res.ok) throw new Error(await res.text());
    this.result = await res.json();
  } catch (e) {
    this.error = e.message;
  } finally {
    this.loading = false;
  }
}
```

## List rendering

Use `x-for` with a `:key` bound to a stable id (never the array index):

```html
<template x-for="link in links" :key="link.id">
  <li x-text="link.shortCode"></li>
</template>
```

## Forms

Bind fields with `x-model`, validate client-side only for immediate feedback (required fields, URL format) — the real validation is server-side in the use case, don't duplicate business rules in JS.

## Shared state across components

Use `Alpine.store()` **only** for state genuinely needed in more than one place at once (e.g. logged-in user shown in both navbar and dashboard). Everything else stays local `x-data`.

```js
Alpine.store('auth', { user: null, isLoggedIn: false });
```

## What to avoid

- Don't reach for a build-heavy state library — Alpine + `Alpine.store()` covers this app's needs.
- Don't put business logic (short-code generation, auth checks) in JS — it belongs server-side; JS only reflects state.
