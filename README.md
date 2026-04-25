# BrainReader dbt Pipeline

This dbt project is the transformation spine for the SLRPD governed-agent ecosystem.

The first production-shaped stream is the governed agent audit flow:

```text
raw.agent_events
  -> staging
  -> intermediate
  -> marts
  -> semantic
  -> exports
```

## SLRPD Meaning

- **Sense**: governed agent events are emitted by the live SLRPD service.
- **Log**: raw audit records are stored in Postgres as `raw.agent_events`.
- **Refine**: staging models standardize event fields.
- **Process**: intermediate and mart models create session-level audit context.
- **Deliver**: semantic and export models prepare memory records for future portal, agent, and vector routes.

## First Source Contract

The first raw Postgres table is expected at `raw.agent_events` with:

- `agent_event_id`
- `session_id`
- `agent_name`
- `phase`
- `event_message`
- `event_metadata`
- `created_at`

Secrets and connection strings belong in dbt Cloud or Render environment settings, never in this repository.

## Catalog Workflow

Run these commands in a deployment environment after `raw.agent_events` exists:

```bash
dbt parse
dbt build
dbt docs generate
```

For dbt Catalog metadata, run `dbt build` and `dbt docs generate` as part of a successful production or staging job.
