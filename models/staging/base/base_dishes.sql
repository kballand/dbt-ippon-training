{{ config(materialized = "table") }}

SELECT
    identifier,
    name,
    selling_price,
    production_cost,
    type
FROM {{ source('snowflake', 'dishes') }}