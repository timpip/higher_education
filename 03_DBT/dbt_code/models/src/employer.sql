{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_he AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT
    id,
    employer__name AS employer_name,
    employer__workplace AS employer_workplace,
    EMPLOYER__ORGANIZATION_NUMBER as employer_organization_number,
    WORKPLACE_ADDRESS__REGION as workplace_region,
    WORKPLACE_ADDRESS__MUNICIPALITY as workplace_city,
    WORKPLACE_ADDRESS__COUNTRY AS workplace_country

FROM stg_he;