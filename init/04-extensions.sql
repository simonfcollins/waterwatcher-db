BEGIN;

-- Extension: pg_cron

CREATE EXTENSION IF NOT EXISTS pg_cron
    SCHEMA pg_catalog;

-- Extension: plpgsql

CREATE EXTENSION IF NOT EXISTS plpgsql
    SCHEMA pg_catalog;

-- Extension: postgis

CREATE EXTENSION IF NOT EXISTS postgis
    SCHEMA extensions;

COMMIT;