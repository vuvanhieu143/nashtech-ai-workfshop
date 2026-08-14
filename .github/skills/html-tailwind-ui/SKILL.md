---
name: html-tailwind-ui
description: Tailwind CSS layout & styling conventions for this project's HTML views
---

# Tailwind UI Conventions

**Trigger:** any change under `public/views/` or `resources/css/`.

## Utility-first, no custom CSS unless necessary

Compose Tailwind utility classes directly in markup. Only add a rule to `resources/css/app.css` (via `@layer components`) when the same utility combination repeats 3+ times across views — extract a class then, not before.

## Layout

- Page shell: `max-w-3xl mx-auto px-4` for content-focused pages (this app has no dense dashboards, keep it narrow and readable).
- Stack spacing with `space-y-*` on the parent rather than margin on every child.
- Responsive: design mobile-first (unprefixed classes = mobile), add `sm:`/`md:` only where the layout genuinely needs to change on wider screens.

## Forms

- Inputs: `border rounded px-3 py-2 w-full focus:outline-none focus:ring-2`
- Primary action button: `bg-blue-600 text-white rounded px-4 py-2 hover:bg-blue-700 disabled:opacity-50` — bind `disabled` to the Alpine `loading` state from `js-alpine-reactive`.
- Error text: `text-red-600 text-sm mt-1`, shown via `x-show="error"`.

## Build

- `tailwind.config.js` content globs must cover `public/views/**/*.html` and `resources/js/**/*.js` — anything outside those won't be scanned and its classes get purged.
- Target: keep the built CSS under 15KB (per `tailwind.config.js` purge config) — this is a workshop demo, don't add plugins/utilities you're not using.

## What to avoid

- No inline `style="..."` attributes — everything through Tailwind classes.
- No component library (DaisyUI, Flowbite, etc.) — adds setup time and a dependency the mob doesn't need to learn mid-workshop.
