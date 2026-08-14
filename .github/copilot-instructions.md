# Copilot Instructions

## Project

URL shortener:

* PHP 8.4 + Slim Framework
* OAuth2 authentication
* SQLite
* Tailwind CSS
* Alpine.js

## SDLC

All work follows:

**Requirements → Design → Planning → Implementation → Verify/Review → Human Gate**

Detailed workflow:

`docs/SDLC_WORKFLOW.md`

Never:

* skip an SDLC stage;
* implement against an unapproved upstream artifact;
* change approved scope without returning to the affected stage;
* treat automated approval as human approval.

## Stage Artifacts

| Stage          | Artifact                        | Persona                     |
| -------------- | ------------------------------- | --------------------------- |
| Requirements   | `docs/requirements/US-XX.vN.md` | `agents/ba.agent.md`        |
| Design         | `docs/design/US-XX.vN.md`       | `agents/architect.agent.md` |
| Planning       | `docs/planning/US-XX.vN.md`     | `agents/architect.agent.md` |
| Implementation | `src/`, `tests/`, `public/`     | `agents/developer.agent.md` |
| Review         | source + tests                  | `agents/reviewer.agent.md`  |

Use the appropriate persona and applicable skill.

## Artifacts

* Start every artifact at `v1`.
* Never overwrite or delete previous versions.
* Revisions create a new version.
* Every artifact requires Revision History.
* Record audits in `docs/stage-scores.md`.
* Score >= 80/100 → `APPROVED`.
* Score < 80/100 → `REJECTED`.
* Update `docs/progress.md` with the latest approved state.

If an approved upstream artifact changes, re-audit affected downstream artifacts before implementation continues.

## Implementation

Before coding:

1. Identify the approved planning task.
2. Read the approved requirements and design.
3. Inspect relevant existing code and tests.
4. Load applicable skills.
5. Make the smallest change required.
6. Add or update tests.
7. Run relevant verification.

Do not implement unrelated functionality or refactoring.

## Ralph Loop

After Planning approval, implementation may use the bounded Ralph loop:

**Implement → Verify → Review → Fix → Repeat**

Rules:

* One planning task at a time.
* Fix the smallest root cause.
* Re-run failed verification after every fix.
* Run relevant regression tests.
* Do not weaken, remove, or bypass tests.
* Do not expand scope.
* Maximum 5 iterations by default.
* Stop and request human direction if the loop is exhausted, non-progressing, or discovers an upstream problem.

Ralph cannot approve requirements, design, planning, scope changes, security exceptions, or final completion.

## Human Gates

Explicit human approval is required:

1. Requirements → Design
2. Design → Planning
3. Planning → Implementation
4. Ralph → Completion
5. Final PR → Merge

Never infer human approval from passing tests, scores, agent output, or chat context.

## Skills

Load the applicable skill when modifying its area:

| Change                            | Skill                                               |
| --------------------------------- | --------------------------------------------------- |
| PHP / `src/` / `public/index.php` | `.github/skills/php-slim-clean-arch/SKILL.md`       |
| JS / Alpine.js                    | `.github/skills/js-alpine-reactive/SKILL.md`        |
| Views / Tailwind CSS              | `.github/skills/html-tailwind-ui/SKILL.md`          |
| Tests / E2E                       | `.github/skills/playwright-accessible-e2e/SKILL.md` |

## Commits

* Keep commits small and focused.
* Prefer one commit per completed planning task.
* Do not mix unrelated refactoring, formatting, dependency updates, or cleanup with feature work.

## Source of Truth

Project decisions must exist in repository artifacts.

Use:

* `docs/requirements/` — requirements
* `docs/design/` — technical design
* `docs/planning/` — implementation plan
* `docs/stage-scores.md` — audits
* `docs/progress.md` — current state
* `docs/symbol-map.md` — architecture references
* `docs/SDLC_WORKFLOW.md` — workflow and gates

The repository must remain understandable without previous chat history.

## Completion

Do not report a feature as complete until:

* Requirements approved
* Design approved
* Planning approved
* Implementation complete
* Tests pass
* Verification passes
* Review complete
* Ralph loop successfully exits
* Human approves completion
* `docs/progress.md` is updated
