select * from {{ source('bike_shop', 'order_items') }}