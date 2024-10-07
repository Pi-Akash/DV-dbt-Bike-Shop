{%- set yaml_metadata -%}
source_model: "orders_raw"

derived_columns:
    SOURCE: RECORD_SOURCE
    LOAD_DATETIME: LOAD_DATE
    START_DATE: "CURRENT_DATE()"
    END_DATE: "TO_DATE('9999-12-31')"

hashed_columns:
    ORDER_HK: "ORDER_ID"
    CUSTOMER_HK: "CUSTOMER_ID"
    STORE_HK: "STORE_ID"
    STAFF_HK: "STAFF_ID"
    ORDER_CUSTOMER_STORE_STAFF_HK:
        is_hashdiff: true
        columns:
            - "ORDER_ID"
            - "CUSTOMER_ID"
            - "STORE_ID"
            - "STAFF_ID"
    ORDER_HASHDIFF:
        is_hashdiff: true
        columns:
            - "ORDER_ID"

ranked_columns:
    AUTOMATE_DV_RANK:
        partition_by: CUSTOMER_ID
        order_by: ORDER_ID
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict["source_model"] %}
{% set derived_columns = metadata_dict["derived_columns"] %}
{% set hashed_columns = metadata_dict["hashed_columns"] %}
{% set ranked_columns = metadata_dict["ranked_columns"] %}

with staging as (
    {{
        automate_dv.stage(include_source_columns=false,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     null_columns=none,
                     hashed_columns=hashed_columns,
                     ranked_columns=ranked_columns)
    }}   
)

select * from staging