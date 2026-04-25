with events as (

    select *
    from {{ ref('stg_agent_events') }}

),

session_audit as (

    select
        session_id,
        min(created_at) as first_event_at,
        max(created_at) as last_event_at,
        count(*) as event_count,
        count(distinct agent_name) as agent_count,
        count(distinct phase) as phase_count
    from events
    group by session_id

)

select *
from session_audit

