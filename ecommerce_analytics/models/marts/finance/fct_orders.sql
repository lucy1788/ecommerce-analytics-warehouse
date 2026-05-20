with orders as (

    select * from {{ ref('stg_ecommerce__orders') }}

),

order_items as (

    select * from {{ ref('int_ecommerce__order_items_aggregated_to_order') }}

),

payments as (

    select * from {{ ref('int_ecommerce__payments_aggregated_to_order') }}

)

select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.order_status,
    orders.currency,

    orders.order_status = 'completed' as is_completed_order,
    orders.order_status = 'cancelled' as is_cancelled_order,
    orders.order_status = 'refunded' as is_refunded_order,

    coalesce(order_items.order_item_count, 0) as order_item_count,
    coalesce(order_items.total_quantity, 0) as total_quantity,
    coalesce(order_items.item_gross_sales_amount, 0) as item_gross_sales_amount,
    coalesce(order_items.item_discount_amount, 0) as item_discount_amount,
    coalesce(order_items.item_net_sales_amount, 0) as item_net_sales_amount,

    orders.subtotal_amount as order_subtotal_amount,
    orders.discount_amount as order_discount_amount,
    orders.shipping_amount,
    orders.tax_amount,
    orders.order_total_amount,

    coalesce(payments.payment_transaction_count, 0) as payment_transaction_count,
    coalesce(payments.succeeded_payment_count, 0) as succeeded_payment_count,
    coalesce(payments.refund_payment_count, 0) as refund_payment_count,
    coalesce(payments.voided_payment_count, 0) as voided_payment_count,
    coalesce(payments.gross_revenue_amount, 0) as gross_revenue_amount,
    coalesce(payments.refund_amount, 0) as refund_amount,
    coalesce(payments.net_revenue_amount, 0) as net_revenue_amount
from orders
left join order_items
    on orders.order_id = order_items.order_id
left join payments
    on orders.order_id = payments.order_id
