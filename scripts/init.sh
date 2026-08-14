#!/usr/bin/env bash
set -euo pipefail

# One-shot setup for the workshop harness.
# Backend runs in Docker (php -S on :8080); frontend assets build on the host.

cd "$(dirname "$0")/.."

step() { printf '\n==> %s\n' "$1"; }
fail() { printf 'ERROR: %s\n' "$1" >&2; exit 1; }

step "Checking prerequisites"

command -v docker >/dev/null 2>&1 || fail "docker is not installed — see https://docs.docker.com/get-docker/"
docker info >/dev/null 2>&1 || fail "docker is installed but the daemon isn't running — start Docker Desktop and retry."
docker compose version >/dev/null 2>&1 || fail "'docker compose' (v2) is not available — update Docker Desktop or install the compose plugin."
echo "docker: $(docker --version)"
echo "compose: $(docker compose version --short)"

# Node/npm run on the host, not in the container.
command -v node >/dev/null 2>&1 || fail "node is not installed — needed to build Tailwind/Alpine assets on the host."
command -v npm >/dev/null 2>&1 || fail "npm is not installed."
echo "node: $(node -v)"

step "Preparing .env"

if [ -f .env ]; then
  echo ".env already exists — leaving it untouched."
else
  [ -f .env.example ] || fail ".env.example is missing, cannot create .env."
  cp .env.example .env
  echo "Created .env from .env.example — fill in the OAUTH_* values before testing login."
fi

step "Building and starting the app container"

docker compose build
docker compose up -d

step "Installing PHP dependencies"

if [ -f composer.json ]; then
  docker compose exec -T app composer install
else
  echo "No composer.json yet — skipping 'composer install' (the mob scaffolds it during the workshop)."
fi

step "Applying the SQLite schema"

docker compose exec -T app php scripts/migrate.php

step "Building frontend assets (on host)"

if [ -f package.json ]; then
  npm install
  if npm run 2>/dev/null | grep -qE '^\s+build'; then
    npm run build
  else
    echo "No 'build' script in package.json — skipping 'npm run build'."
  fi
else
  echo "No package.json yet — skipping 'npm install' (the mob scaffolds it during the workshop)."
fi

printf '\n=====================================\n'
printf '  Ready: http://localhost:8080\n'
printf '=====================================\n'
printf '\nLogs:  docker compose logs -f app\nStop:  docker compose down\n'
