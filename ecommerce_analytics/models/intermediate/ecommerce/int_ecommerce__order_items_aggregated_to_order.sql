with order_items as (

    select * from {{ ref('stg_ecommerce__order_items') }}

),

aggregated as (

    select
        order_id,
        count(*) as order_item_count,
        sum(quantity) as total_quantity,
        sum(quantity * unit_price_amount) as item_gross_sales_amount,
        sum(discount_amount) as item_discount_amount,
        sum(line_total_amount) as item_net_sales_amount
    from order_items
    group by order_id

)

select * from aggregated
