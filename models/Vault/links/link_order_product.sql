{{ config(materialized='incremental')         }}

{%- set source_model = "stg_order_products"        -%}
{%- set src_pk = "ORDER_PRODUCT_HK"         -%}
{%- set src_fk = ["ORDER_HK", "PRODUCT_HK"] -%}
{%- set src_ldts = "LOAD_DATETIME"           -%}
{%- set src_source = "SOURCE"         -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}