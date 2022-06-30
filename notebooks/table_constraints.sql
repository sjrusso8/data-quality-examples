-- Databricks notebook source
-- Create a table with two constraints
CREATE TABLE sales_order_details (
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
    source_file STRING
) USING DELTA;

ALTER TABLE sales_order_details 
    ADD CONSTRAINT negative_unit_price CHECK (unit_price > 0);
ALTER TABLE sales_order_details 
    ADD CONSTRAINT zero_order_qty CHECK (order_qty <> 0);

-- COMMAND ----------

/*  Insert only merge based on the sales_order_id

This ends with an error and 0 of the records in the raw_sales_order_details are loaded
*/
MERGE INTO sales_order_details as a
    USING raw_sales_order_details as b
    ON a.sales_order_id = b.sales_order_id
    WHEN NOT MATCHED THEN INSERT *;
