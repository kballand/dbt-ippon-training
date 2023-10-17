SELECT
    identifier,
    name,
    address,
    nb_employees,
    open_on_sunday::boolean as open_on_sunday
FROM {{ mockable_source('restaurants') }}