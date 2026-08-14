-- Initial SQLite schema for the URL shortener MVP.
-- Mirrors the planned Domain entities: User, ShortLink.
-- Safe to re-run: every statement is IF NOT EXISTS.

PRAGMA foreign_keys = ON;

-- Domain\Entities\User — identity comes from the OAuth2 provider, never a local password.
CREATE TABLE IF NOT EXISTS users (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    provider          TEXT    NOT NULL,
    provider_user_id  TEXT    NOT NULL,
    email             TEXT    NOT NULL,
    name              TEXT,
    created_at        TEXT    NOT NULL DEFAULT (datetime('now')),
    UNIQUE (provider, provider_user_id)
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);

-- Domain\Entities\ShortLink — short_code is what the redirect route resolves on.
CREATE TABLE IF NOT EXISTS short_links (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL,
    short_code  TEXT    NOT NULL UNIQUE,
    long_url    TEXT    NOT NULL,
    created_at  TEXT    NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_short_links_user_id ON short_links (user_id);
