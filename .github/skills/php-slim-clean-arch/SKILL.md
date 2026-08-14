---
name: php-slim-clean-arch
description: Slim 4 + PHP 8.4 Clean Architecture conventions for this project's backend
---

# PHP Slim Clean Architecture

**Trigger:** any change under `src/` or `public/index.php`.

## Layers (dependency direction: outer → inner only)

```
Presentation → Application → Domain
Infrastructure → Domain (implements Domain interfaces)
```

- **Domain** (`src/Domain/`) — entities, value objects, domain services, repository *interfaces*. Zero framework/library imports. No Slim, no SQLite classes here.
- **Application** (`src/Application/`) — use cases (one class per use case, single `execute()` method) and DTOs. Orchestrates Domain objects; depends on Domain interfaces, never on Infrastructure classes directly.
- **Infrastructure** (`src/Infrastructure/`) — implements Domain repository interfaces (e.g. `SQLiteLinkRepository implements LinkRepositoryInterface`), OAuth2 provider wiring, DB connection.
- **Presentation** (`src/Presentation/`) — Slim route handlers/controllers and middleware. Controllers call one Application use case, map the result to an HTTP response. No business logic in controllers.

## Dependency injection

- Use **PHP-DI** (`php-di/php-di`) as the Slim container. Bind interfaces to implementations in a single `src/Infrastructure/container.php`, injected via constructor — no service locators, no `new` for anything with a Domain interface.

## Naming

- Interfaces: `<Noun>RepositoryInterface`. Implementations: `<Storage><Noun>Repository` (e.g. `SQLiteLinkRepository`).
- Use cases: `<Verb><Noun>UseCase` (e.g. `CreateShortLinkUseCase`), one public `execute(DTO): DTO` method.
- Namespace root: `App\` mapped via PSR-4 to `src/`, sub-namespaces mirror the folder layers (`App\Domain\Entities`, `App\Application\UseCases`, ...).

## PHP 8.4 style

- Use constructor property promotion for DTOs/entities.
- Use `readonly` for immutable value objects; asymmetric visibility (`public private(set)`) only where an entity genuinely needs public reads + internal-only writes.
- Strict types: `declare(strict_types=1);` at the top of every file.

## What to avoid

- Don't put SQL or `PDO`/SQLite calls anywhere outside `src/Infrastructure/Persistence/`.
- Don't let a controller call a repository directly — always go through a use case.
- Don't add a 5th layer or sub-split these four without discussing with the mob first.
