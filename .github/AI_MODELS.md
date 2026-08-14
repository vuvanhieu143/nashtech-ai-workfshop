# AI Model Policy

Model selection is optimized for cost while preserving reasoning quality where it matters.

## Profiles

| Profile | Model | Use |
|---|---|---|
| `CHEAP` | Claude Haiku | Requirements, planning, testing |
| `BALANCED` | Claude Sonnet | Design, implementation, code review |
| `DEEP` | Claude Opus | Complex architecture, security, or debugging |

## Agent Routing

| Agent | Stage | Profile |
|---|---|---|
| BA | Requirements | `CHEAP` |
| Architect | Design | `BALANCED` |
| Architect | Planning | `CHEAP` |
| Developer | Implementation | `BALANCED` |
| Tester | Planning / Verify | `CHEAP` |
| Reviewer | Code Review | `BALANCED` |

## Actual Model Selection

Custom agents specify the actual Copilot model in their frontmatter.

Current mapping:

- `CHEAP` → Claude Haiku
- `BALANCED` → Claude Sonnet
- `DEEP` → Claude Opus

The profile names are policy labels. The `model` field in each `.agent.md` file controls the actual Copilot model.

## Escalation

`DEEP` is reserved for cases that require substantially deeper reasoning.

Use it for:

- Complex architecture conflicts.
- Significant security vulnerabilities.
- Difficult cross-layer correctness issues.
- Repeated implementation failures.
- High-impact design decisions.
- Difficult debugging that cannot be resolved reliably with Sonnet.

Do not use Opus for routine work.

When deeper reasoning is required, explicitly request or initiate a model escalation. Do not assume that mentioning `DEEP` automatically changes the active Copilot model.

## Token Efficiency

- Use the lowest-cost model capable of completing the current stage.
- Keep context limited to the current SDLC stage.
- Read approved artifacts before unrelated repository files.
- Avoid repository-wide exploration unless necessary.
- Do not repeat information already available in repository artifacts.
- Keep outputs concise.
- Do not escalate solely because a task is inconvenient.

## Human Gate

No AI model can perform the Human Gate.

AI may recommend:

- `APPROVE`
- `REVISE`
- `REJECT`

Only a human can make the final decision and set:

`ACCEPTED`