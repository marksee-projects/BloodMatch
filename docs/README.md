# Documentation

Start with the [repository overview](../README.md) or [local setup guide](getting-started.md).

## Product and implementation

| Reference | Purpose |
| --- | --- |
| [Current feature review](features/BLOODMATCH_CURRENT_REQUIREMENTS_STATUS.md) | Feature scope, approved changes, verification limits, and remaining gaps |
| [Project context](project-context.md) | Requirements and ratified amendments; newer amendments supersede conflicting historical sections |
| [Requirements baseline](requirements.md) | Original system requirements |
| [Traceability](traceability.md) | Historical requirements-to-implementation mapping |

## Technical references

| Reference | Purpose |
| --- | --- |
| [API reference](api.md) | Endpoint documentation; check current routes when working on an endpoint |
| [Application ERD](erd_application.md) | Application database model |
| [Application data dictionary](data_dictionary_application.md) | Application tables and fields |
| [Earlier ERD](erd.md) | Earlier schema reference |
| [Use-case diagram](use-case-diagram.md) | System actors and interactions |
| [Migration notes](../database/migrations/README.md) | Migration history and guarded rollout requirements |
| [Reference seeds](../database/seeds/README.md) | Reference-data loading conventions |

## Development and operations

- [Getting started](getting-started.md): environment, startup, and test selection.
- [Contributing](../CONTRIBUTING.md): change scope and pull-request expectations.
- [Local worker setup](LOCAL_WORKER_SETUP.md): per-machine automation and email processing.
- [Document key setup](DOCUMENT_KEY_SETUP_HANDOFF.md): protected document storage prerequisites.

## Reading historical records

Checkpoint, handoff, research, and `test-log-*` files preserve decisions and evidence from specific development stages. Their passing counts, role models, schema state, and deployment details may have been superseded. Read the date, scope, and verification limits before using one as an operational guide. Neither this index nor the README establishes that a deployed environment has applied a migration or enabled a worker.
