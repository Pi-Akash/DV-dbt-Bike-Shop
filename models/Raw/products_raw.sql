select 
concat('Product_', product_id) as product_id,
product_name,
concat('Brand_', brand_id) as brand_id,
concat('Category_', category_id) as category_id,
model_year,
list_price,
load_date,
'OLTP' as record_source
from {{ source('bike_shop', 'products')}}