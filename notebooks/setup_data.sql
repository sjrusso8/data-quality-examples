-- Databricks notebook source
CREATE TABLE IF NOT EXISTS raw_sales_order_details (
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
    load_date DATE
) USING DELTA;

INSERT INTO raw_sales_order_details VALUES
('A001',10001,1000011,1000,'AA001',8,0,8000,123456,NULL,'poc_data_example_1.csv'),
('A001',10002,1000012,40,'AB720',10,0,400,123456,NULL,'poc_data_example_1.csv'),
('B001',10003,1000013,35,'AC870',15.75,0,551.25,412315,NULL,'poc_data_example_1.csv'),
('C001',10004,1000014,25,'AD050',100.25,0,2506.25,412315,NULL,'poc_data_example_1.csv'),
('C001',10005,1000015,10,'DD815',15.1,0,151,412315,NULL,'poc_data_example_2.csv'),
('D001',10006,1000016,80,'EE320',-999,0,-79920,989201,NULL,'poc_data_example_2.csv'),
('E001',10007,1000017,0,'DE400',10.5,0,0,102910,NULL,'poc_data_example_2.csv'),
('F001',10008,1000018,12,'FE001',12.75,0,153,702931,NULL,'poc_data_example_3.csv');

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sales_order_details_quarantine (
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
    load_date DATE
) USING DELTA;
