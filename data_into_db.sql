-- Active: 1718854359158@@127.0.0.1@3306@brazil_ecom
DROP TABLE order_items_dataset;


CREATE TABLE order_items_dataset (
    `order_id` VARCHAR(512),
    `order_item_id` BIGINT,
    `product_id` VARCHAR(512),
    `seller_id` VARCHAR(512),
    `shipping_limit_date` DATETIME,
    `price` FLOAT(53),
    `freight_value` FLOAT(53)
);



SHOW variables like 'secure_file_priv';

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_order_items_dataset.csv'
INTO TABLE order_items_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from order_items_dataset;

create table customer_dataset (
    `customer_id` VARCHAR(64),
    `customer_unique_id` VARCHAR(64),
    `customer_zip_code_prefix` NUMERIC(8),
    `customer_city` VARCHAR(64),
    `customer_state` VARCHAR(4)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_customers_dataset.csv'
INTO TABLE customer_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from customer_dataset;

CREATE TABLE geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10, 8),
    geolocation_lng DECIMAL(11, 8),
    geolocation_city VARCHAR(255),
    geolocation_state CHAR(2)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_geolocation_dataset.csv'
INTO TABLE geolocation_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from geolocation_dataset;

drop table order_payments_data;

create table order_payments_data(
    `order_id` VARCHAR(32),
    `payment_sequential` int,
    `payment_type` varchar(16),
    `payment_installments` int,
    `payment_value` decimal(10,2)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_order_payments_dataset.csv'
INTO TABLE order_payments_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from order_payments_data;

CREATE TABLE orders_dataset (
    order_id VARCHAR(255),
    customer_id VARCHAR(255),
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME null ,
    order_delivered_carrier_date DATETIME null ,
    order_delivered_customer_date DATETIME null ,
    order_estimated_delivery_date DATETIME null
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_orders_dataset.csv'
INTO TABLE orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, order_status, order_purchase_timestamp, @order_approved_at, @order_delivered_carrier_date, @order_delivered_customer_date, @order_estimated_delivery_date)
SET
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

select * from orders_dataset;

CREATE TABLE product_dataset (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_products_dataset.csv'
INTO TABLE product_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, @product_category_name, @product_name_length, @product_description_length, @product_photos_qty, @product_weight_g, @product_length_cm, @product_height_cm, @product_width_cm)
SET
    product_category_name = NULLIF(@product_category_name, ''),
    product_name_length = NULLIF(@product_name_length, ''),
    product_description_length = NULLIF(@product_description_length, ''),
    product_photos_qty = NULLIF(@product_photos_qty, ''),
    product_weight_g = NULLIF(@product_weight_g, ''),
    product_length_cm = NULLIF(@product_length_cm, ''),
    product_height_cm = NULLIF(@product_height_cm, ''),
    product_width_cm = NULLIF(@product_width_cm, '');

create table sellers_dataset(
    seller_id varchar(225),
    seller_zip_code_prefix int,
    seller_city varchar(225),
    seller_state varchar(8)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\olist_sellers_dataset.csv'
INTO TABLE sellers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


# only product name catagory table left to insert into DB

create table product_catagory_name_translation(
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\brazil_dataset\\product_category_name_translation.csv'
INTO TABLE product_catagory_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;