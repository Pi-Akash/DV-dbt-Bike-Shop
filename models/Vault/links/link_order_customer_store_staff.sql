{{ config(materialized='incremental')         }}

{%- set source_model = "stg_orders"        -%}
{%- set src_pk = "ORDER_CUSTOMER_STORE_STAFF_HK"         -%}
{%- set src_fk = ["ORDER_HK", "CUSTOMER_HK", "STORE_HK", "STAFF_HK"] -%}
{%- set src_ldts = "LOAD_DATETIME"           -%}
{%- set src_source = "SOURCE"         -%}

{{ 
    automate_dv.link(src_pk=src_pk, 
                    src_fk=src_fk, 
                    src_ldts=src_ldts,
                    src_source=src_source, 
                    source_model=source_model) }}