with payments as (

    select * from {{ ref('stg_ecommerce__payments') }}

),

orders as (

    select
        order_id,
        currency
    from {{ ref('stg_ecommerce__orders') }}

),

payment_events as (

    select
        payments.payment_date as revenue_date,
        orders.currency,
        payments.order_id,
        payments.payment_status,
        payments.payment_amount
    from payments
    left join orders
        on payments.order_id = orders.order_id

)

select
    cast(revenue_date as varchar) || '-' || currency as daily_revenue_id,
    revenue_date,
    currency,

    count(*) as payment_transaction_count,
    sum(case when payment_status = 'succeeded' then 1 else 0 end) as succeeded_payment_count,
    sum(case when payment_status = 'refunded' then 1 else 0 end) as refund_payment_count,
    sum(case when payment_status = 'voided' then 1 else 0 end) as voided_payment_count,
    count(distinct case when payment_status = 'succeeded' then order_id end) as paid_order_count,
    count(distinct case when payment_status = 'refunded' then order_id end) as refunded_order_count,
    count(distinct case when payment_status = 'voided' then order_id end) as voided_order_count,

    sum(case when payment_status = 'succeeded' then payment_amount else 0 end) as gross_revenue_amount,
    sum(case when payment_status = 'refunded' then abs(payment_amount) else 0 end) as refund_amount,
    sum(
        case
            when payment_status in ('succeeded', 'refunded') then payment_amount
            else 0
        end
    ) as net_revenue_amount
from payment_events
group by
    revenue_date,
    currency
