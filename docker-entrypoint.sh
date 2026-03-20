#!/bin/bash
set -e

# Run the official entrypoint in the foreground
exec /usr/local/bin/docker-entrypoint.sh "$@" &

POSTGRES_PID=$!


# Wait for the *final* server to accept connections
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  sleep 1
done

# Run non-fatal startup checks
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" \
  -f /startup/startup_check.sql || true

# Reattach to Postgres
wait "$POSTGRES_PID"
