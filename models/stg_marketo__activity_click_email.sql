with base as (

    select *
    from {{ var('activity_click_email') }}

), fields as (

    select 
        activity_date as activity_timestamp,
        activity_type_id,
        campaign_id,
        campaign_run_id,
        choice_number,
        device as click_device,
        email_template_id,
        id as activity_id,
        is_mobile_device,
        lead_id,
        link as click_link_url,
        platform as user_platform,
        primary_attribute_value,
        primary_attribute_value_id,
        step_id,
        user_agent
    from base

), surrogate as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['campaign_id','campaign_run_id','lead_id']) }} as email_send_id
    from fields

)

select *
from surrogate