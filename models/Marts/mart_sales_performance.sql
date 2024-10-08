with Store as (
    select 
    store_bk,
    store_hk,
    store_name
    from {{ ref('sat_stores')}} ss
    where ss.start_date = (select max(start_date) from {{ ref('sat_stores')}} ss2 where ss.store_hk = ss2.store_hk
    )
),

Product as (
    select 
    product_hk,
    product_bk,
    product_name
    from {{ ref('sat_products')}} p1 
    where p1.start_date = (select max(start_date) from {{ ref('sat_products')}} p2 where p1.product_hk = p2.product_hk)
),

OrderItems as (
    select 
    order_bk,
    order_hk,
    product_bk,
    product_hk,
    quantity,
    list_price,
    discount
    from {{ ref('stg_order_items')}}
),

Orders as (
    select
    order_bk,
    order_hk,
    order_date
    from {{ ref('sat_orders')}} o 
    where o.start_date = (select max(start_date) from {{ ref('sat_orders')}} o2 where o.order_hk = o2.order_hk)
),

final as (
    select 
    o.order_bk as order_id,
    o.order_date,
    p.product_bk as product_id,
    p.product_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    s.store_bk as store_id,
    s.store_name
    from ORDERS o
    inner join {{ ref('link_order_product')}} lop on o.order_hk = lop.order_hk
    inner join PRODUCT p on lop.product_hk = p.product_hk
    inner join ORDERITEMS oi on o.order_hk = oi.order_hk and oi.product_hk = p.product_hk
    inner join {{ ref('link_order_store')}} los on o.order_hk = los.order_hk
    inner join STORE s on los.store_hk = s.store_hk
)

select * from final