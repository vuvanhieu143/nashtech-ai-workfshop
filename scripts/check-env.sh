#!/usr/bin/env bash
set -euo pipefail

echo "Checking environment..."

command -v php >/dev/null 2>&1 && php -v | head -n1 || echo "MISSING: php"
command -v composer >/dev/null 2>&1 && composer --version || echo "MISSING: composer"
command -v node >/dev/null 2>&1 && node -v || echo "MISSING: node"
command -v git >/dev/null 2>&1 && git --version || echo "MISSING: git"

echo "Done."
