BEGIN;

-- View: production.sites_usgs_sites

CREATE OR REPLACE VIEW production.sites_usgs_sites AS
SELECT s.site_id AS id,
       s.name,
       s.agency,
       s.geometry,
       u.site_number,
       u.network,
       u.type,
       u.time_zone,
       u.time_zone_uses_dst,
       u.site_uses_dst,
       u.dst_offset
FROM production.sites s
JOIN production.usgs_sites u ON s.site_id = u.site_id;


ALTER TABLE production.sites_usgs_sites OWNER TO app_admin;

COMMIT;