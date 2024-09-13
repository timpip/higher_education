USE ROLE ACCOUNTADMIN;

CREATE ROLE IF NOT EXISTS he_dlt_role COMMENT = 'Able to ingest to he_db';
CREATE ROLE IF NOT EXISTS he_dbt_role COMMENT = 'Able to work with dbt';
CREATE ROLE IF NOT EXISTS he_analyst_role COMMENT = 'Able to analyze data';

USE ROLE SECURITYADMIN;

GRANT USAGE ON WAREHOUSE he_wh TO ROLE he_dlt_role;
GRANT USAGE ON WAREHOUSE he_wh TO ROLE he_dbt_role;
GRANT USAGE ON WAREHOUSE he_wh TO ROLE he_analyst_role;


GRANT USAGE ON DATABASE he_db TO ROLE he_dlt_role;
GRANT USAGE ON DATABASE he_db TO ROLE he_dbt_role;
GRANT USAGE ON DATABASE he_db TO ROLE he_analyst_role;



GRANT USAGE ON ALL SCHEMAS IN DATABASE he_db TO ROLE he_dlt_role;
GRANT USAGE ON ALL SCHEMAS IN DATABASE he_db TO ROLE he_dbt_role;
GRANT USAGE ON ALL SCHEMAS IN DATABASE he_db TO ROLE he_analyst_role;



GRANT SELECT ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;


GRANT SELECT ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;


GRANT SELECT ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;


GRANT INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;
GRANT INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;

GRANT CREATE TABLE ON SCHEMA he_db.staging TO ROLE he_dlt_role;



GRANT INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT CREATE TABLE ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;


GRANT INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;
GRANT INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;
GRANT CREATE TABLE ON SCHEMA he_db.mart TO ROLE he_analyst_role;




GRANT ROLE he_dlt_role TO USER viji_p;
GRANT ROLE he_dbt_role TO USER ali_b;
GRANT ROLE he_analyst_role TO USER wuttichai_c;


GRANT ROLE he_dlt_role TO USER tim_t;
GRANT ROLE he_dbt_role TO USER tim_t;
GRANT ROLE he_analyst_role TO USER tim_t;

GRANT ROLE he_dlt_role TO USER timpip;
GRANT ROLE he_dbt_role TO USER timpip;
GRANT ROLE he_analyst_role TO USER timpip;

USE ROLE he_dlt_role;

