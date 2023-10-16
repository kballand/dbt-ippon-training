SELECT
    *
FROM {{ ref('stg_restaurants__turnover') }}
ORDER BY turnover DESC