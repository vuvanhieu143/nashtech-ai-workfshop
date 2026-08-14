# Progress & SDLC State Machine

Pre-workshop prep for the AI-Native Workshop (URL shortener, PHP 8.4/Slim, OAuth2, SQLite, Tailwind + Alpine.js, Docker).

---

## 📊 SDLC Gate & Quality Policy
- **Sequential Pipeline:** `Stage 1 (Requirements) ➔ Stage 2 (Design) ➔ Stage 3 (Planning) ➔ Stage 4 (Implementation)`
- **Gate Pass Threshold:** Every stage artifact must achieve a **Quality Score ≥ 80/100** in `docs/stage-scores.md` before advancing.
- **Token Efficiency:** Agents must read *only* the specific context pointer artifacts listed for their active stage.

---

## ✅ Completed Prep Tasks (Done)

- **Product brief** (`docs/product-brief.md`) — MVP locked: Shorten URL, Redirect, OAuth2 login. Out of scope: click stats, custom alias, expiration date.
- **Harness routing** (`.github/copilot-instructions.md`) — stage → agent → skill table, plus how to switch persona (new chat session + `#file`, not a custom chat mode — kept tool-agnostic).
- **Agents** (`agents/*.agent.md`) — BA, Developer, Tester, Reviewer personas, each with workflow + guardrails specific to this project (e.g. Developer: task-breakdown-first, TDD only for Domain/Application logic; Tester: E2E on all 3 MVP flows, no unit tests; Reviewer: reviews every diff, code-only, no re-running tests).
- **Skills** (`.github/skills/*/SKILL.md`) — `php-slim-clean-arch` (4-layer Clean Architecture, PHP-DI, naming), `js-alpine-reactive` (local state, API call pattern, `Alpine.store()` only for cross-component state), `html-tailwind-ui` (utility-first, form/button conventions, 15KB build budget).
- **Coding standards** (`docs/CODING_STANDARDS.md`) — PSR-12, error handling (typed exceptions, no silent `null`/`false`), PHPUnit conventions, commit style, `.env`-only config.
- **Docker + init script** — `Dockerfile` (`php:8.4-cli` + composer), `docker-compose.yml` (single `app` service, bind-mounted, `php -S` on :8080), `scripts/init.sh` (env checks → `.env` → build/up → composer install → schema migrate → host-side npm build), `scripts/schema.sql` + `scripts/migrate.php` (`users` + `short_links` tables).
- **Verified working**: pulled `php:8.4-cli` and confirmed `pdo_sqlite`/`sqlite3` are bundled; ran `init.sh` end-to-end; container up on :8080; schema applied correctly to `database.sqlite`.
- **Artifact Templates** (`docs/templates/`) — Created high-density Markdown templates for Requirements (`REQUIREMENTS.md`), Design (`DESIGN.md`), and Planning (`PLANNING.md`).

---

## ⏳ Not Started (Workshop Work)

- `src/`, `public/`, `tests/` — intentionally left as placeholders, to be built during the workshop (Part 03-04).
- `composer.json` / `package.json` — not scaffolded yet; `init.sh` skips these steps gracefully until they exist.
- User stories (`docs/requirements/`) — to be written live by the BA agent on the day.

---

## 📋 Active Backlog & State Machine

| US ID | Title | Priority | Current Stage | Overall Status |
| :--- | :--- | :--- | :--- | :--- |
| **US-01** | Core Shorten & Redirect API | High | Stage 1 (Requirements) | READY_TO_START |
| **US-02** | OAuth2 User Authentication | High | Backlog | NOT_STARTED |

---

## 🔍 Lifecycle Traceability Matrix

### US-01: Core Shorten & Redirect API

- [ ] **Stage 1: Requirements (BA Agent)**
  - **Context Pointer:** Read `docs/product-brief.md`, write to `docs/requirements/US-01.md`
  - **Template:** `docs/templates/REQUIREMENTS.md`
  - **Gate Condition:** Score ≥ 80/100 in `docs/stage-scores.md`
  - **Status:** Pending Execution

- [ ] **Stage 2: Technical Design (Developer Agent)**
  - **Context Pointer:** Read `docs/requirements/US-01.md` & `docs/symbol-map.md`, write to `docs/design/US-01.md`
  - **Template:** `docs/templates/DESIGN.md`
  - **Gate Condition:** Score ≥ 80/100 in `docs/stage-scores.md`
  - **Status:** Blocked by Stage 1

- [ ] **Stage 3: Planning (Tester Agent)**
  - **Context Pointer:** Read `docs/requirements/US-01.md` & `docs/design/US-01.md`, write to `docs/planning/US-01.md`
  - **Template:** `docs/templates/PLANNING.md`
  - **Gate Condition:** Score ≥ 80/100 in `docs/stage-scores.md`
  - **Status:** Blocked by Stage 2

- [ ] **Stage 4: Implementation (Dev & Reviewer Agents)**
  - **Context Pointer:** Read `docs/planning/US-01.md`
  - **Execution Sandbox:** Write code in `src/`, tests in `tests/`
  - **Gate Condition:** `./scripts/loop-check.sh` passes 100% + Checklist completed `[x]`
  - **Status:** Blocked by Stage 3

---

## 💡 Open Decisions for the Team

- OAuth provider (GitHub OAuth suggested — simpler setup than Google).
- Whether to test the OAuth2 callback flow early on the day, before Requirements stage, to de-risk it.