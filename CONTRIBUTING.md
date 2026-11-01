# Contributing

This is the BloodMatch v2 development repository. Start with [local setup](docs/development-v2.md) and the [v2 roadmap](docs/v2-roadmap.md).

Use develop for active work and pull requests into main. Keep changes focused and run npm run check and npm run build before review. Report any unverified behavior explicitly.

Keep database credentials, member records, identity documents, private messages, encryption keys, and email credentials out of Git. Use separate synthetic test data and a v2 test database when database testing is introduced.

The inherited capstone requirements/checkpoints describe historical behavior. Follow the v2 roadmap for adaptation and preserve authentication, authorization, privacy, matching correctness, and transaction safeguards. Port legacy SQL utilities and scheduled-task scripts before executing them in this checkout.

Preserve attribution to [Ruahsen/BloodMatch](https://github.com/Ruahsen/BloodMatch) and the [capstone continuation](https://github.com/marksee-projects/BloodMatch_Ver2), along with existing third-party notices.
