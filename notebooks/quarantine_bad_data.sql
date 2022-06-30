-- Databricks notebook source
CREATE OR REPLACE TEMPORARY VIEW new_sales_order_details AS 
SELECT *
FROM raw_sales_order_details
WHERE unit_price > 0 OR order_qty <> 0;

-- COMMAND ----------

MERGE INTO sales_order_details as a
    USING new_sales_order_details as b
    ON a.sales_order_id = b.sales_order_id
    WHEN NOT MATCHED THEN INSERT *;

-- COMMAND ----------

INSERT INTO sales_order_details_quarantine 
    SELECT 
      *, 
      current_date() as `load_date`
    FROM raw_sales_order_details
    WHERE 
        ( unit_price < 0 OR order_qty = 0 );
