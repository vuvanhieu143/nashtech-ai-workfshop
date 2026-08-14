<?php

declare(strict_types=1);

/**
 * Applies scripts/schema.sql to the SQLite database.
 *
 * Runs inside the app container (php -f scripts/migrate.php). Kept separate
 * from src/ on purpose: this is harness plumbing, not application code.
 *
 * PDO_SQLITE::exec() only runs the first statement of a multi-statement string,
 * so the file is split and executed statement by statement.
 */

$root = dirname(__DIR__);

/** Reads DB_PATH from the environment, falling back to .env, then the default. */
function resolveDbPath(string $root): string
{
    if ($fromEnv = getenv('DB_PATH')) {
        return $fromEnv;
    }

    $envFile = $root . '/.env';
    if (is_file($envFile)) {
        foreach (file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
            if (preg_match('/^\s*DB_PATH\s*=\s*(.*)$/', $line, $m)) {
                return trim($m[1], " \t\"'");
            }
        }
    }

    return './database.sqlite';
}

$dbPath = resolveDbPath($root);
if (!str_starts_with($dbPath, '/')) {
    $dbPath = $root . '/' . ltrim($dbPath, './');
}

$schemaPath = $root . '/scripts/schema.sql';
if (!is_file($schemaPath)) {
    fwrite(STDERR, "Schema not found: {$schemaPath}\n");
    exit(1);
}

$pdo = new PDO('sqlite:' . $dbPath, options: [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
]);

$sqlWithoutComments = preg_replace('/^\s*--.*$/m', '', (string) file_get_contents($schemaPath));

$statements = array_filter(
    array_map('trim', explode(';', (string) $sqlWithoutComments)),
    static fn (string $sql): bool => $sql !== '',
);

foreach ($statements as $sql) {
    $pdo->exec($sql);
}

$tables = $pdo->query(
    "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
)->fetchAll(PDO::FETCH_COLUMN);

printf("Schema applied to %s (tables: %s)\n", $dbPath, implode(', ', $tables));
