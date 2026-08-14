# Symbol & Route Registry (Clean Architecture)

This file tracks the baseline and evolving file paths, interfaces, classes, and routes across `src/`, `public/`, and `tests/`.

## 1. Directory Blueprint (`src/`, `public/`, `tests/`)

```text
src/
├── Domain/                         # Enterprise core logic & contracts (No framework dependencies)
│   ├── Entity/                     # User, ShortLink entities
│   └── Repository/                 # Repository interfaces (e.g., LinkRepositoryInterface)
├── Application/                    # Use cases & business orchestrators
│   ├── UseCase/                    # ShortenUrl, RedirectUrl, ManageLinks use cases
│   └── DTO/                        # Input/Output Data Transfer Objects
├── Infrastructure/                 # External concerns (Database, OAuth, Persistence)
│   └── Persistence/                # SQLite repository implementations (PDO)
└── Presentation/                   # Slim framework controllers, middleware, and views
    ├── Controller/                 # API & Web controllers
    └── Middleware/                 # Auth & session middleware

public/
├── index.php                       # Slim application entry point & container config
├── views/                          # Tailwind + Alpine.js front-end views
└── assets/                         # Compiled CSS/JS assets

tests/
├── Unit/                           # Domain & Application layer unit tests (PHPUnit)
└── E2E/                            # End-to-end integration tests (Slim application tests)