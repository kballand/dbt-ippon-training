{{ config(materialized = "incremental", unique_key="identifier") }}

SELECT
    identifier,
    restaurant_identifier,
    payment_method,
    amount,
    created_at
FROM {{ mockable_source('orders') }}
{% if is_incremental() %}
WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}