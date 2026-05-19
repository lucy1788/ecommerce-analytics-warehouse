with products as (

    select * from {{ ref('stg_ecommerce__products') }}

)

select
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    sku,
    unit_cost_amount,
    list_price_amount,
    list_price_amount - unit_cost_amount as estimated_unit_margin_amount,
    is_active,
    created_date
from products
