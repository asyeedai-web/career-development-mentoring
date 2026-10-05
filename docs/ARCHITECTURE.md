# Architecture

**Stack:** Next.js (App Router) + Supabase (Postgres, RLS) + Vercel.

## Build order (data → logic → smart features)
1. **Data layer first:** all tables, constraints, seeded demo rows, open-read policies; `lib/data/` is the only place that touches the DB.
2. **App logic:** rule-based scoring engine + roadmap generator in `lib/assessment/` — pure functions, fully working with AI off.
3. **Smart layer:** `lib/ai/` drafts profile summaries/direction rationale; every output stored with `source`, `confidence`, `review_status`; counselor must approve before it shows as final.

## Key flow (assessment → roadmap)
1. Mentee profile created → answers 40 questions (batched save) → scoring engine computes 5 interest dimensions + top values/skills → matched against Career Direction catalog → top 3–5 with fit scores persisted → 90-day Roadmap + weekly tasks generated from direction templates → mentee tracks tasks → counselor reviews and annotates.

## App shell
Multi-page: persistent left sidebar (Dashboard, Assessment, My Profile, My Roadmap, Counselor Console) on desktop; hamburger menu on mobile; current section highlighted; keyboard accessible.

## Repo structure (feature-oriented)
- `lib/data/` — DB reads/writes only (queries, mutations)
- `lib/assessment/` — scoring + roadmap generation
- `lib/ai/` — drafting (separate module)
- `app/(mentee)/`, `app/(counselor)/` — routes
- `components/` — shared UI
- `tests/` beside the code they test

## Module map (build order)
1. **Assessment Engine** — owns questions, responses, scoring; produces Career Profile + Directions. (First — core engine.)
2. **Roadmap Module** — owns roadmaps, tasks, completion status.
3. **Counselor Console** — owns recommendations, sessions, review status.
4. **Mentee Portal** — profile, results, task tracking views.
5. **Auth & Isolation** — login, owner-scoped RLS (later sprint).