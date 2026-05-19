with payments as (

    select * from {{ ref('stg_ecommerce__payments') }}

),

aggregated as (

    select
        order_id,
        count(*) as payment_transaction_count,
        sum(case when payment_status = 'succeeded' then 1 else 0 end) as succeeded_payment_count,
        sum(case when payment_status = 'refunded' then 1 else 0 end) as refund_payment_count,
        sum(case when payment_status = 'voided' then 1 else 0 end) as voided_payment_count,
        sum(case when payment_status = 'succeeded' then payment_amount else 0 end) as gross_revenue_amount,
        sum(case when payment_status = 'refunded' then abs(payment_amount) else 0 end) as refund_amount,
        sum(
            case
                when payment_status in ('succeeded', 'refunded') then payment_amount
                else 0
            end
        ) as net_revenue_amount
    from payments
    group by order_id

)

select * from aggregated
