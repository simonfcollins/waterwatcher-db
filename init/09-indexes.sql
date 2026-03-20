BEGIN;

-- Add index of site_numbers on usgs_sites
CREATE INDEX idx_usgs_sites_site_number
    ON production.usgs_sites(site_number);

-- Add index for data_series on site
CREATE INDEX idx_data_series_usgs_site
    ON production.data_series(site);

-- Composite index for most common lookup
CREATE INDEX idx_data_series_site_param
    ON production.data_series(site, param_cd);

-- Add index for instant_values on data_series
CREATE INDEX idx_instant_values_data_series
    ON production.instant_values(data_series);

-- Composite index for querying instant_values by data_series and time_utc
CREATE INDEX idx_instant_values_data_series_time
    ON production.instant_values(data_series, time_utc);

-- Index of geometries on sites
CREATE INDEX idx_sites_geometry
    ON production.sites
    USING GIST (geometry);
    
COMMIT;