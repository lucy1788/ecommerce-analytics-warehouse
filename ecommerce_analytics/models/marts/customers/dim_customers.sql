with customers as (

    select * from {{ ref('stg_ecommerce__customers') }}

),

orders as (

    select * from {{ ref('fct_orders') }}

),

customer_orders as (

    select
        customer_id,
        count(*) as order_count,
        sum(case when is_completed_order then 1 else 0 end) as completed_order_count,
        sum(case when is_cancelled_order then 1 else 0 end) as cancelled_order_count,
        sum(case when is_refunded_order then 1 else 0 end) as refunded_order_count,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        sum(gross_revenue_amount) as lifetime_gross_revenue_amount,
        sum(refund_amount) as lifetime_refund_amount,
        sum(net_revenue_amount) as lifetime_net_revenue_amount
    from orders
    group by customer_id

)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.first_name || ' ' || customers.last_name as customer_name,
    customers.email,
    customers.signup_date,
    customers.country,
    customers.state,
    customers.city,
    customers.marketing_channel,
    customers.customer_status,

    coalesce(customer_orders.order_count, 0) as order_count,
    coalesce(customer_orders.completed_order_count, 0) as completed_order_count,
    coalesce(customer_orders.cancelled_order_count, 0) as cancelled_order_count,
    coalesce(customer_orders.refunded_order_count, 0) as refunded_order_count,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.lifetime_gross_revenue_amount, 0) as lifetime_gross_revenue_amount,
    coalesce(customer_orders.lifetime_refund_amount, 0) as lifetime_refund_amount,
    coalesce(customer_orders.lifetime_net_revenue_amount, 0) as lifetime_net_revenue_amount
from customers
left join customer_orders
    on customers.customer_id = customer_orders.customer_id
