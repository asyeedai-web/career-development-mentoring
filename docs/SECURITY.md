# Security

## Secrets
Supabase service key and any AI key live ONLY in Vercel env vars / server-side modules. Never in client components, never in the repo. Frontend uses the anon key + RLS.

## Permission model
- **v1 demo:** permissive RLS so seeded demo mentees render without login.
- **Lock-down sprint (before real users):**
  - Mentee rows and child rows (responses, profiles, directions, roadmaps, tasks): owner policies `auth.uid() = user_id`.
  - Counselor: read/review/write on recommendations and sessions via role check.
  - Everyone else: no access.
- Enforced in RLS policies, not just UI checks.

## Approved tools rule
The assistant/automation layer may only call the four named tools listed in the agentic doc. No arbitrary DB or shell access. The agent inherits the acting user's permissions.

## Audit principle
Every meaningful write (assessment submitted, recommendation approved, task updated, nudge sent) is logged: who, what, when, payload. Logs are append-only.

## Honesty
If the lock-down migration (multi-user RLS, real emails) exceeds the builder's comfort, stop and get a human before accepting real mentee data. Career data is personal — treat it as sensitive from day one.