# Version 2 roadmap

## Established direction

- Reuse the existing React + PHP + MySQL application.
- Build for general community use rather than DeMolay Bataan membership.
- Begin with a small friends-only audience.
- Maintain a separate repository and local environment.
- Target free hosting later; deployment is outside the current setup.

## Development foundation

The v2 checkout has isolated ports, database configuration, sessions, root commands, offline checks, CI, and attribution. Application credentials, database rows, documents, and workers are not carried over.

## Next: schema and account policies

1. Prepare a reproducible fresh v2 schema without importing capstone member data.
2. Replace mandatory chapter membership with the agreed general-use access policy.
3. Replace hard-coded administrator identity with an explicit administrator bootstrap process.
4. Decide the initial geographic area and adapt location/facility reference data.
5. Review document collection, verification, privacy copy, and staff review for the new audience.
6. Port database-backed tests and maintenance helpers to the separate v2 targets.

## Then: application adaptation

Adapt public copy and imagery, registration/profile forms, request creation, matching, donor responses, consent-based chat, donation reporting, and moderation. Preserve backend authorization, compatibility/eligibility checks, CSRF protection, transactions, and private document access while changing organization-specific policies.

## Later: friends-only deployment

Verify one complete request/donor workflow locally. Evaluate the free PHP host, configure fresh secrets/storage/email, and verify scheduled processing before inviting friends. A GitHub repository and passing build do not establish a production-ready blood-donation service.
