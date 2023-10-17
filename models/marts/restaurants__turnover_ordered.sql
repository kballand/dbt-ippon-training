SELECT
    restaurant_identifier,
    restaurant_name,
    turnover
FROM {{ ref('stg_restaurants__turnover') }}
ORDER BY turnover DESC