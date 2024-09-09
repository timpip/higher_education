{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_he AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT
    id,
    application_deadline,
    publication_date,
    last_publication_date

FROM stg_he