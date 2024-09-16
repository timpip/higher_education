WITH job_ads AS (SELECT * FROM {{ ref('src_job_ads') }}),

job_details AS (SELECT * FROM {{ ref('src_dim_job_details') }}),

employer AS (SELECT * FROM {{ ref('src_employer') }}),

aux_attributes AS (SELECT * FROM {{ ref('src_aux_attributes') }}),

date AS (SELECT * FROM {{ ref('src_dim_date') }})

SELECT 
    {{dbt_utils.generate_surrogate_key(['job_details.id', 'job_details.headline'])}} as job_details_key,
    {{dbt_utils.generate_surrogate_key(['employer.id', 'employer.employer_name'])}} as employer_key,
    {{dbt_utils.generate_surrogate_key(['date.application_deadline', 'date.id'])}} as date_key,
    {{dbt_utils.generate_surrogate_key(['aux_attributes.id', 'aux_attributes.experience_required'])}} as aux_key,
    job_details.id,
    relevance,
    coalesce(vacancies, 1) as vacancies,
    application_deadline,
    
    
    
FROM 
    job_ads 
LEFT JOIN 
    job_details ON job_ads.id = job_details.id
LEFT JOIN 
    employer ON job_ads.id = employer.id
LEFT JOIN
    date ON job_ads.id = date.id
LEFT JOIN 
    aux_attributes ON job_ads.id = aux_attributes.id
