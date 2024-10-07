select 
concat('Category_', category_id) as category_id,
category_name,
load_date,
'OLTP' as record_source
from raw.bike_shop.categories