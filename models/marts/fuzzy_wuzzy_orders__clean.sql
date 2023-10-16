SELECT
    identifier,
    matched_dish_name AS dish_name,
    payment_method,
    amount,
    created_at
FROM {{ ref('stg_fuzzy_orders__fuzzy_matched') }}