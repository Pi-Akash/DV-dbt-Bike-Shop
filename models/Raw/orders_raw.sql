select 
concat('Order_', order_id) as order_id,
concat('Customer_', customer_id) as customer_id,
order_status,
order_date,
required_date,
case
    when shipped_date = 'NULL' then NULL
    else shipped_date
end as shipped_date,
concat('Store_', store_id) as store_id,
concat('Staff_', staff_id) as staff_id,
load_date,
'OLTP' as record_source
from raw.bike_shop.orders