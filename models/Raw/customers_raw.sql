select 
concat('Customer_', customer_id) as customer_id,
first_name,
last_name,
case 
    when phone = 'NULL' then NULL
    else phone
end as phone,
email,
street,
city,
state,
zipcode,
load_date,
'OLTP' as record_source
from {{ source('bike_shop', 'customers')}}