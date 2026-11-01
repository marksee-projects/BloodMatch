# BloodMatch

Version 2 of a peer-to-peer blood donor coordination platform, being adapted for a broader community.

This repository reuses the React, PHP, and MySQL application from the [capstone project](https://github.com/marksee-projects/BloodMatch_Ver2). It is an active development baseline: chapter membership, Bataan location references, verification, and staff policies still need adaptation before general use.

## Local development

Use Node.js 24+ (recommended version in [.nvmrc](.nvmrc)), npm, PHP 8.2+ with PDO MySQL, and MySQL/MariaDB. Windows/XAMPP is supported.

From the repository root:

~~~powershell
npm run setup
npm run dev
~~~

| Service | Version 2 default |
| --- | --- |
| Frontend | http://localhost:5180 |
| API | http://127.0.0.1:8010 |
| Development database | bloodmatch_v2 |
| Planned test database | bloodmatch_v2_test |

Setup installs frontend dependencies and creates fresh local configuration. It does not create a database, apply inherited migrations, send email, install workers, or deploy. The frontend and CSRF endpoint can run before schema preparation; authenticated features require a configured v2 database.

## Commands

| Command | Purpose |
| --- | --- |
| npm run setup | Initialize local files and install frontend dependencies |
| npm run doctor | Check local prerequisites without connecting to MySQL |
| npm run dev | Start the isolated v2 frontend and API |
| npm run check | PHP syntax and selected offline policy checks |
| npm run build | Build the React application |

## Development notes

- [Environment guide](docs/development-v2.md)
- [Version 2 roadmap](docs/v2-roadmap.md)
- [Contributing](CONTRIBUTING.md)

Existing schema, API, test, and checkpoint documents record the inherited capstone implementation. They do not establish the v2 product policy or a ready-to-run fresh database installation.

## Origin

BloodMatch builds on [Ruahsen/BloodMatch](https://github.com/Ruahsen/BloodMatch) and the subsequent [marksee-projects capstone development](https://github.com/marksee-projects/BloodMatch_Ver2). Git history preserves the original contributions. Retain attribution and existing third-party notices.
