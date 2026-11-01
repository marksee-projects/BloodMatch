# Version 2 development environment

## Isolation from the capstone

This checkout uses ports 5180 and 8010, database name bloodmatch_v2, a separate session cookie, and a private session directory under backend/storage/sessions-v2. The development launcher refuses occupied ports rather than attaching to an unknown server. PDO blocks the old bloodmatch and bloodmatch_test database names and uses only the configured port.

The capstone remote is named capstone; its push URL is disabled. The new GitHub repository is the origin remote. Work on develop, then review changes before merging into main.

## Setup

1. Install Node.js (recommended release in .nvmrc) and PHP 8.2+ with PDO MySQL. Existing Node.js 24+ installations can run the project.
2. Run npm run setup. It copies .env.example only if .env does not exist, installs the frontend lockfile, and creates ignored runtime directories.
3. Review your new local .env. Database values are placeholders; no capstone credentials are copied. Adjust the MySQL port and local credentials if necessary.
4. Run npm run dev. Use http://localhost:5180; API requests are proxied to port 8010. Schema preparation is not required for the CSRF readiness check.

For a custom PHP location:

~~~powershell
.\start-dev.ps1 -PhpPath 'C:\xampp\php\php.exe'
~~~

The launcher forwards custom backend/frontend ports to Vite. If you change the frontend origin, update APP_CORS_ORIGINS too. Never place server secrets in a VITE_* variable.

## Database preparation is the next implementation step

Do not point this checkout at the capstone database or import its member records. The inherited migrations include chapter bindings, a designated-administrator policy, and guarded data-consolidation steps. The general-use v2 schema/bootstrap must be reviewed before applying them to a new database. An empty database alone is not enough to enable registration/login.

Legacy database utilities, task installers, and integration tests are retained as source references. Some open raw PDO connections or contain fixed capstone targets; they must be ported before use. The Database class guard protects the application connection, not every historical standalone script. Use only the documented root commands at this stage. The old isolated integration runner is disabled in v2 until its suites are ported.

Email and background worker flags start disabled. Registration OTP cannot complete without an explicitly configured mail transport. Private documents require new encryption keys and storage; old uploads/keys are not copied.

## Checks

npm run check parses application PHP and runs selected in-memory/offline policy tests, including the v2 database-target guard. npm run build builds React. The GitHub workflow performs these checks without database credentials or deployment secrets.

Historical passing counts and database-test runners are not v2 acceptance results. New database-backed tests will use bloodmatch_v2_test after schema preparation.

## Deployment

No hosting project, account, payment method, or deployment is created by this setup. A free personal-use deployment can be evaluated after the initial v2 workflows work locally.
