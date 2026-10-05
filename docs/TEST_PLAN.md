# Test Plan (manual)

## Success scenario (end-to-end)
1. Open site anonymously → dashboard shows seeded mentees and demo roadmap (no login wall).
2. Create new mentee (name, education level, notes) → appears in list.
3. Start assessment → complete all 40 questions → submit.
4. Career Profile shows 5 dimension scores, top values/strengths, summary.
5. 3–5 Career Directions shown, ranked by fit score, with rationale.
6. Generate 90-day roadmap → 12 weekly tasks appear.
7. Mark Week 1 task done → progress bar updates; refresh → still done.
8. Open Counselor Console → open this mentee → see profile, directions, roadmap.
9. Add recommendation → appears on mentee's profile. Log a session with follow-up date → appears in session list.
10. Refresh everything — all data persists.

## Empty/error/loading
- New mentee with no assessment: profile/roadmap pages show "Start your assessment" empty state, no broken layout.
- Dashboard with zero mentees: friendly empty state + create button.
- Submit assessment with unanswered required section: blocked with clear message.
- Invalid form input (bad email): inline error.
- Simulate network failure on save: error banner, data not silently lost.
- Slow query: skeleton loaders, not blank screens.

## Permissions (post lock-down)
- Logged-out: no access to mentee data.
- Mentee A cannot see Mentee B's profile/roadmap (check via direct URL).
- Counselor sees all mentees; mentee does not see Counselor Console routes.

## Data integrity
- Fit scores within 0–100 in DB. Task status transitions only via UI actions. Refresh identical on second device/browser.