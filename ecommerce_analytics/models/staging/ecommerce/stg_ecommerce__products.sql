with source as (

    select * from {{ ref('raw_products') }}

),

renamed as (

    select
        cast(product_id as integer) as product_id,
        trim(product_name) as product_name,
        lower(trim(category)) as category,
        lower(trim(subcategory)) as subcategory,
        trim(brand) as brand,
        upper(trim(sku)) as sku,
        cast(unit_cost as decimal(18, 2)) as unit_cost_amount,
        cast(list_price as decimal(18, 2)) as list_price_amount,
        cast(is_active as boolean) as is_active,
        cast(created_at as date) as created_date
    from source

)

select * from renamed
