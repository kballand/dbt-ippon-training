SELECT
    identifier,
    name,
    address,
    nb_employees,
    open_on_sunday::boolean
FROM {{ source('snowflake', 'restaurants') }}