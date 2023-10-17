{% macro unload_to_s3(table, prefix) %}
    {% if target.name == 'prod' %}
    {% set env_name = 'PROD' %}
    {% else %}
    {% set env_name = 'DEV' %}
    {% endif %}
    {% call statement('unload_data', fetch_result=true, auto_begin=true) %}
	COPY INTO @SOURCE.STAGE_DBT_KBALLAND_{{ env_name | upper }}/{{prefix}}/{{table}}.csv
    FROM {{table}}
    OVERWRITE = true
    HEADER = true
    SINGLE = true
    FILE_FORMAT = (TYPE = CSV, COMPRESSION = NONE)
    {% endcall %}
{% endmacro %}