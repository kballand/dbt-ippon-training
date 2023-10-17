{{
    config(
        post_hook=[
            unload_to_s3(this, 'kballand/%s' % dbt_utils.get_column_values(this, 'month')[0])
        ]
    )
}}

SELECT
    restaurant_identifier,
    restaurant_name,
    turnover,
    month
FROM {{ ref('stg_restaurants__monthly_turnover') }}
WHERE month = (SELECT MAX(month) FROM {{ ref('stg_restaurants__monthly_turnover') }})
ORDER BY turnover DESC