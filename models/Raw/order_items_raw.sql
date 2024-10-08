select 
concat('Order_', order_id) as order_id,
concat('Item_', item_id) as item_id,
concat('Product_', product_id) as product_id,
quantity,
list_price,
discount,
load_date,
'OLTP' as record_source
from {{ source('bike_shop', 'order_items')}}