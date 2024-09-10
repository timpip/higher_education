WITH employer AS (SELECT * FROM {{ ref('employer') }})

SELECT
    {{ dbt_utils.generate_surrogate_key(['id', 'employer_name']) }} AS employer_id, -- noqa
    employer_name,
    {{ capitalize_first_letter("coalesce(workplace_city, 'stad ej specificerat')") }} AS workplace_city -- noqa: TMP
    {# TODO: finish this dimensional model #} -- noqa
FROM employer