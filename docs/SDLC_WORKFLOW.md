# SDLC Workflow

## 1. Purpose

This project uses a gated, artifact-driven SDLC with a bounded Ralph loop.

**Requirements → Design → Planning → Implementation → Verify → Review → Human Gate → Done**

Stages are sequential. Ralph may repeat Implementation and Verify, but it may not bypass an approval gate or change approved scope without returning to the affected stage.

## 2. Stage Map

| Stage | Persona | Inputs | Output | Gate |
|---|---|---|---|---|
| 1 Requirements | `agents/ba.agent.md` | Product brief + template | `docs/requirements/US-XX.vN.md` | BA + Human |
| 2 Design | `agents/architect.agent.md` | Approved requirements + symbol map + template | `docs/design/US-XX.vN.md` | Architect + Human |
| 3 Planning | `agents/architect.agent.md` + tester perspective | Approved requirements + design + template | `docs/planning/US-XX.vN.md` | Architect + Human |
| 4 Implementation | `agents/developer.agent.md` | Approved planning + coding standards | Source + tests | Automated verification |
| 5 Verify | `agents/tester.agent.md` | Implementation + approved artifacts | Test/verification evidence | Tester |
| 6 Review | `agents/reviewer.agent.md` | Implementation + approved artifacts + verification evidence | Review findings | Reviewer |
| 7 Human Gate | Human | Approved artifacts + verification + review evidence | Approve / Revise / Reject / Re-scope | Human |

Detailed implementation rules:

- `docs/CODING_STANDARDS.md`
- `.github/skills/*/SKILL.md`
- `agents/*.agent.md`

## 3. Artifact and Version Rules

- Every artifact starts at `v1`.
- Never overwrite or delete a previous version.
- Revisions create `v2`, `v3`, etc.
- Every artifact contains Revision History and status.
- Record gate/audit results in `docs/stage-scores.md`.
- Score >= 80/100 is `APPROVED`; otherwise `REJECTED` with blocking feedback.
- Update `docs/progress.md` only with the latest approved state.
- An upstream change invalidates affected downstream artifacts; re-audit before implementation continues.

## 4. Stage Protocol

For every stage:

1. **Orient** — identify the story, current approved artifact, scope, and relevant files.
2. **Produce** — create or revise only the stage artifact.
3. **Audit** — apply the persona checklist and record the score/findings.
4. **Human gate** — a human explicitly approves before entering the next gated stage.
5. **Record** — update progress and artifact status.

Agents must stop at a human gate.

Do not infer approval from:

- a score >= 80;
- passing tests;
- a successful build;
- a previous conversation;
- another agent's recommendation.

Human approval is an explicit decision.

## 5. Ralph Loop

Ralph is the bounded feedback loop used after Planning has been approved.

```text
IMPLEMENT
    |
    v
VERIFY
(tests / lint / build / security)
    |
    v
PASS?
  /   \
NO     YES
|       |
v       v
ANALYSE REVIEW
FAILURE   |
|         v
v       PASS?
FIX     /   \
MINIMUM NO   YES
|       |     |
+-------+     v
            HUMAN GATE
```

### Ralph rules

- Work on **one approved planning task at a time**.
- Do not implement functionality outside the approved planning scope.
- Each iteration must produce new evidence:
  - a test result;
  - a verification result;
  - a review finding;
  - or a concrete code change.
- Fix the smallest root cause.
- Do not perform unrelated refactoring.
- Re-run the failed verification after every fix.
- Re-run relevant regression tests.
- Do not weaken or remove tests to make the loop pass.
- Do not remove acceptance criteria.
- Do not bypass security checks.
- Do not mark a task complete to escape the loop.
- Default maximum: **5 iterations per planning task**.

### Ralph termination

The loop must stop when:

1. Verification passes and review finds no blocking issues.
2. The maximum iteration count is reached.
3. The loop is no longer making meaningful progress.
4. An upstream requirement or design problem is discovered.
5. A security or scope concern requires human intervention.

When the loop stops because of 2–5, the agent must request human direction.

## 6. Human-in-the-Loop

Human approval is required at these points:

1. Requirements → Design.
2. Design → Planning.
3. Planning → Implementation.
4. Ralph loop → Feature completion.
5. Final PR → Merge.

The human may choose:

| Decision | Action |
|---|---|
| **Approve** | Continue to the next stage |
| **Revise** | Return to the current stage with explicit feedback |
| **Reject** | Stop the work and record the reason |
| **Re-scope** | Update the upstream artifact and re-run affected stages |

Chat is not the source of truth.

Human decisions must be recorded in the appropriate repository artifact.

## 7. Failure Routing

| Finding | Return to |
|---|---|
| Requirement ambiguity | Requirements |
| Changed acceptance criteria | Requirements |
| Architecture conflict | Design |
| Data model/API change | Design |
| Missing implementation task | Planning |
| Incorrect task decomposition | Planning |
| Code defect within approved scope | Ralph loop |
| Test failure caused by code | Ralph loop |
| Test/environment infrastructure failure | Verify |
| Review finding caused by code | Ralph loop |
| Security concern | Human Gate |
| Scope expansion | Human Gate |
| Ralph loop exhausted | Human Gate |

## 8. Context Guardrails

Agents must not scan the entire repository unnecessarily.

Read only:

1. Current approved stage artifacts.
2. Relevant upstream artifacts.
3. Relevant source files.
4. Relevant tests.
5. Applicable skills.
6. Relevant agent/persona instructions.

Prefer the latest approved artifact.

Do not use chat history as the authoritative source for project decisions.

## 9. Definition of Done

A story is complete only when:

- Requirements are approved.
- Design is approved.
- Planning is approved.
- All planned tasks are implemented.
- Tests pass.
- Verification passes.
- Ralph loop exits successfully.
- Reviewer has no blocking findings.
- Acceptance criteria are demonstrated.
- `docs/progress.md` is updated.
- Human explicitly approves completion.
- Final PR/merge is approved by a human.

## 10. Non-Negotiable Rules

Agents MUST NOT:

- bypass an SDLC gate;
- implement unapproved scope;
- silently change requirements;
- silently change architecture;
- weaken tests;
- delete failing tests;
- ignore reviewer findings;
- continue an exhausted Ralph loop indefinitely;
- treat automated approval as human approval;
- declare completion without the final human gate.

The goal of Ralph is **fast feedback and controlled iteration**, not autonomous decision-making.