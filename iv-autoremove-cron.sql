BEGIN;

SELECT cron.schedule(
	'daily_cleanup',
	'0 2 * * *',
	'DELETE FROM instant_values WHERE time_utc < now() - INTERVAL ''1 year'';'
);

COMMIT;