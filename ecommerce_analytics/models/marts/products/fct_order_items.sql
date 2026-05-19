with order_items as (

    select * from {{ ref('stg_ecommerce__order_items') }}

),

orders as (

    select * from {{ ref('fct_orders') }}

),

products as (

    select * from {{ ref('dim_products') }}

)

select
    order_items.order_item_id,
    order_items.order_id,
    orders.customer_id,
    orders.order_date,
    orders.order_status,
    orders.currency,

    order_items.product_id,
    products.product_name,
    products.category,
    products.subcategory,
    products.brand,
    products.sku,

    orders.is_completed_order,
    orders.is_cancelled_order,
    orders.is_refunded_order,

    order_items.quantity,
    order_items.unit_price_amount,
    order_items.quantity * order_items.unit_price_amount as item_gross_sales_amount,
    order_items.discount_amount as item_discount_amount,
    order_items.line_total_amount as item_net_sales_amount,
    case
        when orders.is_completed_order then order_items.quantity
        else 0
    end as recognized_quantity,
    case
        when orders.is_completed_order then order_items.line_total_amount
        else 0
    end as recognized_item_revenue_amount,
    case
        when orders.is_completed_order then order_items.quantity * products.unit_cost_amount
        else 0
    end as estimated_item_cost_amount,
    case
        when orders.is_completed_order then order_items.line_total_amount - (order_items.quantity * products.unit_cost_amount)
        else 0
    end as estimated_item_gross_profit_amount
from order_items
left join orders
    on order_items.order_id = orders.order_id
left join products
    on order_items.product_id = products.product_id
