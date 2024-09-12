WITH fct_job_ads AS (
    SELECT * FROM {{ ref('fct_job_ads') }}
),

job_details AS (SELECT * FROM {{ ref('dim_job_details') }}),

employer AS (SELECT * FROM {{ ref('dim_employer') }}),

aux_attributes AS (SELECT * FROM {{ ref('dim_auxillary_attributes') }}),

date AS (SELECT * FROM {{ ref('dim_date') }})

SELECT
    job_description.headline,
    fct_job_ads.vacancies,
    job_details.salary_type,
    fct_job_ads.relevance,
    employer.employer_name,
    employer.workplace_city,
    job_details.description,
    job_details.description_html_formatted,
    job_details.duration,
    job_details.scope_of_work_min,
    job_details.scope_of_work_max,
    fct_job_ads.application_deadline,
    aux_attributes.experience_required,
    aux_attributes.driver_license,
    date.application_deadline,
    date.publication_date
FROM fct_job_ads
LEFT JOIN job_details
    ON fct_job_ads.job_details_key = job_details.job_details_id
LEFT JOIN employer
    ON fct_job_ads.employer_key = employer.employer_id
LEFT JOIN aux_attributes
    ON fct_job_ads.aux_key = aux_attributes.aux_id
LEFT JOIN date
    ON fct_job_ads.date_key = date.date_id