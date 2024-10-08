select
concat('Order_', o.order_id) as order_id,
concat('Store_', s.store_id) as store_id,
current_timestamp() as load_date,
'OLTP' as record_source
from {{ source('bike_shop', 'orders') }} o
left join {{ source('bike_shop', 'stores') }} s on o.store_id = s.store_id