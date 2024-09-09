{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_he AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT -- id ska först, hittar inte just nu 
    id,
    EXPERIENCE_REQUIRED as experience_required,
    DRIVING_LICENSE_REQUIRED as driver_license,
    ACCESS_TO_OWN_CAR as ACCESS_TO_CAR
FROM stg_he