{%- set yaml_metadata -%}
source_model: "staffs_raw"

derived_columns:
    STAFF_BK: STAFF_ID
    STORE_BK: STORE_ID
    MANAGER_BK: MANAGER_ID
    FIRST_NAME: FIRST_NAME
    LAST_NAME: LAST_NAME
    EMAIL: EMAIL
    PHONE: PHONE
    ACTIVE: ACTIVE
    SOURCE: RECORD_SOURCE
    LOAD_DATETIME: LOAD_DATE
    START_DATE: "CURRENT_DATE()"
    END_DATE: "TO_DATE('9999-12-31')"

hashed_columns:
    STAFF_HK: "STAFF_ID"
    STORE_HK: "STORE_ID"
    MANAGER_HK: "MANAGER_ID"
    STAFF_HASHDIFF:
        is_hashdiff: true
        columns:
            - "STAFF_ID"
            - "FIRST_NAME"
            - "LAST_NAME"
            - "EMAIL"
            - "PHONE"
            - "ACTIVE"
            - "STORE_ID"
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