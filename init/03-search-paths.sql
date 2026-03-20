BEGIN;

ALTER DATABASE waterwatcher SET search_path = production, extensions;
ALTER ROLE app_admin SET search_path = production, extensions, public;

COMMIT;