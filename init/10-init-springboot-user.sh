#!/bin/bash
set -e

SPRINGBOOT_PASSWORD=$(cat /run/secrets/springboot_db_password)

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
DO
\$\$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles WHERE rolname = 'springboot'
   ) THEN
      CREATE USER springboot WITH PASSWORD '$SPRINGBOOT_PASSWORD';
   END IF;
END
\$\$;

GRANT application TO springboot;
EOSQL
