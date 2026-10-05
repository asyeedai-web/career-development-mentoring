# Agentic Layer

Risk levels: low = auto, medium = light approval, high = always approval, critical = human-only.

## Draftable (low risk — auto)
- Draft profile summary text from scores → stored with `summary_source='ai'`, `review_status='unreviewed'`.
- Tag mentee status (e.g. "needs follow-up" when roadmap stalled).
- Summarize a mentee's month of activity for counselor review.

## Executable after approval (medium)
- Add a recommendation draft to a mentee (counselor clicks Approve → status 'sent').
- Append a task to an existing roadmap.
- Update a task's status from mentee activity notes.

## Always-approval (high)
- Send any outbound message (email/WhatsApp nudge to a mentee).

## Human-only (critical)
- Delete a mentee, roadmap or assessment data.
- Any payment, refund, or legal/medical claim about a person's career.

## Named tools only
The assistant may call ONLY: `generate_profile_summary`, `draft_recommendation`, `append_roadmap_task`, `send_mentee_nudge`. No raw shell/DB tools.

## Audit log (every action)
action, actor, mentee_id, object_type, object_id, payload jsonb, approved_by, created_at.

## v1 vs later
- **v1:** rule-based engine only; AI drafting of summaries is the one low-risk addition. All counselor-facing writes require a human click.
- **Later:** approval workflows for nudges, auto-progress flagging.