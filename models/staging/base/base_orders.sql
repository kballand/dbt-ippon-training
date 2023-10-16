SELECT
    identifier,
    restaurant_identifier,
    payment_method,
    amount,
    created_at
FROM {{ source('snowflake', 'orders') }}