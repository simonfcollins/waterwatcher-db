#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
  ALTER ROLE $POSTGRES_USER SET search_path = production, extensions, public;
EOSQL