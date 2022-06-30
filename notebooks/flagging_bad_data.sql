-- Databricks notebook source
-- MAGIC %python
-- MAGIC # Set autoMerge to true
-- MAGIC spark.conf.set('spark.databricks.delta.schema.autoMerge.enabled', True)

-- COMMAND ----------

CREATE OR REPLACE TABLE sales_order_details (
    business_entity_id STRING NOT NULL,
    sales_order_id INT NOT NULL,
    sales_order_detail_id INT NOT NULL,
    order_qty INT NOT NULL,
    product_id STRING NOT NULL,
    unit_price FLOAT NOT NULL,
    unit_price_discount INT,
    line_total FLOAT NOT NULL,
    carrier_tracking_number INT,
    modified_date DATE,
    source_file STRING,
    negative_unit_price STRING GENERATED ALWAYS AS (
        CASE WHEN unit_price < 0 THEN 'Y' ELSE NULL END
    ),
    zero_order_qty STRING GENERATED ALWAYS AS (
        CASE WHEN order_qty = 0 THEN 'Y' ELSE NULL END
    )
) USING DELTA;

-- COMMAND ----------

MERGE INTO sales_order_details as a
    USING raw_sales_order_details as b
    ON a.sales_order_id = b.sales_order_id
    WHEN NOT MATCHED THEN INSERT *;

-- COMMAND ----------

SELECT * 
FROM sales_order_details
ORDER BY negative_unit_price DESC
