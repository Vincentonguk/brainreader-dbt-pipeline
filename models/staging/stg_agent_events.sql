with source as (

    select *
    from {{ source('raw_slrpd', 'agent_events') }}

),

renamed as (

    select
        cast(agent_event_id as {{ dbt.type_string() }}) as agent_event_id,
        cast(session_id as {{ dbt.type_string() }}) as session_id,
        cast(agent_name as {{ dbt.type_string() }}) as agent_name,
        cast(phase as {{ dbt.type_string() }}) as phase,
        cast(event_message as {{ dbt.type_string() }}) as event_message,
        event_metadata,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    from source

)

select *
from renamed

