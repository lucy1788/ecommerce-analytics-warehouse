with source as (

    select * from {{ ref('raw_orders') }}

),

renamed as (

    select
        cast(order_id as integer) as order_id,
        cast(customer_id as integer) as customer_id,
        cast(order_date as date) as order_date,
        lower(trim(order_status)) as order_status,
        cast(subtotal_amount as decimal(18, 2)) as subtotal_amount,
        cast(discount_amount as decimal(18, 2)) as discount_amount,
        cast(shipping_amount as decimal(18, 2)) as shipping_amount,
        cast(tax_amount as decimal(18, 2)) as tax_amount,
        cast(order_total as decimal(18, 2)) as order_total_amount,
        upper(trim(currency)) as currency
    from source

)

select * from renamed
