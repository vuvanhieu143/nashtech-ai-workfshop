# Progress

Pre-workshop prep for the AI-Native Workshop (URL shortener, PHP 8.4/Slim, OAuth2, SQLite, Tailwind + Alpine.js, Docker).

## Done

- **Product brief** (`docs/product-brief.md`) — MVP locked: Shorten URL, Redirect, OAuth2 login. Out of scope: click stats, custom alias, expiration date.
- **Harness routing** (`.github/copilot-instructions.md`) — stage → agent → skill table, plus how to switch persona (new chat session + `#file`, not a custom chat mode — kept tool-agnostic).
- **Agents** (`agents/*.agent.md`) — BA, Developer, Tester, Reviewer personas, each with workflow + guardrails specific to this project (e.g. Developer: task-breakdown-first, TDD only for Domain/Application logic; Tester: E2E on all 3 MVP flows, no unit tests; Reviewer: reviews every diff, code-only, no re-running tests).
- **Skills** (`.github/skills/*/SKILL.md`) — `php-slim-clean-arch` (4-layer Clean Architecture, PHP-DI, naming), `js-alpine-reactive` (local state, API call pattern, `Alpine.store()` only for cross-component state), `html-tailwind-ui` (utility-first, form/button conventions, 15KB build budget).
- **Coding standards** (`docs/CODING_STANDARDS.md`) — PSR-12, error handling (typed exceptions, no silent `null`/`false`), PHPUnit conventions, commit style, `.env`-only config.
- **Docker + init script** — `Dockerfile` (`php:8.4-cli` + composer), `docker-compose.yml` (single `app` service, bind-mounted, `php -S` on :8080), `scripts/init.sh` (env checks → `.env` → build/up → composer install → schema migrate → host-side npm build), `scripts/schema.sql` + `scripts/migrate.php` (`users` + `short_links` tables).
- **Verified working**: pulled `php:8.4-cli` and confirmed `pdo_sqlite`/`sqlite3` are bundled; ran `init.sh` end-to-end; container up on :8080; schema applied correctly to `database.sqlite`.

## Not started

- `src/`, `public/`, `tests/` — intentionally left as placeholders, to be built during the workshop (Part 03-04).
- `composer.json` / `package.json` — not scaffolded yet; `init.sh` skips these steps gracefully until they exist.
- User stories (`docs/requirements/`) — to be written live by the BA agent on the day.

## Open decisions for the team

- OAuth provider (GitHub OAuth suggested — simpler setup than Google).
- Whether to test the OAuth2 callback flow early on the day, before Requirements stage, to de-risk it.
