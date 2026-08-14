# Copilot Instructions

## Project

URL shortener:

- PHP 8.4 + Slim Framework
- OAuth2 authentication
- SQLite
- Tailwind CSS
- Alpine.js

## Workflow

All work follows:

**Requirements → Design → Planning → Implementation → Verify → Review → Human Gate**

Full workflow, gates, failure routing, Ralph rules, and Definition of Done:

`docs/SDLC_WORKFLOW.md`

Read that file when workflow details are required. Do not duplicate or redefine its rules here.

## Stage Routing

| Stage | Persona | Primary Output |
|---|---|---|
| 1 Requirements | `.github/agents/ba.agent.md` | `docs/requirements/US-XX-<slug>.vN.md` |
| 2 Design | `.github/agents/architect.agent.md` | `docs/design/US-XX-<slug>.vN.md` |
| 3 Planning | `.github/agents/architect.agent.md` | `docs/planning/US-XX-<slug>.vN.md` |
| 4 Implementation | `.github/agents/developer.agent.md` | Source + tests |
| 5 Verify | `.github/agents/tester.agent.md` | Verification evidence |
| 6 Review | `.github/agents/reviewer.agent.md` | Review result |
| 7 Human Gate | Human | Final decision |

Use the persona for the current stage. Do not perform another stage's work unless the workflow explicitly routes back to it.

## Core Rules

- Never bypass an SDLC gate.
- Never implement against an unapproved upstream artifact.
- Never silently change approved scope, requirements, design, or planning.
- Never overwrite or delete a previous artifact version.
- Create `v1` first, then `v2`, `v3`, etc. for revisions.
- Never treat `APPROVED`, passing tests, or `REVIEW_PASSED` as human acceptance.
- Only a human may set `ACCEPTED`.
- Keep changes within the approved planning task.
- Prefer the smallest change that solves the task.
- Do not weaken, remove, or bypass tests.
- Do not perform unrelated refactoring.

## Context

Start with the smallest relevant context:

1. Current approved artifact.
2. Relevant upstream artifacts.
3. Relevant source files.
4. Relevant tests.
5. Applicable skill.
6. Current state in `docs/progress.md`.

Do not scan the entire repository unnecessarily.

Repository artifacts are the source of truth; chat history is not.

## Skills

Load a skill only when modifying its area:

| Change | Skill |
|---|---|
| PHP / `src/` / `public/index.php` | `.github/skills/php-slim-clean-arch/SKILL.md` |
| JS / Alpine.js | `.github/skills/js-alpine-reactive/SKILL.md` |
| Views / Tailwind CSS | `.github/skills/html-tailwind-ui/SKILL.md` |
| Tests / E2E | `.github/skills/playwright-accessible-e2e/SKILL.md` |

## State and Audit

Use:

- `docs/progress.md` — current workflow state
- `docs/stage-scores.md` — stage audit scores
- `docs/symbol-map.md` — architecture references
- `docs/SDLC_WORKFLOW.md` — workflow source of truth

Keep state updates small and factual.

## Implementation

Before coding:

1. Confirm the current stage and approved planning task.
2. Read the approved requirements, design, and planning artifacts.
3. Inspect only relevant code and tests.
4. Load applicable skills.
5. Make the smallest required change.
6. Add or update tests.
7. Hand off to Stage 5 Verify.

## Commits

- Keep commits small and focused.
- Prefer one commit per completed planning task.
- Do not mix unrelated refactoring, formatting, dependency updates, or cleanup with feature work.

## Completion

Follow the Definition of Done in:

`docs/SDLC_WORKFLOW.md`

Do not declare a story complete or `ACCEPTED` without the required Human Gate.