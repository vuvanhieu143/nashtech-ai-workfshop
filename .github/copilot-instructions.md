# Copilot Instructions

## Project

URL shortener. PHP (Slim) backend, OAuth2 auth, SQLite storage, Tailwind + Alpine.js frontend.

## Stage routing

| SDLC stage | Switch to | Reads from |
|---|---|---|
| Requirements | `agents/ba.agent.md` | `docs/requirements/` |
| Design & Build | `agents/developer.agent.md` | `docs/design/`, `docs/CODING_STANDARDS.md` |
| Test | `agents/tester.agent.md` | `docs/planning/`, `tests/` |
| Review | `agents/reviewer.agent.md` | diff, `docs/CODING_STANDARDS.md` |

## How to switch persona

Persona files are plain markdown, not a VS Code custom chat mode — this keeps them portable and independent of editor/policy settings.

When the mob moves to a new SDLC stage:

1. **Start a new Copilot Chat session** (don't keep switching persona mid-thread — the old persona's framing lingers and pollutes output).
2. Reference the matching agent file first thing: `#file:agents/<role>.agent.md`.
3. Then give the actual task, scoped with `#file`/`#selection` for the relevant artifact (e.g. the user story being implemented).

Example: starting the Build stage for `US-01`:
```
#file:agents/developer.agent.md #file:docs/requirements/US-01-create-short-link.md
Implement this story following docs/CODING_STANDARDS.md.
```

## Rules

- Store every artifact in the repo, never only in chat.
- Prefer scoped context (`#file`, `#selection`) over dumping the whole repo.
- Follow `docs/CODING_STANDARDS.md` for all code changes.
- Keep diffs small; commit after every working slice.

## Skills

| Skill | Applies to |
|---|---|
| `.github/skills/php-slim-clean-arch/SKILL.md` | any change under `src/`, `public/index.php` |
| `.github/skills/js-alpine-reactive/SKILL.md` | any change under `resources/js/`, inline `x-data` |
| `.github/skills/html-tailwind-ui/SKILL.md` | any change under `public/views/`, `resources/css/` |
