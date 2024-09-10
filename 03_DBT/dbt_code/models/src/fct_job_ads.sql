{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_he AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT 
    id,
    NUMBER_OF_VACANCIES AS vacancies,
    relevance
    
FROM stg_he