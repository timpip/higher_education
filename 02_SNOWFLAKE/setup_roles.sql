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



GRANT CREATE VIEW ON SCHEMA he_db.mart TO ROLE he_dbt_role;
GRANT CREATE VIEW ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT CREATE VIEW ON SCHEMA he_db.stagin TO ROLE he_dbt_role;


GRANT USAGE ON ALL SCHEMAS IN DATABASE he_db TO ROLE he_dlt_role;
GRANT USAGE ON ALL SCHEMAS IN DATABASE he_db TO ROLE he_dbt_role;
GRANT USAGE ON ALL SCHEMAS IN DATABASE he_db TO ROLE he_analyst_role;



GRANT SELECT ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;

GRANT SELECT ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT SELECT ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT SELECT ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.mart TO ROLE he_dbt_role;

GRANT SELECT ON ALL VIEWS IN SCHEMA he_db.mart TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA he_db.mart TO ROLE he_dbt_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;

GRANT SELECT ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT SELECT ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;


GRANT SELECT ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;

GRANT SELECT ON ALL VIEWS IN SCHEMA he_db.mart TO ROLE he_analyst_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA he_db.mart TO ROLE he_analyst_role;


GRANT INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;
GRANT INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA he_db.staging TO ROLE he_dlt_role;

GRANT CREATE TABLE ON SCHEMA he_db.staging TO ROLE he_dlt_role;

GRANT CREATE VIEW ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;

GRANT INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT CREATE TABLE ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_dbt_role;
GRANT INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA he_db.mart TO ROLE he_dbt_role;
GRANT CREATE TABLE ON SCHEMA he_db.mart TO ROLE he_dbt_role;



-- GRANT INSERT,
-- UPDATE,
-- DELETE ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;
-- GRANT INSERT,
-- UPDATE,
-- DELETE ON FUTURE TABLES IN SCHEMA he_db.mart TO ROLE he_analyst_role;
-- GRANT CREATE TABLE ON SCHEMA he_db.mart TO ROLE he_analyst_role;


GRANT ROLE he_dlt_role TO ROLE he_dbt_role;

GRANT ROLE he_dlt_role TO USER viji_p;
GRANT ROLE he_dbt_role TO USER ali_b;
GRANT ROLE he_analyst_role TO USER wuttichai_c;


GRANT ROLE he_dlt_role TO USER tim_t;
GRANT ROLE he_dbt_role TO USER tim_t;
GRANT ROLE he_analyst_role TO USER tim_t;

GRANT ROLE he_dlt_role TO USER timpip;
GRANT ROLE he_dbt_role TO USER timpip;
GRANT ROLE he_analyst_role TO USER timpip;


SELECT CURRENT_ROLE();

SHOW GRANTS ON DATABASE HE_DB;

GRANT SELECT ON ALL TABLES IN SCHEMA HE_DB.mart TO ROLE he_dbt_role;
GRANT SELECT ON ALL TABLES IN SCHEMA HE_DB.warehouse TO ROLE he_dbt_role;

SHOW GRANTS TO ROLE he_dbt_role;


USE ROLE SYSADMIN;

GRANT MODIFY ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT MODIFY ON SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT MODIFY ON SCHEMA he_db.mart TO ROLE he_dbt_role;



-- GRANT OWNERSHIP ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;

USE ROLE SECURITYADMIN;
-----------------------------------------------------------------------------------------------------

-- Grant usage on the database and schema
GRANT USAGE ON DATABASE he_db TO ROLE he_dbt_role;
GRANT USAGE ON SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT USAGE ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT USAGE ON SCHEMA he_db.mart TO ROLE he_dbt_role;

-- Grant privileges to create and modify objects in the schema
GRANT MODIFY ON SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT MODIFY ON SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT MODIFY ON SCHEMA he_db.mart TO ROLE he_dbt_role;

-- Grant privileges to perform DML (insert, update, delete) on tables
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_dbt_role;

-- Grant truncate privilege if needed
GRANT TRUNCATE ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dbt_role;
GRANT TRUNCATE ON ALL TABLES IN SCHEMA he_db.warehouse TO ROLE he_dbt_role;
GRANT TRUNCATE ON ALL TABLES IN SCHEMA he_db.mart TO ROLE he_dbt_role;

-- Grant usage on the warehouse
GRANT USAGE ON WAREHOUSE he_wh TO ROLE he_dbt_role;

-- Optional: Allow the role to suspend or resume the warehouse
GRANT OPERATE ON WAREHOUSE he_wh TO ROLE he_dbt_role;

GRANT SELECT ON ALL TABLES IN SCHEMA he_db.staging TO ROLE he_dbt_role;

