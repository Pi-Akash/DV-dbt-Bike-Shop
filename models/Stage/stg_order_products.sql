{%- set yaml_metadata -%}
source_model: "orders_products_raw"

derived_columns:
    SOURCE: RECORD_SOURCE
    LOAD_DATETIME: LOAD_DATE
    START_DATE: "CURRENT_DATE()"
    END_DATE: "TO_DATE('9999-12-31')"

hashed_columns:
    ORDER_HK: "ORDER_ID"
    PRODUCT_HK: "PRODUCT_ID"
    ORDER_PRODUCT_HK:
        columns:
            - "ORDER_ID"
            - "PRODUCT_ID"
            
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict["source_model"] %}
{% set derived_columns = metadata_dict["derived_columns"] %}
{% set hashed_columns = metadata_dict["hashed_columns"] %}

with staging as (
    {{
        automate_dv.stage(include_source_columns=false,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     null_columns=none,
                     hashed_columns=hashed_columns,
                     ranked_columns=none)
    }}   
)

select * from staging