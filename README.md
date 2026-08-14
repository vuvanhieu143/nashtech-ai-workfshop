# NashTech AI-Native Workshop — URL Shortener

Team project for the AI-Native Workshop. Built end-to-end with GitHub Copilot Agent mode using a staged SDLC workflow.

## Tech Stack

- Backend: PHP 8.4
- Framework: Slim
- Authentication: OAuth2
- Storage: SQLite
- Frontend: Tailwind CSS + Alpine.js
- E2E testing: Playwright
- Containerization: Docker + Docker Compose
- Dependency management: Composer + npm

All application dependencies are installed locally. The application does **not** depend on CDN-hosted runtime libraries.

## Project Structure

    .
    ├── .github/
    │   ├── agents/                 # SDLC agents
    │   ├── skills/                 # Focused technical skills
    │   ├── AI_MODELS.md            # Model selection policy
    │   └── copilot-instructions.md # Global Copilot instructions
    │
    ├── docs/
    │   ├── requirements/           # Approved requirements
    │   ├── design/                 # Approved designs
    │   ├── planning/               # Implementation plans
    │   ├── CODING_STANDARDS.md     # Coding and dependency rules
    │   ├── SDLC_WORKFLOW.md        # SDLC stages and gates
    │   └── ...
    │
    ├── scripts/
    │   ├── init.sh                 # One-command environment setup
    │   ├── check-env.sh            # Environment prerequisite check
    │   ├── migrate.php             # SQLite migration
    │   └── schema.sql              # SQLite schema
    │
    ├── src/                        # Application source
    ├── tests/                      # Unit/integration tests
    ├── public/                     # Web entry point and built assets
    ├── composer.json               # PHP dependencies
    ├── composer.lock               # Locked PHP dependencies
    ├── package.json                # Node/frontend dependencies
    ├── package-lock.json           # Locked Node dependencies
    ├── Dockerfile
    └── docker-compose.yml

## Getting Started

### Prerequisites

Install:

- Docker
- Docker Compose v2
- Node.js 20+
- npm

Docker must be running before setup.

Check the environment:

    ./scripts/check-env.sh

### One-Command Setup

From the repository root:

    ./scripts/init.sh

The setup script:

1. Checks Docker and Node.js prerequisites.
2. Creates `.env` from `.env.example` if it does not exist.
3. Builds the PHP 8.4 Docker image.
4. Installs PHP dependencies with Composer.
5. Installs frontend dependencies with `npm ci`.
6. Installs Playwright browsers.
7. Builds frontend assets locally.
8. Starts the application container.
9. Applies the SQLite schema.
10. Verifies that the application is reachable.

When setup finishes, open:

    http://localhost:8080

## Environment Configuration

The setup script creates `.env` from:

    .env.example

OAuth2 credentials must be configured before testing the OAuth2 login flow.

Never commit real credentials or secrets.

## Frontend Dependencies

Frontend dependencies are managed with npm.

Install dependencies:

    npm ci

Build frontend assets:

    npm run build

The application must not load runtime dependencies from third-party CDNs.

For example, do not use:

    <script src="https://cdn.example.com/library.js"></script>

or:

    <link rel="stylesheet" href="https://cdn.example.com/library.css">

Use npm-managed local dependencies instead.

The committed `package-lock.json` provides reproducible frontend dependency versions.

## PHP Dependencies

PHP dependencies are managed with Composer.

Install dependencies:

    docker compose run --rm --no-deps app composer install

The committed `composer.lock` provides reproducible PHP dependency versions.

## Running the Application

Start the application:

    docker compose up -d

Open:

    http://localhost:8080

View application logs:

    docker compose logs -f app

Stop the application:

    docker compose down

Restart the application:

    docker compose restart

## Database

The application uses SQLite.

Apply the schema:

    docker compose exec -T app php scripts/migrate.php

The SQLite database is stored in the project directory so it persists across container restarts.

Do not commit local development database files unless explicitly required.

## Testing

### PHP Tests

Run the PHP test suite inside the application container:

    docker compose exec app vendor/bin/phpunit

### Frontend Tests

Run the configured frontend test suite:

    npm test

### Playwright E2E Tests

Run Playwright:

    npm run test:e2e

If Playwright browsers have not been installed:

    npx playwright install

E2E tests should validate the affected user flow against the running application.

## Useful Commands

| Command | Purpose |
|---|---|
| `./scripts/check-env.sh` | Check local prerequisites |
| `./scripts/init.sh` | Complete environment setup |
| `docker compose up -d` | Start application |
| `docker compose down` | Stop application |
| `docker compose logs -f app` | Follow application logs |
| `docker compose exec app composer install` | Install PHP dependencies |
| `docker compose exec app vendor/bin/phpunit` | Run PHP tests |
| `npm ci` | Install frontend dependencies |
| `npm run build` | Build frontend assets |
| `npm test` | Run frontend tests |
| `npm run test:e2e` | Run Playwright E2E tests |
| `docker compose exec -T app php scripts/migrate.php` | Apply SQLite schema |

## AI-Native SDLC

This project uses a staged AI-assisted SDLC.

    Requirements
         ↓
    Human Gate
         ↓
    Design
         ↓
    Human Gate
         ↓
    Planning
         ↓
    Human Gate
         ↓
    Implementation
         ↓
    Verify
         ↓
    Review
         ↓
    Human Gate
         ↓
    Accepted

### Agents

| Stage | Agent | Model |
|---|---|---|
| Requirements | BA | Claude Haiku |
| Design | Architect | Claude Sonnet |
| Planning | Architect | Claude Sonnet |
| Implementation | Developer | Claude Sonnet |
| Planning perspective / Verify | Tester | Claude Haiku |
| Code Review | Reviewer | Claude Sonnet |

Model policy is defined in:

    .github/AI_MODELS.md

The actual model used by each Copilot custom agent is configured in its agent definition.

### Ralph Loop

Ralph is an orchestration loop, not an additional development persona.

    Implementation
          ↓
       Verify
          ↓
       Failure?
        ↙    ↘
      Yes     No
       ↓       ↓
    Developer Review
       ↓       ↓
     Verify  Human Gate

Responsibilities remain with the existing agents:

- Developer owns implementation fixes.
- Tester owns verification.
- Reviewer owns code-review findings.
- Architect owns design and planning.
- BA owns requirements.
- Ralph coordinates the retry loop.

Ralph must not independently change requirements, architecture, or acceptance decisions.

## MVP Scope

The MVP is intentionally limited to four features:

1. Shorten URL
2. Redirect short URL
3. OAuth2 login/session
4. Link management

Anything outside these features requires explicit scope approval.

## Development Rules

Before implementing a feature:

1. Requirements must be approved.
2. Design must be approved.
3. Planning must be approved.
4. The implementation must follow the approved plan.
5. Tests must cover the acceptance criteria.
6. Verification must pass.
7. Code review must pass.
8. A human must approve the final result.

See:

    docs/SDLC_WORKFLOW.md

for the complete workflow.

## Dependency and Security Rules

- Pin dependencies through lock files.
- Do not use CDN-hosted runtime dependencies.
- Do not commit secrets.
- Validate all external input.
- Validate redirect URLs.
- Protect authentication and authorization boundaries.
- Do not construct SQL queries from untrusted input.
- Keep dependencies limited to what the approved design requires.
- Do not introduce libraries solely for speculative future functionality.

## License

This project is created for the NashTech AI-Native Workshop.