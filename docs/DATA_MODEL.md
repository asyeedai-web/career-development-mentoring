# Data Model

All tables: `id uuid pk`, nullable `user_id uuid` (owner-scoping later), `created_at`.

## mentees
name, email, phone, education_level, institution, field_of_study, graduation_year, career_confusion_notes, status.

## assessment_questions
code, section (interest/strength/values/skills/preferences), question_text, question_type, options jsonb, dimension (which of 5 it scores), display_order.

## assessment_responses
mentee_id → mentees, question_id → assessment_questions, answer jsonb, answered_at.

## career_profiles (AI-assisted fields)
mentee_id, interest_scores jsonb (5 dims, 0–100), top_values text[], top_strengths text[], skill_gaps text[], summary_text, `summary_source text`, `summary_confidence numeric`, `summary_review_status text default 'unreviewed'`, assessment_completed_at.

## career_directions (AI-assisted fields)
mentee_id, title, fit_score numeric, rationale (BD job-market context), local_outlook, `source text`, `confidence numeric`, `review_status text default 'unreviewed'`.

## roadmaps
mentee_id, title (e.g. "90-Day Career Action Plan"), start_date, end_date, status (active/completed/paused).

## roadmap_tasks
roadmap_id, week_number, title, description, category (skill/practice/networking/portfolio/application), status (todo/in_progress/done), completed_at.

## recommendations
mentee_id, counselor_name, body, type (guidance/course/cv/interview), review_status (draft/sent).

## sessions
mentee_id, counselor_name, scheduled_at, mode (in-person/phone/online), notes, follow_up_date.

## RLS notes
- v1 (demo): permissive read/write policies on all tables — app runs without login.
- Lock-down sprint: owner policies (`auth.uid() = user_id`) for mentees and their child rows; counselor role gets read/review access via membership check.
- Constraints enforced in DB: fit_score 0–100 check, status enums via check constraints.