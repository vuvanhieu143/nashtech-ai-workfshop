FROM php:8.4-cli

# pdo_sqlite/sqlite3 are bundled with the official image; only composer + its
# runtime deps (git, unzip) are missing from php:8.4-cli.
RUN apt-get update \
    && apt-get install -y --no-install-recommends git unzip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
