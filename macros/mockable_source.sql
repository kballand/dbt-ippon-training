{% macro mockable_source(table_name) %}
    {% if target.name == 'ci' %}
        {% set table_name = 'sample_' + table_name %}
        {{ ref(table_name) }}
    {% else %}
        {{ source('snowflake', table_name) }}
    {% endif %}
{% endmacro %}