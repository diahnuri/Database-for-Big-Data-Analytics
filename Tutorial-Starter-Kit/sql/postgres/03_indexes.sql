-- 03_indexes.sql (PostgreSQL)
SET search_path = mpd, public;

CREATE INDEX IF NOT EXISTS idx_cdr_subscriber ON cdr_events(subscriber_id);
CREATE INDEX IF NOT EXISTS idx_cdr_tower ON cdr_events(tower_id);
CREATE INDEX IF NOT EXISTS idx_cdr_ts ON cdr_events(event_ts);
CREATE INDEX IF NOT EXISTS idx_towers_regency ON towers(regency);
CREATE INDEX IF NOT EXISTS idx_subs_home_regency ON subscribers(home_regency);
