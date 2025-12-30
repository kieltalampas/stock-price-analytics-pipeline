CREATE DATABASE IF NOT EXISTS STOCK_ANALYTICS;
CREATE SCHEMA IF NOT EXISTS STOCK_ANALYTICS.GOLD;

USE DATABASE STOCK_ANALYTICS;
USE SCHEMA GOLD;


CREATE OR REPLACE FILE FORMAT stock_csv_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
NULL_IF = ('NULL', 'null', '');

-- Dimension Table --

CREATE OR REPLACE STAGE stock_dim_stage
FILE_FORMAT = stock_csv_format;

LIST @stock_dim_stage;

CREATE OR REPLACE TABLE dim_stock (
    ticker STRING,
    brand_name STRING,
    industry_tag STRING,
    country STRING
)

COPY INTO dim_stock
FROM @stock_dim_stage
FILE_FORMAT = stock_csv_format

SELECT *
FROM DIM_STOCK;

-- Fact Table --

CREATE OR REPLACE STAGE stock_gold_stage
FILE_FORMAT = stock_csv_format;

LIST @stock_gold_stage;

CREATE OR REPLACE TABLE fact_stock_price_gold (
    ticker STRING,
    trade_year INT,
    avg_close_price DOUBLE,
    avg_volume DOUBLE
)

COPY INTO fact_stock_price_gold
FROM @stock_gold_stage
FILE_FORMAT = stock_csv_format

SELECT *
FROM FACT_STOCK_PRICE_GOLD;



