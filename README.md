# BrainReader dbt Pipeline

## Origin and Authorship

The **SLRPD / BrainReader ecosystem** is an original architecture by **Vinicios Ongaratto**, developed through sustained research, experimentation, design, and engineering work over time.

This project did not begin as a single generated repository or a one-click output. It is part of a wider ecosystem that has been built through continuous thinking, testing, refinement, and architectural development around governed agents, telemetry, semantic processing, dbt lineage, Render services, and future BCI-oriented systems.

Codex is used here as an AI-assisted engineering partner. Its role is to help structure, implement, document, and refine technical components based on the direction, concepts, and ecosystem architecture defined by **Vinicios Ongaratto**.

## Purpose of This Repository

This repository contains one technical layer of the wider SLRPD / BrainReader ecosystem: the **dbt governed-agent audit pipeline**.

The purpose of this dbt project is to make the governed-agent layer traceable, documented, and ready for dbt Catalog, lineage analysis, Render/Postgres integration, and future semantic or vector-routing workflows.

This repository does not represent the entire BrainReader ecosystem. It is one implementation component inside a larger architecture.

## First Production-Shaped Stream

The first modeled stream is the governed-agent audit flow:

```text
raw.agent_events
  -> staging
  -> intermediate
  -> marts
  -> semantic
  -> exports
```

This flow turns raw governed-agent events into structured dbt models that can support auditability, lineage, semantic summaries, and future agent memory exports.

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

Secrets, credentials, database URLs, and API keys must stay in dbt Cloud, Render, or other secure environment settings. They should never be committed to this repository.

## Catalog Workflow

After `raw.agent_events` exists in the connected Postgres environment, run:

```bash
dbt parse
dbt build
dbt docs generate
```

For dbt Catalog metadata, `dbt build` and `dbt docs generate` should run as part of a successful production or staging deployment job.

