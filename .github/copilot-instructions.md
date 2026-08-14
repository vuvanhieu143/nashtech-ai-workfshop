# Copilot Instructions

## Project
URL shortener. PHP 8.4 (Slim framework) backend, OAuth2 auth, SQLite storage, Tailwind + Alpine.js frontend.

---

## 1. SDLC Pipeline & Stage Routing

| SDLC Stage | Persona Agent | Inputs (Reads From) | Outputs (Writes To) | Template Required |
| :--- | :--- | :--- | :--- | :--- |
| **Stage 1: Requirements** | `agents/ba.agent.md` | `docs/product-brief.md` | `docs/requirements/US-XX.md` | `docs/templates/REQUIREMENTS.md` |
| **Stage 2: Design** | `agents/developer.agent.md` | `docs/requirements/US-XX.md`<br>`docs/symbol-map.md` | `docs/design/US-XX.md` | `docs/templates/DESIGN.md` |
| **Stage 3: Planning** | `agents/tester.agent.md` | `docs/requirements/US-XX.md`<br>`docs/design/US-XX.md` | `docs/planning/US-XX.md` | `docs/templates/PLANNING.md` |
| **Stage 4: Implementation** | `agents/developer.agent.md`<br>`agents/reviewer.agent.md` | `docs/planning/US-XX.md`<br>`docs/CODING_STANDARDS.md` | `src/`, `tests/`, `public/` | Checklist in `PLANNING.md` |

---

## 2. Stage Quality Gates & State Machine Policy

1. **Sequential Execution:** Features MUST progress strictly through `Stage 1 ➔ Stage 2 ➔ Stage 3 ➔ Stage 4`. Direct implementation without prior stage artifacts is strictly prohibited.
2. **Quality Gate Rule ($\ge 80/100$):**
   - An artifact must be evaluated against its stage criteria and receive a score of **$\ge 80/100$** in `docs/stage-scores.md` to pass the gate.
   - If a stage scores **$< 80/100$**, the agent must revise the artifact before advancing.
3. **State Machine Updates:** Upon passing a stage gate, the agent must update the status in `docs/progress.md`.

---

## 3. How to Switch Persona & Token Context System

Persona files are plain Markdown to maintain tool independence. When moving to a new SDLC stage:

1. **Start a new chat session** to prevent persona framing leakage.
2. Reference the role file first: `#file:agents/<role>.agent.md`.
3. Provide scoped context pointers ONLY for the target stage:

```text
# Requirements Stage Example:
#file:agents/ba.agent.md #file:docs/product-brief.md #file:docs/templates/REQUIREMENTS.md
Draft requirements for US-01 following the template.

# Technical Design Stage Example:
#file:agents/developer.agent.md #file:docs/requirements/US-01.md #file:docs/templates/DESIGN.md
Draft technical design for US-01 following the template.
```

---

## 4. Context Pointer System (Token Guardrails)

Do **NOT** index or read the entire repository. Read ONLY the explicit stage inputs:
* **Stage 1:** Read `docs/product-brief.md` & `docs/templates/REQUIREMENTS.md`. Write to `docs/requirements/`.
* **Stage 2:** Read `docs/requirements/US-XX.md`, `docs/symbol-map.md`, & `docs/templates/DESIGN.md`. Write to `docs/design/`.
* **Stage 3:** Read `docs/requirements/US-XX.md`, `docs/design/US-XX.md`, & `docs/templates/PLANNING.md`. Write to `docs/planning/`.
* **Stage 4:** Read `docs/planning/US-XX.md`. Check off items `[x]` as code/tests are completed.

---

## 5. Skills Reference

| Skill File | Context Trigger |
| :--- | :--- |
| `.github/skills/php-slim-clean-arch/SKILL.md` | Any change under `src/`, `public/index.php`, or PHP interfaces |
| `.github/skills/js-alpine-reactive/SKILL.md` | Any change under `resources/js/` or inline `x-data` |
| `.github/skills/html-tailwind-ui/SKILL.md` | Any change under `public/views/` or `resources/css/` |
| `.github/skills/playwright-accessible-e2e/SKILL.md` | Any change under `tests/`|

---

## 6. General Rules

- **Zero Invisible Knowledge:** Every decision, schema change, and requirement must be saved in markdown artifacts (`docs/`), never left exclusively in chat history.
- **Strict Compliance:** Adhere to `docs/CODING_STANDARDS.md` for all code and tests.
- **Micro-Commits:** Keep diffs minimal and focused; commit immediately after completing every checked task in `PLANNING.md`.