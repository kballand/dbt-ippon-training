{{ config(materialized = "table") }}

WITH first_row AS (
    SELECT
        identifier,
        restaurant_identifier,
        payment_method,
        amount,
        created_at,
        ROW_NUMBER() OVER (PARTITION BY identifier ORDER BY created_at DESC) AS row_nb
    FROM {{ mockable_source('orders') }}
)
SELECT
    identifier,
    restaurant_identifier,
    payment_method,
    amount,
    created_at
FROM first_row
WHERE row_nb = 1