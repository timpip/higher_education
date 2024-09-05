{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_job_ads AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT *
FROM stg_job_ads;