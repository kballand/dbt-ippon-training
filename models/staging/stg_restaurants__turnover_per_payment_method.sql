{% set payment_methods = dbt_utils.get_column_values(ref('base_orders'), 'payment_method') %}

SELECT
    r.identifier AS restaurant_identifier,
    r.name AS restaurant_name,
    {% for payment_method in payment_methods %}
    SUM(CASE WHEN o.payment_method = '{{payment_method}}' THEN o.amount ELSE 0 END) AS {{payment_method}}_turnover{{ "," if not loop.last }}
    {% endfor %}
FROM {{ ref('base_orders') }} AS o
INNER JOIN {{ ref('base_restaurants') }} AS r ON o.restaurant_identifier = r.identifier
GROUP BY r.identifier, r.name