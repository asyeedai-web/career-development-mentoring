create table if not exists mentees (id uuid primary key default gen_random_uuid(), user_id uuid, name text not null, email text, phone text, education_level text, institution text, field_of_study text, graduation_year int, career_confusion_notes text, status text not null default 'active', created_at timestamptz not null default now());
alter table mentees enable row level security;
drop policy if exists "mentees_v1_read" on mentees;
create policy "mentees_v1_read" on mentees for select using (true);
drop policy if exists "mentees_v1_write" on mentees;
create policy "mentees_v1_write" on mentees for all using (true) with check (true);

create table if not exists assessment_questions (id uuid primary key default gen_random_uuid(), user_id uuid, code text not null, section text not null, question_text text not null, question_type text not null default 'likert', options jsonb, dimension text, display_order int not null default 0, created_at timestamptz not null default now());
alter table assessment_questions enable row level security;
drop policy if exists "assessment_questions_v1_read" on assessment_questions;
create policy "assessment_questions_v1_read" on assessment_questions for select using (true);
drop policy if exists "assessment_questions_v1_write" on assessment_questions;
create policy "assessment_questions_v1_write" on assessment_questions for all using (true) with check (true);

create table if not exists assessment_responses (id uuid primary key default gen_random_uuid(), user_id uuid, mentee_id uuid references mentees(id), question_id uuid references assessment_questions(id), answer jsonb, answered_at timestamptz not null default now(), created_at timestamptz not null default now());
alter table assessment_responses enable row level security;
drop policy if exists "assessment_responses_v1_read" on assessment_responses;
create policy "assessment_responses_v1_read" on assessment_responses for select using (true);
drop policy if exists "assessment_responses_v1_write" on assessment_responses;
create policy "assessment_responses_v1_write" on assessment_responses for all using (true) with check (true);

create table if not exists career_profiles (id uuid primary key default gen_random_uuid(), user_id uuid, mentee_id uuid references mentees(id), interest_scores jsonb, top_values text[], top_strengths text[], skill_gaps text[], summary_text text, summary_source text default 'rule_engine', summary_confidence numeric, summary_review_status text default 'unreviewed', assessment_completed_at timestamptz, created_at timestamptz not null default now());
alter table career_profiles enable row level security;
drop policy if exists "career_profiles_v1_read" on career_profiles;
create policy "career_profiles_v1_read" on career_profiles for select using (true);
drop policy if exists "career_profiles_v1_write" on career_profiles;
create policy "career_profiles_v1_write" on career_profiles for all using (true) with check (true);

create table if not exists career_directions (id uuid primary key default gen_random_uuid(), user_id uuid, mentee_id uuid references mentees(id), title text not null, fit_score numeric check (fit_score >= 0 and fit_score <= 100), rationale text, local_outlook text, source text default 'rule_engine', confidence numeric, review_status text default 'unreviewed', created_at timestamptz not null default now());
alter table career_directions enable row level security;
drop policy if exists "career_directions_v1_read" on career_directions;
create policy "career_directions_v1_read" on career_directions for select using (true);
drop policy if exists "career_directions_v1_write" on career_directions;
create policy "career_directions_v1_write" on career_directions for all using (true) with check (true);

create table if not exists roadmaps (id uuid primary key default gen_random_uuid(), user_id uuid, mentee_id uuid references mentees(id), title text not null default '90-Day Career Action Plan', start_date date, end_date date, status text not null default 'active', created_at timestamptz not null default now());
alter table roadmaps enable row level security;
drop policy if exists "roadmaps_v1_read" on roadmaps;
create policy "roadmaps_v1_read" on roadmaps for select using (true);
drop policy if exists "roadmaps_v1_write" on roadmaps;
create policy "roadmaps_v1_write" on roadmaps for all using (true) with check (true);

create table if not exists roadmap_tasks (id uuid primary key default gen_random_uuid(), user_id uuid, roadmap_id uuid references roadmaps(id), week_number int not null, title text not null, description text, category text, status text not null default 'todo', completed_at timestamptz, created_at timestamptz not null default now());
alter table roadmap_tasks enable row level security;
drop policy if exists "roadmap_tasks_v1_read" on roadmap_tasks;
create policy "roadmap_tasks_v1_read" on roadmap_tasks for select using (true);
drop policy if exists "roadmap_tasks_v1_write" on roadmap_tasks;
create policy "roadmap_tasks_v1_write" on roadmap_tasks for all using (true) with check (true);

create table if not exists recommendations (id uuid primary key default gen_random_uuid(), user_id uuid, mentee_id uuid references mentees(id), counselor_name text, body text not null, type text default 'guidance', review_status text not null default 'draft', created_at timestamptz not null default now());
alter table recommendations enable row level security;
drop policy if exists "recommendations_v1_read" on recommendations;
create policy "recommendations_v1_read" on recommendations for select using (true);
drop policy if exists "recommendations_v1_write" on recommendations;
create policy "recommendations_v1_write" on recommendations for all using (true) with check (true);

create table if not exists sessions (id uuid primary key default gen_random_uuid(), user_id uuid, mentee_id uuid references mentees(id), counselor_name text, scheduled_at timestamptz, mode text default 'online', notes text, follow_up_date date, created_at timestamptz not null default now());
alter table sessions enable row level security;
drop policy if exists "sessions_v1_read" on sessions;
create policy "sessions_v1_read" on sessions for select using (true);
drop policy if exists "sessions_v1_write" on sessions;
create policy "sessions_v1_write" on sessions for all using (true) with check (true);

insert into mentees (name, email, education_level, institution, field_of_study, graduation_year, career_confusion_notes, status) values
('Nusrat Jahan', 'nusrat@example.com', 'Final-year university', 'University of Dhaka', 'Business Administration', 2025, 'Enjoy marketing courses but unsure between brand management and HR.', 'active'),
('Rafiul Hasan', 'rafiul@example.com', 'Recent graduate', 'BUET', 'Computer Science', 2024, 'Good at coding but also like writing; torn between software engineering and tech content.', 'active'),
('Tasnim Akter', 'tasnim@example.com', 'College (HSC)', 'Notre Dame College', 'Science', 2026, 'Like biology and helping people; considering medicine vs public health vs teaching.', 'active')
on conflict do nothing;

insert into assessment_questions (code, section, question_text, question_type, options, dimension, display_order) values
('INT01','interest','I enjoy figuring out how machines or software work','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','technical',1),
('INT02','interest','I like solving maths or logic puzzles','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','analytical',2),
('INT03','interest','I enjoy designing, writing, or making creative content','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','creative',3),
('INT04','interest','I feel energised when helping or teaching others','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','social',4),
('INT05','interest','I like leading teams, pitching ideas, or selling things','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','enterprising',5),
('STR01','strength','Friends say I am good at explaining complicated things simply','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','social',6),
('STR02','strength','I finish tasks I start, even boring ones','likert','["Strongly disagree","Disagree","Neutral","Agree","Strongly agree"]','analytical',7),
('VAL01','values','Which matters most in your future job?','choice','["High salary","Job security","Helping others","Creative freedom","Work-life balance","Prestige"]',null,8),
('SKL01','skills','Which skills do you already have? (pick strongest)','choice','["Writing/speaking","Data/numbers","Design/visuals","Coding","Organising events","Leading people"]',null,9),
('SKL02','skills','How confident are you with English for work?','likert','["Very weak","Weak","Okay","Good","Very good"]',null,10)
on conflict do nothing;

insert into career_profiles (mentee_id, interest_scores, top_values, top_strengths, skill_gaps, summary_text, summary_source, summary_confidence, summary_review_status, assessment_completed_at)
select id, '{"technical":72,"analytical":64,"creative":58,"social":45,"enterprising":38}', array['work-life balance','helping others'], array['explaining simply','finishing tasks'], array['interview skills','portfolio'], 'Strong technical and analytical orientation with a creative side; enjoys building and explaining things.', 'rule_engine', 0.8, 'approved', now() from mentees where email='rafiul@example.com'
on conflict do nothing;

insert into career_directions (mentee_id, title, fit_score, rationale, local_outlook, source, confidence, review_status)
select id, 'Software Engineer (Backend)', 86, 'High technical and analytical scores align with backend development; growing remote and local demand.', 'Strong hiring in Dhaka tech firms and remote market.', 'rule_engine', 0.85, 'approved' from mentees where email='rafiul@example.com'
on conflict do nothing;
insert into career_directions (mentee_id, title, fit_score, rationale, local_outlook, source, confidence, review_status)
select id, 'Data Analyst', 78, 'Analytical strength plus business context makes analytics a strong fit.', 'Banks, telcos and e-commerce firms hire analysts regularly.', 'rule_engine', 0.8, 'reviewed' from mentees where email='rafiul@example.com'
on conflict do nothing;
insert into career_directions (mentee_id, title, fit_score, rationale, local_outlook, source, confidence, review_status)
select id, 'Technical Writer / DevRel', 70, 'Creative and social scores suggest explaining technology to people.', 'Niche but growing with local and remote SaaS companies.', 'rule_engine', 0.7, 'unreviewed' from mentees where email='rafiul@example.com'
on conflict do nothing;

insert into roadmaps (mentee_id, start_date, end_date, status)
select id, current_date, current_date + 90, 'active' from mentees where email='rafiul@example.com'
on conflict do nothing;

insert into roadmap_tasks (roadmap_id, week_number, title, description, category, status)
select r.id, 1, 'Audit your current coding skills', 'List languages, frameworks and projects; identify 2 gaps.', 'skill', 'done' from roadmaps r join mentees m on m.id=r.mentee_id where m.email='rafiul@example.com'
on conflict do nothing;
insert into roadmap_tasks (roadmap_id, week_number, title, description, category, status)
select r.id, 1, 'Set up LinkedIn and GitHub profiles', 'Professional photo, headline, pin 2 best projects.', 'portfolio', 'in_progress' from roadmaps r join mentees m on m.id=r.mentee_id where m.email='rafiul@example.com'
on conflict do nothing;
insert into roadmap_tasks (roadmap_id, week_number, title, description, category, status)
select r.id, 2, 'Build one portfolio project', 'Small but complete backend API with documentation.', 'portfolio', 'todo' from roadmaps r join mentees m on m.id=r.mentee_id where m.email='rafiul@example.com'
on conflict do nothing;
insert into roadmap_tasks (roadmap_id, week_number, title, description, category, status)
select r.id, 3, 'Two informational interviews', 'Talk to 2 working engineers; ask about their path.', 'networking', 'todo' from roadmaps r join mentees m on m.id=r.mentee_id where m.email='rafiul@example.com'
on conflict do nothing;

insert into recommendations (mentee_id, counselor_name, body, type, review_status)
select id, 'Counselor Tanvir', 'Your profile suggests backend engineering first; keep writing as a side strength via a blog. Start the portfolio project this week.', 'guidance', 'sent' from mentees where email='rafiul@example.com'
on conflict do nothing;

insert into sessions (mentee_id, counselor_name, scheduled_at, mode, notes, follow_up_date)
select id, 'Counselor Tanvir', now() - interval '7 days', 'online', 'Reviewed assessment results; agreed on 90-day backend plan.', current_date + 14 from mentees where email='rafiul@example.com'
on conflict do nothing;

insert into sessions (mentee_id, counselor_name, scheduled_at, mode, notes, follow_up_date)
select id, 'Counselor Tanvir', now() - interval '2 days', 'in-person', 'First session: discussed marketing vs HR confusion; assessment assigned.', current_date + 10 from mentees where email='nusrat@example.com'
on conflict do nothing;