WITH src_aux_attributes AS (SELECT * FROM {{ ref('src_aux_attributes') }})



SELECT
    {{ dbt_utils.generate_surrogate_key(['id','EXPERIENCE_REQUIRED']) }} AS aux_id, 
    experience_required,
    driver_license,
    access_to_own_car,
FROM src_aux_attributes