use role he_dlt_role;

select count(distinct id) from staging.data_field_job_ads;

select count(*) from staging.data_field_job_ads;

SHOW DATABASES;

USE DATABASE he_db;


USE SCHEMA he_db.mart;


select count(*) from mart_job_listings;