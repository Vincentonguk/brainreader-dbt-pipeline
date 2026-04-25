with session_audit as (

    select *
    from {{ ref('int_agent_session_audit') }}

)

select
    session_id,
    first_event_at,
    last_event_at,
    event_count,
    agent_count,
    phase_count,
    'Session '
        || session_id
        || ' produced '
        || cast(event_count as {{ dbt.type_string() }})
        || ' governed audit events across '
        || cast(phase_count as {{ dbt.type_string() }})
        || ' SLRPD phases.' as semantic_summary
from session_audit
