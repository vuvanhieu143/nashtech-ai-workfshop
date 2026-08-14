# SDLC Workflow

## 1. Purpose

This project uses a gated, artifact-driven SDLC:

**Requirements → Design → Planning → Implementation → Review**

A stage cannot start until the previous stage has an approved artifact.

---

## 2. Stage Map

| Stage | Persona | Inputs | Output | Gate |
|---|---|---|---|---|
| Requirements | `agents/ba.agent.md` | Product brief + requirements template | `docs/requirements/US-XX.vN.md` | BA |
| Design | `agents/developer.agent.md` | Approved requirements + symbol map + design template | `docs/design/US-XX.vN.md` | Architect |
| Planning | `agents/tester.agent.md` | Approved requirements + design + planning template | `docs/planning/US-XX.vN.md` | Architect |
| Implementation | `agents/developer.agent.md` | Approved planning | Source + tests | Reviewer |

Detailed implementation rules are defined elsewhere:

- `docs/CODING_STANDARDS.md`
- `.github/skills/*/SKILL.md`
- `agents/*.agent.md`

---

## 3. Stage 1 — Requirements

### Read

```text
agents/ba.agent.md
docs/product-brief.md
docs/templates/REQUIREMENTS.md