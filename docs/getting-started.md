# Getting started

This guide covers Windows development with PowerShell and XAMPP. Run commands from the repository root unless stated otherwise.

## Prerequisites

- Node.js with npm, compatible with the frontend's Vite 5 dependency.
- PHP 8 with PDO MySQL; OpenSSL is needed for SMTP TLS.
- MySQL or MariaDB, with a dedicated local database.
- PowerShell and Git.

Photo processing additionally requires PHP GD. Encrypted document storage needs an external key directory; see [document key setup](DOCUMENT_KEY_SETUP_HANDOFF.md). The backend uses its checked-in autoloader and libraries; there is no Composer installation step.

## 1. Configure the environment

Create your local configuration once:

```powershell
Copy-Item .env.example .env
```

If `.env` already exists, edit it instead of overwriting it. Set `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, and `DB_PASS` for your local database.

The example defaults to port **3307**. Some operational helpers and later checkpoint documents target **3306** explicitly, so verify the port and database used by each tool. For the default frontend, keep `APP_CORS_ORIGINS=http://localhost:5173`.

Keep `.env`, SMTP credentials, uploaded documents, and encryption keys out of Git. Leave `MAIL_HOST` empty if you do not want local email delivery. Exercising registration OTP delivery requires working SMTP. Worker flags in the example are disabled by default; starting the web servers does not install scheduled workers.

## 2. Prepare the database

Create the empty local database named in `DB_NAME`. Read the [migration notes](../database/migrations/README.md) and [seed notes](../database/seeds/README.md) before applying SQL.

The migration runner tracks applied files in `schema_migrations`, but **it is not a complete unattended bootstrap**. It deliberately stops at protected migrations, including staff-role consolidation (024), donation-storage consolidation (032/033), and donation-source retirement (035). Follow their dedicated review/preflight processes:

- [Staff-role consolidation](STAFF_ROLE_CONSOLIDATION_CHECKPOINT.md).
- [Donation-storage consolidation](DONATION_CONSOLIDATION_032.md).
- [Donation-source retirement](DONATION_SOURCE_RETIREMENT_035.md).

The generic commands below apply ordinary migrations and reference seeds as part of that reviewed sequence. If the migration command stops, follow the named handoff before continuing to seeds or application startup.

```powershell
$php = 'C:\xampp\php\php.exe' # adjust to your installation
& $php database/run_migrations.php
if ($LASTEXITCODE -ne 0) { throw 'Migration stopped; review its output before continuing.' }
& $php database/run_seeds.php
```

Use a separate local/test database for development and fixtures. Existing installations need a backup and target review before schema changes.

## 3. Install frontend dependencies

```powershell
cd frontend
npm.cmd ci
cd ..
```

`npm ci` installs the versions recorded in `frontend/package-lock.json`.

## 4. Start the application

```powershell
powershell -ExecutionPolicy Bypass -File .\start-dev.ps1
```

The launcher tries `D:\xampp\php\php.exe`, with `C:\xampp\php\php.exe` as a fallback. Supply another location if needed:

```powershell
.\start-dev.ps1 -PhpPath 'E:\xampp\php\php.exe'
```

| Service | Default address |
| --- | --- |
| React frontend | http://localhost:5173 |
| PHP backend | http://127.0.0.1:8000 |
| Backend health | http://127.0.0.1:8000/api/health |

The launcher checks `/api/csrf` before starting Vite. That readiness check does not prove database connectivity; inspect the health response's database fields separately.

Running only `npm run dev` leaves the API unavailable unless a backend is already running. A failed CSRF-token request during login often means the backend is missing. The Vite proxy targets port 8000; if you change the backend port, update the proxy in `frontend/vite.config.js` too.

## Testing

For a frontend production build:

```powershell
cd frontend
npm.cmd run build
cd ..
```

The frontend `npm test` command is currently a placeholder, not a test suite.

The old `tests/run_all.ps1` runner intentionally throws because its chapter-scoped officer assumptions are retired. For the current staff-role API regression, prepare the current schema in `bloodmatch_test`, then use:

```powershell
powershell -ExecutionPolicy Bypass -File tests/run_isolated.ps1 -Suite staff_role_api.ps1
```

The runner defaults to MySQL port **3306**, PHP at `C:\xampp\php\php.exe`, and a separate API server on port **8001**. Pass `-DbPort`, `-PhpPath`, and `-MysqlPath` if needed. It uses local root database access, forces SMTP to a closed local port, and restores its environment afterward. Review the selected suite's fixture writes before running it.

Focused PHP and Node offline checks also live in `tests/`. Select checks that cover your change and read their prerequisites. Do not assume every historical test works with the current schema or run database suites against the application database.

## Background processing

Expiry, non-response handling, and queued email use separate worker configuration and schedules. Follow [local worker setup](LOCAL_WORKER_SETUP.md) after reviewing schema readiness and the relevant feature's activation instructions.
