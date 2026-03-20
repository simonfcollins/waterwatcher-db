DO $$
DECLARE
    maintenance_user_exists boolean;
    cron_job_exists boolean;
    msg text := E'\n============================================================\n';
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM pg_roles r
        JOIN pg_auth_members m ON r.oid = m.roleid
        JOIN pg_roles u ON m.member = u.oid
        WHERE r.rolname = 'maintenance'
          AND u.rolcanlogin = true
    )
    INTO maintenance_user_exists;

    IF NOT maintenance_user_exists THEN
        msg := msg || E'⚠️  No login user exists with the maintenance role.\n\n';
        msg := msg || E'Create one with the following SQL:\n\n';
        msg := msg || E'CREATE USER <username> LOGIN PASSWORD ''<secure-password>'';\n';
        msg := msg || E'GRANT maintenance TO <username>;\n\n';
    END IF;

    -- Make sure pg_cron extension exists before checking cron.job
    IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
        SELECT EXISTS (
            SELECT 1
            FROM cron.job
            WHERE jobname = 'daily_cleanup'
        )
        INTO cron_job_exists;

        IF NOT cron_job_exists THEN
            msg := msg || E'⚠️  Missing pg_cron job: daily_cleanup\n\n';
            msg := msg || E'Create it as a maintenance user with:\n\n';
            msg := msg || E'SELECT cron.schedule(\n';
            msg := msg || E'  ''daily_cleanup'',\n';
            msg := msg || E'  ''0 2 * * *'',\n';
            msg := msg || E'  ''DELETE FROM instant_values WHERE time_utc < now() - INTERVAL ''1 year'';''\n';
            msg := msg || E');\n\n';
        END IF;
    ELSE
        msg := msg || E'⚠️  pg_cron extension is not installed.\n';
        msg := msg || E'Install it with: CREATE EXTENSION pg_cron;\n\n';
    END IF;

    IF NOT maintenance_user_exists OR NOT cron_job_exists OR NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
        msg := msg || E'============================================================\n';
        RAISE WARNING '%', msg;
    END IF;

END;
$$;
