#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail() {
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

check_command() {
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        fail "$command_name is required but was not found."
    fi
}

printf '\nEnvironment check\n'
printf '%s\n\n' '================'

check_command docker
check_command node
check_command npm

docker info >/dev/null 2>&1 || \
    fail "Docker is installed but the Docker daemon is not running."

docker compose version >/dev/null 2>&1 || \
    fail "Docker Compose v2 is required."

[ -f composer.json ] || \
    fail "composer.json is missing."

[ -f package.json ] || \
    fail "package.json is missing."

[ -f package-lock.json ] || \
    fail "package-lock.json is missing. Run npm install and commit the lock file."

[ -f .env.example ] || \
    fail ".env.example is missing."

printf 'Docker:  %s\n' "$(docker --version)"
printf 'Compose: %s\n' "$(docker compose version --short)"
printf 'Node:    %s\n' "$(node --version)"
printf 'npm:     %s\n' "$(npm --version)"

printf '\nAll prerequisites are available.\n'