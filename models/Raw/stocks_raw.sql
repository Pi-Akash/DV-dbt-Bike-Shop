select 
concat('Store_', store_id) as store_id,
concat('Product_', product_id) as product_id,
quantity,
load_date,
'OLTP' as record_source
from raw.bike_shop.stocks