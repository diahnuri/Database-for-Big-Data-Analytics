-- 02_import.sql (SQLite) - run via sqlite3 CLI
.mode csv
.import data/towers.csv towers
.import data/subscribers.csv subscribers
.import data/cdr_events.csv cdr_events
.import data/tourism_events.csv tourism_events

CREATE INDEX IF NOT EXISTS idx_cdr_subscriber ON cdr_events(subscriber_id);
CREATE INDEX IF NOT EXISTS idx_cdr_tower ON cdr_events(tower_id);
CREATE INDEX IF NOT EXISTS idx_cdr_ts ON cdr_events(event_ts);
CREATE INDEX IF NOT EXISTS idx_towers_regency ON towers(regency);
CREATE INDEX IF NOT EXISTS idx_subs_home_regency ON subscribers(home_regency);
