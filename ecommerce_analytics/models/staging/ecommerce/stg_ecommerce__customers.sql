with source as (

    select * from {{ ref('raw_customers') }}

),

renamed as (

    select
        cast(customer_id as integer) as customer_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,
        lower(trim(email)) as email,
        cast(signup_date as date) as signup_date,
        upper(trim(country)) as country,
        upper(trim(state)) as state,
        trim(city) as city,
        lower(trim(marketing_channel)) as marketing_channel,
        lower(trim(customer_status)) as customer_status
    from source

)

select * from renamed
