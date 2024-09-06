SELECT * 
FROM {{ source('he_db', 'stg_data_ads') }}