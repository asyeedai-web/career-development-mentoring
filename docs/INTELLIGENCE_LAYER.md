# Intelligence Layer

## Messy input → structured
Free-text answers ("I like building stuff but hate monotonous jobs") and multiple-choice. Each question maps to one dimension; answers stored raw, scored in code.

**Scoring schema (career_profiles.interest_scores):**
```json
{"technical": 72, "analytical": 64, "creative": 58, "social": 45, "enterprising": 38}
```

## Rule-based scoring (v1, works with AI off)
- Interest dimension score = (points earned / max possible) × 100. Likert 1–5 → 0, 25, 50, 75, 100 points.
- Values/skills: top-3 tally across preference questions.
- **Direction fit score** = 60% interest-dimension match + 20% values match + 20% skills match vs. catalog profile per direction. Keep top 3–5 with fit ≥ 55; store all numbers.

## What gets ranked
- Career Directions per mentee (by fit_score).
- Roadmap tasks per week (generated from the chosen direction's task template; e.g. Week 1: skills audit, LinkedIn setup, 1 intro informational interview).

## Events to track (activities)
assessment_started, assessment_completed, profile_viewed, direction_selected, roadmap_generated, task_completed, recommendation_added, session_logged.

## v1 vs later
- **v1:** pure rule-based scoring + templated roadmaps; optional AI draft of profile summary text (`summary_source='ai'`, confidence, review_status='unreviewed' until counselor approves).
- **Later:** AI-drafted direction rationale, task personalization from mentee notes, progress-risk flags (e.g. "no tasks completed in 14 days").