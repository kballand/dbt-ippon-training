SELECT
    dishes_names,
    payment_method,
    amount,
    created_at
FROM {{ source('snowflake', 'fuzzy_orders') }}