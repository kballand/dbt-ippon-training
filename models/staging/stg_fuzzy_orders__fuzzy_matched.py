import snowflake.snowpark.types as T
import snowflake.snowpark.functions as F
from fuzzywuzzy import process

def register_udf_get_closest_dish(existing_dishes, score_cutoff):
    get_closest_dish = F.udf(
        lambda x: process.extractOne(x, existing_dishes, score_cutoff=score_cutoff)[0],
        return_type=T.StringType(),
        input_types=[T.StringType()]
    )
    return get_closest_dish

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["fuzzywuzzy"]
    )

    base_dishes = dbt.ref("base_dishes")

    existing_dishes = base_dishes.select("NAME").distinct().toPandas()["NAME"].tolist()

    get_closest_dish = register_udf_get_closest_dish(existing_dishes=existing_dishes, score_cutoff=60)

    fuzzy_orders_flattened = dbt.ref("stg_fuzzy_orders__flattened")

    fuzzy_orders_matched = fuzzy_orders_flattened.withColumn("MATCHED_DISH_NAME", get_closest_dish("DISH_NAME"))

    return fuzzy_orders_matched



    