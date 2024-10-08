select 
concat('Staff_', staff_id) as staff_id,
first_name,
last_name,
email,
phone,
active,
concat('Store_', store_id) as store_id,
case
    when manager_id = 'NULL' then NULL
    else concat('Staff_', manager_id) 
end as manager_id,
load_date,
'OLTP' as record_source
from raw.bike_shop.staffs