SELECT
    r.identifier AS restaurant_identifier,
    r.name AS restaurant_name,
    SUM(o.amount) AS turnover
FROM {{ ref('base_orders') }} AS o
INNER JOIN {{ ref('base_restaurants') }} AS r ON o.restaurant_identifier = r.identifier
GROUP BY r.identifier, r.name