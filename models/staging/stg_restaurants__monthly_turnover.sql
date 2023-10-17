{{ config(materialized='table') }}

WITH orders_with_month AS (
    SELECT
        restaurant_identifier,
        amount,
        CONCAT(LPAD(DATE_PART('year', created_at::DATETIME), 4, '0'), '-', LPAD(DATE_PART('month', created_at::DATETIME), 2, '0')) AS month  
    FROM {{ ref('base_orders') }}
)
SELECT
    r.identifier AS restaurant_identifier,
    r.name AS restaurant_name,
    SUM(o.amount) AS turnover,
    o.month
FROM orders_with_month AS o
INNER JOIN {{ ref('base_restaurants') }} AS r ON o.restaurant_identifier = r.identifier
GROUP BY r.identifier, r.name, o.month