FROM postgres:16

RUN apt-get update && apt-get install -y postgresql-16-cron postgresql-16-postgis-3 && rm -rf /var/lib/apt/lists/*

COPY startup_check.sql /startup/startup_check.sql
COPY docker-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
COPY init/* /docker-entrypoint-initdb.d

RUN chmod +x /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /docker-entrypoint-initdb.d/*.sh || true

ENTRYPOINT ["custom-entrypoint.sh"]
