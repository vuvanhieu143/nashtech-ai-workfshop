# HTML + Tailwind UI

Use this skill when modifying server-rendered HTML, Tailwind CSS, or Alpine.js markup in the URL shortener UI.

## Principles

- Build simple, accessible interfaces.
- Prefer semantic HTML.
- Use Tailwind utility classes consistently with the existing project.
- Keep markup readable.
- Avoid unnecessary custom CSS.
- Do not introduce a new UI framework.

## Accessibility

Use semantic elements and accessible names.

Prefer:

```html
<button type="submit">Create short URL</button>
```

over:

```html
<div class="button">Create short URL</div>
```

Form controls must have associated labels.

Interactive elements must be keyboard accessible.

Do not remove visible focus indicators without providing an equivalent accessible focus state.

## Tailwind

Prefer existing project utilities and patterns.

Keep responsive behavior explicit where required:

```html
<div class="flex flex-col gap-4 md:flex-row">
```

Avoid excessive arbitrary values when existing Tailwind utilities are sufficient.

Avoid duplicating long class lists when an existing project component/pattern already provides the same behavior.

## Build Configuration

Do not assume a particular Tailwind configuration file exists.

Before changing Tailwind configuration:

1. Inspect the existing build setup.
2. Identify where Tailwind sources/content are configured.
3. Change the existing configuration rather than introducing a second configuration mechanism.

Keep generated CSS limited to styles actually used by the application.

## Forms

Use:

- semantic `<form>` elements;
- `<label>` elements;
- appropriate input types;
- useful validation messages;
- accessible error association.

Example:

```html
<label for="long-url">Long URL</label>
<input
    id="long-url"
    name="long_url"
    type="url"
    required
    aria-describedby="long-url-error"
>
<p id="long-url-error" role="alert"></p>
```

## Responsive UI

Design for small screens first.

Verify important flows at:

- mobile width;
- desktop width.

Do not add layout complexity without a requirement.

## Alpine.js

Use Alpine only for local reactive behavior that cannot be handled cleanly by normal HTML/server rendering.

Keep state local and minimal.

Do not duplicate server-side business logic in Alpine.

For Alpine-specific patterns, use:

`.github/skills/js-alpine-reactive/SKILL.md`

## Security

Escape user-controlled output.

Do not insert untrusted values into HTML using unsafe DOM APIs.

Do not expose:

- secrets;
- OAuth tokens;
- session identifiers;
- internal configuration.

## UI Verification

For user-visible changes:

- verify the relevant acceptance criteria;
- verify keyboard accessibility;
- verify important responsive states;
- use Playwright for browser-level behavior when required by the story.

Do not add UI tests for behavior outside the approved scope.

## Guardrails

- Do not introduce another CSS framework.
- Do not assume nonexistent configuration files.
- Do not rewrite unrelated UI.
- Do not add unnecessary custom CSS.
- Do not move business logic into templates or Alpine.
- Do not weaken accessibility to simplify implementation.