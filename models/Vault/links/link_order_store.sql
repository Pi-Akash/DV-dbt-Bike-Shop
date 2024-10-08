{{ config(materialized='incremental')         }}

{%- set source_model = "stg_order_stores"        -%}
{%- set src_pk = "ORDER_STORE_HK"         -%}
{%- set src_fk = ["ORDER_HK", "STORE_HK"] -%}
{%- set src_ldts = "LOAD_DATETIME"           -%}
{%- set src_source = "SOURCE"         -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}