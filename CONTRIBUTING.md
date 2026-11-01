# Contributing to BloodMatch

Start with the [README](README.md), [setup guide](docs/getting-started.md), and [current feature review](docs/features/BLOODMATCH_CURRENT_REQUIREMENTS_STATUS.md).

## Propose a change

For a bug, describe what happened, what you expected, and the steps needed to reproduce it. Include the relevant browser/runtime version and sanitized error output.

For a feature, explain the member or staff problem it solves. Discuss changes to matching, eligibility, privacy, permissions, or donation workflows before implementing a large change. Follow the [project context and approved amendments](docs/project-context.md).

Do not include real member records, identity documents, private conversations, credentials, or database exports in issues, screenshots, fixtures, or pull requests. For a security vulnerability, contact the maintainer privately through an established private channel before publishing reproduction details.

## Make the change

1. Create a focused branch from the branch you intend to target.
2. Follow existing PHP and React conventions and keep changes scoped to the problem.
3. Keep authorization on the backend, preserve CSRF checks, and use prepared SQL statements.
4. Keep matching and eligibility logic in existing services. Proximity must not override blood compatibility.
5. Document configuration changes in `.env.example` using placeholders; keep runtime values in your ignored `.env`.
6. Update relevant documentation when behavior or setup changes.

Avoid unrelated refactors and formatting changes. Database changes require migration review and an explicit target; retain backups and use the dedicated guarded helpers where required.

## Verify and submit

- Run checks relevant to your change. For frontend changes, run `npm.cmd run build` from `frontend/`.
- Use a separate test database for integration suites and follow the [testing guidance](docs/getting-started.md#testing). The historical full runner is retired.
- Record exact checks performed, results, and anything you could not verify. Do not present historical test counts as a new result.
- Open a pull request explaining the problem, resulting behavior, and migration or configuration requirements.

This repository is a fork of [Ruahsen/BloodMatch](https://github.com/Ruahsen/BloodMatch). Preserve attribution and existing third-party license notices.
