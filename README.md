# SLRPD dbt Agent Audit Architecture Plan

## Summary
The Co Author Vinicios Ongaratto Build the first clean SLRPD dbt architecture from GitHub `main` in `Vincentonguk/brainreader-dbt-pipeline`, using **governed agent audit data** as the first source-of-truth stream.

The goal is to replace the starter dbt example project with a production-shaped SLRPD pipeline:

```text
Agent events -> raw contract -> staging -> intermediate -> marts -> semantic -> exports
```

This will prepare dbt Catalog lineage, documentation, and future Render/Postgres integration.

## Key Changes
- Update `dbt_project.yml`:
  - Keep project name `brainreader_dbt`.
  - Replace `models/example` config with:
    - `staging` as views
    - `intermediate` as views
    - `marts` as tables
    - `semantic` as views
    - `exports` as tables

- Replace starter example models:
  - Remove `models/example/my_first_dbt_model.sql`
  - Remove `models/example/my_second_dbt_model.sql`
  - Remove `models/example/schema.yml`

- Add first SLRPD model structure:
  - `models/sources.yml`
  - `models/staging/stg_agent_events.sql`
  - `models/intermediate/int_agent_session_audit.sql`
  - `models/marts/fct_agent_audit_events.sql`
  - `models/semantic/semantic_agent_session_summaries.sql`
  - `models/exports/export_agent_memory.sql`

- Define the first Postgres source contract as:
  - schema: `raw`
  - table: `agent_events`
  - expected columns:
    - `agent_event_id`
    - `session_id`
    - `agent_name`
    - `phase`
    - `event_message`
    - `event_metadata`
    - `created_at`

- Update `README.md` to describe the SLRPD governed-agent dbt pipeline and Catalog workflow.

## dbt Behavior
- `stg_agent_events` standardizes raw audit rows.
- `int_agent_session_audit` groups events by session and creates audit timing context.
- `fct_agent_audit_events` becomes the trusted event-level fact table.
- `semantic_agent_session_summaries` creates human-readable session summaries for agent/portal use.
- `export_agent_memory` exposes approved semantic memory rows for future agent/vector routing.

## Validation
Run these commands after implementation:

```bash
dbt parse
dbt build
dbt docs generate
```

Expected result:
- dbt parses without compilation errors.
- Starter example model tests are gone.
- SLRPD audit models build successfully once `raw.agent_events` exists in Postgres.
- dbt Catalog can show lineage after a successful deployment job.
https://www.youtube.com/watch?v=Njm6fMnZOhI
## Assumptions
- GitHub `main` is the implementation base.
- Current uncommitted dbt Studio branch changes are not the source of truth.
- The first architecture pass focuses on governed agent audit data, not BrainReader telemetry.
- The raw Postgres table does not need to exist before code structure is committed, but it must exist before `dbt build` succeeds against the real warehouse.
- Secrets such as `DATABASE_URL` stay in Render/dbt environment settings, never in repo files.
