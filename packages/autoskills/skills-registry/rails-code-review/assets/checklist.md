# Rails Code Review Checklist

Quick checklist for PR reviews focusing on Rails app safety, performance, and conventions.

Security & correctness
- Check strong params and allowed attributes in controllers
- Verify no SQL injection or unescaped user input in find/where
- Ensure redirects use `allow_host` or `redirect_to root_path, status: :see_other` where appropriate

Database & performance
- Confirm indexes exist for WHERE/JOIN columns used in queries
- Look for N+1 queries; suggest includes or counter caches
- Ensure large deletes/updates use batched operations or `delete_all` with care

Migrations & schema
- Migration safety: avoid table rewrites & ensure backfills are safe
- Prefer reversible migrations and add `safety_assured` notes if necessary

Testing & coverage
- Relevant tests added for changed behavior
- No new behavior without tests (unit or request/integration)

Style & maintainability
- Controllers are thin; complex logic moved to services
- No long methods (> 40 lines) without clear decomposition
- Public interfaces documented with YARD where needed

Release safety
- Check feature flags exist for behavior toggles
- Verify no hardcoded credentials or secrets

Output format for findings
- severity, file, line (optional), risk, recommendation, proof_of_concept

Use this file as the baseline for automated review comments and reviewer guidance.