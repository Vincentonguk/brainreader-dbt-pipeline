with summaries as (

    select *
    from {{ ref('semantic_agent_session_summaries') }}

)

select
    session_id,
    semantic_summary,
    first_event_at,
    last_event_at,
    event_count,
    agent_count,
    phase_count,
    current_timestamp as exported_at
from summaries
where event_count > 0

