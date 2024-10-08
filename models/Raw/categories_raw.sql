select 
concat('Category_', category_id) as category_id,
category_name,
load_date,
'OLTP' as record_source
from {{ source('bike_shop', 'categories')}}