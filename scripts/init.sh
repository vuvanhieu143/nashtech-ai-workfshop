#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

step() {
    printf '\n==> %s\n' "$1"
}

fail() {
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

step "Checking prerequisites"

./scripts/check-env.sh

step "Preparing .env"

if [ -f .env ]; then
    echo ".env already exists — leaving it untouched."
else
    [ -f .env.example ] || fail ".env.example is missing."

    cp .env.example .env

    echo "Created .env from .env.example."
    echo "Configure OAuth2 values before testing login."
fi

step "Building application image"

docker compose build

step "Installing PHP dependencies"

if [ -f composer.lock ]; then
    docker compose run --rm --no-deps app \
        composer install \
        --prefer-dist \
        --no-interaction
else
    echo "composer.lock not found — skipping Composer install."
    echo "Run composer update/install when PHP dependencies are introduced."
fi

if [ -f package-lock.json ]; then
    step "Installing frontend dependencies"

    npm ci
else
    echo "package-lock.json not found — skipping npm ci."
    echo "Run npm install when frontend dependencies are introduced."
fi

if [ -f package.json ] && [ -f package-lock.json ]; then
    step "Installing Playwright browsers"

    npx playwright install
fi

if [ -f resources/css/app.css ] && [ -f resources/js/app.js ]; then
    step "Building frontend assets"

    npm run build
else
    echo "Frontend entry points not found — skipping frontend build."
fi

step "Starting application"

docker compose up -d

step "Applying database schema"

docker compose exec -T app \
    php scripts/migrate.php

step "Waiting for application"

if command -v curl >/dev/null 2>&1; then
    for attempt in {1..20}; do
        if curl --fail --silent http://localhost:8080/ >/dev/null; then
            break
        fi

        if [ "$attempt" -eq 20 ]; then
            fail "Application did not become ready at http://localhost:8080"
        fi

        sleep 1
    done
else
    echo "curl is not installed; skipping HTTP readiness check."
fi

printf '\n'
printf '%s\n' '====================================='
printf '%s\n' '  Setup complete'
printf '%s\n' '  http://localhost:8080'
printf '%s\n' '====================================='
printf '\n'

printf '%s\n' 'Useful commands:'
printf '%s\n' '  Logs:    docker compose logs -f app'
printf '%s\n' '  Stop:    docker compose down'
printf '%s\n' '  PHP:     docker compose exec app composer <command>'
printf '%s\n' '  Tests:   docker compose exec app composer test'
printf '%s\n' '  E2E:     npm run test:e2e'
printf '\n'