select
concat('Order_', o.order_id) as order_id,
concat('Product_', p.product_id) as product_id,
current_timestamp() as load_date,
'OLTP' as record_source
from {{ source('bike_shop', 'orders') }} o
left join {{ source('bike_shop', 'order_items') }} oi on o.order_id = oi.order_id
inner join {{ source('bike_shop', 'products') }} p on oi.product_id = p.product_id