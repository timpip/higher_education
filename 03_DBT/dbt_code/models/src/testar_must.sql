{# {{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_data_ads AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT 
    id,
    headline

FROM stg_data_ads #}