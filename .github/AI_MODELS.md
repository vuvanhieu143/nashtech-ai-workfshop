# AI Model Policy

Model selection is centralized here.

## Profiles

| Profile | Model | Use |
|---|---|---|
| `CHEAP` | Claude Haiku | Simple analysis, planning, verification |
| `BALANCED` | Claude Sonnet | Normal architecture, coding, review |
| `DEEP` | Claude Opus | Complex architecture, security, difficult debugging |

## Agent Routing

| Agent | Stage | Profile |
|---|---|---|
| BA | Requirements | `CHEAP` |
| Architect | Design | `BALANCED` |
| Architect | Planning | `CHEAP` |
| Developer | Implementation | `BALANCED` |
| Tester | Verify | `CHEAP` |
| Reviewer | Review | `BALANCED` |
| Human | Human Gate | Human |

## Escalation

Use `DEEP` only when the assigned model cannot reliably complete the task.

Valid escalation cases:

- Complex architecture conflict.
- Significant security issue.
- Repeated implementation failure.
- Difficult cross-layer debugging.
- High-impact design decision.

Do not use `DEEP` for routine work.

## Token Rules

- Use the lowest-cost profile capable of completing the task.
- Keep context limited to the current SDLC stage.
- Read approved artifacts before unrelated repository files.
- Avoid repository-wide exploration unless necessary.
- Do not repeat information already available in artifacts.
- Keep responses and artifacts concise.
- Do not escalate solely because a task is inconvenient.

## Model Selection

Agents must follow the profile assigned to their stage.

The profile is a policy label, not a literal model identifier. The actual provider/model mapping is controlled by the GitHub Copilot environment.

If the configured model is unavailable, use the closest available model with the same capability level rather than silently selecting a more expensive model.

## Human Gate

No AI model can perform the Human Gate.

AI may recommend:

- `APPROVE`
- `REVISE`
- `REJECT`

Only a human can make the final decision and set:

`ACCEPTED`