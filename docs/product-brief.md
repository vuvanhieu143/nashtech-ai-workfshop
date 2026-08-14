# Product Brief

## Overview

URL shortener — logged-in users shorten long URLs and share them; anyone visiting a short link is redirected to the original URL.

## Target users

## Core features (MVP — max 3)
1. Shorten URL — user submits a long URL and receives a short code
2. Redirect — visiting the short URL redirects to the original long URL
3. OAuth2 login — users authenticate before creating/managing their short links

## Out of scope (explicitly NOT building today)
- Click / basic stats tracking
- Custom alias for short links
- Link expiration date

## Tech stack (align with your harness)
- Frontend: Tailwind CSS + Alpine.js
- Backend: PHP 8.4 (Slim)
- Data/storage: SQLite
- Auth: OAuth2
- Infra: Docker
