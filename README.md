# BloodMatch

Peer-to-peer blood donor coordination for DeMolay members in Bataan, Philippines.

BloodMatch brings blood requests, potential donor matching, and donation coordination into one place. Members can organize requests and responses, while authorized staff can review membership and monitor activity.

**[Visit the website](https://blood-match-mu.vercel.app)** · **[Local setup](docs/getting-started.md)** · **[Documentation](docs/README.md)** · **[Contributing](CONTRIBUTING.md)**

## Project overview

The application brings together these workflows:

- Member registration, email verification, profiles, and membership review.
- Blood requests with urgency, facility information, and lifecycle tracking.
- Potential donor matching using blood-type compatibility, eligibility, and proximity.
- Donor offers, requester acceptance, and consent-based private chat.
- Donation reporting, acknowledgment, and staff review of exceptions.
- In-app notifications, configured email delivery, and chapter demand summaries.
- An Admin/Officer portal for member management, reports, and audit review.

These describe the application scope rather than a certification of the deployed website. See the [current feature review](docs/features/BLOODMATCH_CURRENT_REQUIREMENTS_STATUS.md) for verification limits and outstanding work.

BloodMatch supports coordination. Final donor eligibility and medical compatibility require assessment by qualified healthcare professionals.

## Technology

| Layer | Stack |
| --- | --- |
| Frontend | React 18, Vite, React Router, TanStack Query |
| Backend | PHP 8, session-based JSON API, PDO |
| Database | MySQL / MariaDB with versioned SQL migrations |
| Local development | XAMPP, Node.js, PowerShell |

## Run locally

Local development uses a React frontend and a separate PHP backend. You will need Node.js with npm, PHP 8, and a configured MySQL/MariaDB database.

1. Follow the [setup guide](docs/getting-started.md) to configure your local environment and database. Some migrations require dedicated review helpers.
2. Install frontend dependencies:

   ```powershell
   cd frontend
   npm.cmd ci
   cd ..
   ```

3. From the repository root, start both development servers:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\start-dev.ps1
   ```

Open **http://localhost:5173**. The frontend forwards `/api` requests to the PHP backend at `http://127.0.0.1:8000`.

## Repository structure

```text
backend/       PHP API, application services, and private runtime storage
database/      Schema migrations, reference seeds, and maintenance tools
frontend/      React application and public assets
docs/          Setup, architecture, feature reviews, and implementation records
scripts/       Development, demo, and operational helpers
tests/         Focused offline checks and isolated integration suites
start-dev.ps1  Local development launcher
```

## Development checks

Build the frontend from `frontend/`:

```powershell
npm.cmd run build
```

Database-backed tests need a separate test environment. The historical `tests/run_all.ps1` runner is retired; see [testing guidance](docs/getting-started.md#testing) before selecting a suite. Earlier passing test counts in implementation records are historical results.

## Documentation

- [Getting started](docs/getting-started.md): environment, startup, and testing.
- [Documentation index](docs/README.md): architecture, requirements, and operational references.
- [Contribution guide](CONTRIBUTING.md): proposing changes and submitting pull requests.

## Project origin

This repository continues development from [Ruahsen/BloodMatch](https://github.com/Ruahsen/BloodMatch). Git history retains the original contributions alongside subsequent work in this fork.
