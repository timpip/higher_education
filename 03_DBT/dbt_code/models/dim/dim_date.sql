WITH src_dim_date AS (SELECT * FROM {{ ref('src_dim_date') }})



SELECT
    {{ dbt_utils.generate_surrogate_key(['id','application_deadline']) }} AS date_id, 
    application_deadline,
    publication_date,
    last_publication_date,
FROM src_dim_date