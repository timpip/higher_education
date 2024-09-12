WITH employer AS (SELECT * FROM {{ ref('src_employer') }})

SELECT
    {{ dbt_utils.generate_surrogate_key(['id', 'employer_name']) }} AS employer_id, 
    employer_name,
    {{ capitalize_first_letter("coalesce(workplace_city, 'stad ej specificerat')") }} AS workplace_city, -- noqa: TMP
    employer_organization_number,
    workplace_street_adress,
    workplace_region,
    workplace_region_code AS workplace_postcode,
    workplace_country AS country
FROM employer