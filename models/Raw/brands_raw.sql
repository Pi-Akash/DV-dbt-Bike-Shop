select 
CONCAT('Brand_', BRAND_ID) as BRAND_ID,
BRAND_NAME,
LOAD_DATE,
'OLTP' as record_source
from RAW.BIKE_SHOP.BRANDS