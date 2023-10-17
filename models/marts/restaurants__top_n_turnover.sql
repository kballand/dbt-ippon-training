SELECT
    restaurant_identifier,
    restaurant_name,
    turnover
FROM {{ ref('restaurants__turnover_ordered') }}
LIMIT {{ var('nb_restaurants_to_show') }}