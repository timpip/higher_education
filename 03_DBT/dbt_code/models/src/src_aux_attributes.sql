{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_he AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT 
    id,
    EXPERIENCE_REQUIRED as experience_required,
    DRIVING_LICENSE_REQUIRED as driver_license,
    ACCESS_TO_OWN_CAR as access_to_own_car
FROM stg_he