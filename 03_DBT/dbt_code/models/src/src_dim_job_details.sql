{{
  config(
    materialized = 'ephemeral',
    )
}}


WITH stg_he AS (SELECT * FROM {{ source('he_db', 'stg_data_ads') }})

SELECT
    id,
    headline,
    DESCRIPTION__TEXT as job_description,
    DESCRIPTION__TEXT_FORMATTED AS description_html_formatted,
    EMPLOYMENT_TYPE__LABEL AS employment_type,
    DURATION__LABEL AS duration,
    SALARY_DESCRIPTION AS salary_type,
    scope_of_work__min as scope_of_work_min,
    scope_of_work__max as scope_of_work_max 


FROM stg_he