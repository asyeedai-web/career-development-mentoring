# Task Plan

## Sprint 1 — Foundation & demo data
- Create all 9 tables + RLS (permissive v1) + seed data (3 demo mentees, 40 questions, full demo profile/roadmap)
- App shell: sidebar (Dashboard, Assessment, My Profile, My Roadmap, Counselor Console), mobile hamburger
- `lib/data/` layer for all reads/writes
**Done when:** dashboard renders seeded mentees + roadmap without login, survives refresh.

## Sprint 2 — Assessment engine (core verb) ⭐ core engine first
- Assessment flow: 40 questions by section, save responses in batches, resume support
- Rule-based scoring: 5 dimensions, values, skills, fit scores
- Career Profile screen + 3–5 Career Directions with rationale
- Empty/error/loading states on every screen
**Done when:** a NEW mentee completes assessment and sees profile + ranked directions persisted in DB.

## Sprint 3 — 90-day roadmap & tracking
- Generate 90-day roadmap from top direction template (12 weekly tasks)
- Task list with status (todo/in_progress/done), mark-done persists
- Progress bar on dashboard
**Done when:** mentee completes assessment → roadmap → marks first task done, all persisted.

## Sprint 4 — Counselor console — 🏁 **v1 functional milestone** (success scenario usable end-to-end)
- Mentee list with assessment/roadmap status
- Review profile + directions; approve/adjust AI-drafted summary (review_status)
- Add recommendations; log sessions with follow-up date
**Done when:** counselor reviews a mentee, posts a recommendation, logs a session — full success scenario works.

## Sprint 5 — Lock it down
- Signup/login (mentee + counselor roles)
- Owner-scoped RLS policies replace permissive ones; seed data visible as demo only
- Audit log on all writes
**Done when:** mentee sees only their data; anonymous access blocked; counselor sees all mentees.

## Sprint 6 — Polish & pilot prep (later)
- AI-drafted summary/direction rationale (low-risk, review-gated)
- Progress nudge drafts, mobile polish, pilot onboarding copy

## Gantt
```
S1 Foundation  █
S2 Assessment     █
S3 Roadmap           █
S4 Counselor            █  ← v1 functional
S5 Lock-down              █
S6 AI/polish                █
```