USE ROLE he_dlt_role;

USE DATABASE he_db;

SHOW SCHEMAS;

SHOW TABLES IN SCHEMA staging;

DESC TABLE staging.data_field_job_ads;

USE WAREHOUSE he_wh;

SELECT
    headline,
    employer__workplace
FROM staging.data_field_job_ads;

SELECT * FROM staging.data_field_job_ads;