# Stage Scores

| Story | Stage | Version | Score | Status | Blocking |
|---|---|---:|---:|---|---|
| - | - | - | - | - | - |

## Rules

- `>= 80` → `APPROVED`
- `< 80` → `REJECTED`
- Blocking findings must be resolved before advancing.
- Detailed findings belong in the relevant versioned artifact.
- Every score must reference the exact artifact version being evaluated.
- Never overwrite an earlier score; add a new row for a new artifact version or review.
- A score of `>= 80` means the stage passed its automated/agent gate only.
- `APPROVED` never means human acceptance.
- Only a human may set the final story status to `ACCEPTED`.

## Stage Statuses

| Status | Meaning |
|---|---|
| `APPROVED` | Stage passed its defined quality threshold |
| `REJECTED` | Stage failed and has blocking findings |
| `REVIEW_PASSED` | Code review passed and is ready for Human Gate |
| `REVIEW_BLOCKED` | Code review has blocking findings |
| `HUMAN_APPROVED` | Human explicitly approved the stage |
| `ACCEPTED` | Human explicitly accepted the completed story |

## Stage Mapping

| Stage | Name | Primary Evidence |
|---:|---|---|
| 1 | Requirements | Requirements artifact |
| 2 | Design | Design artifact |
| 3 | Planning | Planning artifact |
| 4 | Implementation | Source changes + tests |
| 5 | Verify | Verification evidence |
| 6 | Review | Review findings + score |
| 7 | Human Gate | Explicit human decision |

## Scoring

Scores are out of 100.

A score must be based on the criteria defined for the relevant stage. Do not use a score to bypass a required human gate.

A passing score indicates that the agent considers the stage ready to advance. It does not grant permission to merge or declare the story accepted.