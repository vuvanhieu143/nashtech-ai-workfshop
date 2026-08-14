# NashTech AI-Native Workshop — URL Shortener

Team project for the AI-Native Workshop. Built end-to-end with GitHub Copilot Agent mode.

## Tech stack

- Backend: PHP 8.4 (Slim)
- Auth: OAuth2
- Storage: SQLite
- Frontend: Tailwind CSS + Alpine.js

## Structure

- `agents/` — role personas (BA / Dev / Test) for switching Copilot's focus per SDLC stage
- `.github/copilot-instructions.md` — global instructions & stage routing for Copilot
- `.github/skills/` — narrow, task-focused skills
- `docs/` — SDLC artifacts (requirements, design, planning), coding standards, token log
- `scripts/` — environment checks and setup automation

## Getting started

```bash
./scripts/init.sh
```

Checks Docker/Node, creates `.env` from `.env.example`, builds and starts the
`app` container (PHP built-in server on port 8080), applies the SQLite schema,
and builds the frontend assets on the host. Then open http://localhost:8080.

Handy afterwards:

| Command | What it does |
|---|---|
| `docker compose logs -f app` | Tail the PHP server log |
| `docker compose exec app composer <cmd>` | Run Composer in the container |
| `docker compose exec app php scripts/migrate.php` | Re-apply `scripts/schema.sql` |
| `docker compose down` | Stop the container |

Code is bind-mounted, so host edits are live — no rebuild needed unless the
`Dockerfile` changes.
