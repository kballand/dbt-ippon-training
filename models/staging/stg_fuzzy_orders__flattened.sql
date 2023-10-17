{{ config(materialized = "table") }}

WITH base AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY 1) AS order_id,
        *
    FROM {{ ref('base_fuzzy_orders') }}
)
SELECT
    b.order_id AS identifier,
    n.value::string AS dish_name,
    payment_method,
    amount,
    created_at
FROM
    base AS b,
    lateral flatten(input => b.dishes_names) AS n