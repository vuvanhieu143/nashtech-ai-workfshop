# Product Brief

## Overview

URL shortener — logged-in users shorten long URLs, manage their created link history, and share them; anyone visiting a short link is redirected to the original long URL.

## Target users
- Authenticated users who need to generate and manage short links.
- Public visitors who access shortened URLs.

## Core features (MVP)
1. **Shorten URL** — user submits a long URL and receives a short code.
2. **Redirect** — visiting the short URL redirects to the original long URL.
3. **OAuth2 login** — users authenticate before creating or managing their short links.
4. **Link Management** — logged-in users can view a list of their active short links and delete them.

## Out of scope (explicitly NOT building today)
- Click / basic stats tracking (beyond viewing the list of links)
- Custom alias for short links
- Link expiration date
- Link editing (updating target URL destinations)

## Tech stack (align with your harness)
- Frontend: Tailwind CSS + Alpine.js
- Backend: PHP 8.4 (Slim)
- Data/storage: SQLite
- Auth: OAuth2
- Infra: Docker