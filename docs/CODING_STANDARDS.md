# Coding Standards

Layer-specific architecture and naming rules live in `.github/skills/php-slim-clean-arch/SKILL.md`, `.github/skills/js-alpine-reactive/SKILL.md`, `.github/skills/html-tailwind-ui/SKILL.md`. This file covers what's shared across the whole app.

## Code style

- PSR-12 for all PHP. Run `composer cs-check` before committing (add via `friendsofphp/php-cs-fixer` or `squizlabs/php_codesniffer`).
- `declare(strict_types=1);` at the top of every PHP file.

## Error handling

- Use cases return a typed DTO or throw a domain-specific exception (e.g. `InvalidUrlException`) — never return `null`/`false` to signal failure.
- Controllers catch domain exceptions at the boundary and map them to HTTP status codes (400 for validation, 401/403 for auth, 404 for unknown short code, 500 for unexpected). No `try/catch` inside use cases swallowing errors silently.
- Log unexpected (500-class) errors; don't log expected domain exceptions (400/404) as errors — they're normal flow.

## Testing conventions

- PHPUnit 11, attribute-based (`#[Test]`, not `/** @test */` docblocks).
- One test class per class under test, mirroring the `src/` path under `tests/Unit/`.
- Domain/Application logic: TDD, per `agents/developer.agent.md`.
- E2E (Playwright): one spec per MVP flow, in `tests/e2e/`, owned by the Tester agent.

## Commits

- Conventional commits style: `feat:`, `fix:`, `test:`, `docs:`, `chore:`. Scope to the layer or story when useful (e.g. `feat(links): add short code generation`).
- Commit after every green (working) slice — don't batch a whole user story into one commit.

## Environment / config

- All config via `.env` (see `.env.example`), read through a single config accessor — no `getenv()` calls scattered across the codebase.
- Never commit `.env` or `database.sqlite`.

## Frontend Dependencies

All frontend runtime and build dependencies must be installed locally through npm.

Do not use CDN-hosted libraries or assets.

Examples of prohibited usage:

- Tailwind CDN
- Alpine.js CDN
- JavaScript libraries loaded from `<script src="https://...">`
- CSS libraries loaded from external URLs
- External runtime dependencies without a package-lock entry

Use `package.json` and `package-lock.json` for frontend dependencies.

Production pages must work without access to a third-party CDN.