# Copilot Instructions

## Project

URL shortener:

- PHP 8.4 + Slim Framework
- OAuth2 authentication
- SQLite
- Tailwind CSS
- Alpine.js

## SDLC

All features MUST follow:

Requirements → Design → Planning → Implementation

Never skip a stage or implement against an unapproved upstream artifact.

Detailed workflow:
`docs/SDLC_WORKFLOW.md`

## Stage Artifacts

| Stage | Read | Write | Auditor |
|---|---|---|---|
| Requirements | `docs/product-brief.md`, template | `docs/requirements/US-XX.vN.md` | `agents/ba.agent.md` |
| Design | approved requirements, `docs/symbol-map.md`, template | `docs/design/US-XX.vN.md` | `agents/architect.agent.md` |
| Planning | approved requirements + design, template | `docs/planning/US-XX.vN.md` | `agents/architect.agent.md` |
| Implementation | approved planning, coding standards | `src/`, `tests/`, `public/` | `agents/reviewer.agent.md` |

Use the appropriate persona file from `agents/`.

## Artifact Rules

- Start every artifact at `v1`.
- Never overwrite or delete previous versions.
- Revisions create a new version.
- Every artifact requires Revision History.
- Record audit results in `docs/stage-scores.md`.
- Score >= 80/100 → `APPROVED`.
- Score < 80/100 → `REJECTED`; create the next version and address all feedback.
- Update `docs/progress.md` with the latest approved version.

If an approved upstream requirement/design changes, create a new version and re-audit affected downstream artifacts before changing code.

## Context Guardrails

Do NOT scan or index the entire repository unnecessarily.

Read only:

1. The current stage's required artifacts.
2. The relevant source files.
3. Relevant tests.
4. Applicable skills.

Prefer the latest approved artifact only.

## Skills

Load the skill when modifying its area:

| Change | Skill |
|---|---|
| PHP / `src/` / `public/index.php` | `.github/skills/php-slim-clean-arch/SKILL.md` |
| JS / Alpine.js | `.github/skills/js-alpine-reactive/SKILL.md` |
| Views / Tailwind CSS | `.github/skills/html-tailwind-ui/SKILL.md` |
| Tests | `.github/skills/playwright-accessible-e2e/SKILL.md` |

## Implementation

Follow:

`docs/CODING_STANDARDS.md`

Before coding:

1. Identify the approved planning task.
2. Inspect relevant existing code and tests.
3. Load applicable skills.
4. Make the smallest change required.
5. Add/update tests.
6. Run relevant verification.
7. Mark the planning task `[x]` only after verification.

Do not implement unapproved functionality or unrelated refactoring.

## Commits

Keep commits small and focused.

Prefer one commit per completed planning task.

Do not mix unrelated refactoring, formatting, dependency updates, or cleanup with feature work.

## Source of Truth

Important decisions MUST exist in repository artifacts, not only in chat.

Use:

- `docs/requirements/` — requirements
- `docs/design/` — technical design
- `docs/planning/` — implementation plan
- `docs/stage-scores.md` — audits
- `docs/progress.md` — current state
- `docs/symbol-map.md` — architecture/symbol references

The repository must remain understandable without access to previous chat history.

## Completion

Do not report a feature as complete until:

- Requirements approved
- Design approved
- Planning approved
- Implementation complete
- Tests pass
- Planning checklist complete
- Review complete
- `docs/progress.md` updated