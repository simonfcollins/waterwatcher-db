BEGIN;

---------------------------------------- SCHEMA PERMS ----------------------------------------

GRANT USAGE ON SCHEMA extensions TO application;
GRANT USAGE ON SCHEMA production TO application;
GRANT USAGE ON SCHEMA extensions TO maintenance;
GRANT USAGE ON SCHEMA production TO maintenance;
GRANT USAGE ON SCHEMA cron TO maintenance;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

---------------------------------------- TABLE PERMS -----------------------------------------

--GRANT ALL ON TABLE production.sites_usgs_sites TO app_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA production GRANT SELECT, INSERT, UPDATE ON TABLES TO application;
ALTER DEFAULT PRIVILEGES IN SCHEMA production GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO application;
ALTER DEFAULT PRIVILEGES IN SCHEMA production GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO maintenance;
ALTER DEFAULT PRIVILEGES IN SCHEMA production GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO maintenance;
ALTER DEFAULT PRIVILEGES IN SCHEMA cron GRANT SELECT, UPDATE, INSERT, DELETE ON TABLES to maintenance;

COMMIT;
