with Customer as (
    select 
        customer_bk,
        customer_hk,
        first_name,
        last_name,
        city,
        state,
        zipcode
    from {{ ref('sat_customers')}}
),

Orders as (
    select
    order_bk,
    order_hk,
    order_date
    from {{ ref('sat_orders')}}
),

OrderItems as (
    select
    order_bk,
    order_hk,
    product_bk,
    quantity,
    list_price,
    discount
    from {{ ref('stg_order_items')}}
),

final as (
    select 
    c.customer_bk as customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.zipcode,
    o.order_bk as order_id,
    o.order_date,
    oi.product_bk as product_id,
    oi.quantity,
    oi.list_price,
    oi.discount
    from CUSTOMER c
    left join {{ ref('link_order_customer_store_staff')}} loc on c.customer_hk = loc.customer_hk
    inner join ORDERS o on loc.order_hk = o.order_hk
    inner join ORDERITEMS oi on o.order_hk = oi.order_hk
)

select * from final