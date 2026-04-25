with events as (

    select *
    from {{ ref('stg_agent_events') }}

),

session_audit as (

    select *
    from {{ ref('int_agent_session_audit') }}

)

select
    events.agent_event_id,
    events.session_id,
    events.agent_name,
    events.phase,
    events.event_message,
    events.event_metadata,
    events.created_at,
    session_audit.first_event_at,
    session_audit.last_event_at,
    session_audit.event_count as session_event_count,
    session_audit.agent_count as session_agent_count,
    session_audit.phase_count as session_phase_count
from events
left join session_audit
    on events.session_id = session_audit.session_id

