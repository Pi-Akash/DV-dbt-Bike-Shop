select 
concat('Store_', store_id) as store_id,
store_name,
phone,
email,
street,
city,
state,
zipcode,
load_date,
'OLTP' as record_source
from raw.bike_shop.stores