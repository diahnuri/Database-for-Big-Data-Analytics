-- 07_tourism_derived.sql (PostgreSQL)
SET search_path = mpd, public;

-- Create a derived table: daily unique active subscribers by regency
DROP TABLE IF EXISTS daily_active_subs;
CREATE TABLE daily_active_subs AS
SELECT t.regency, DATE(c.event_ts) AS d, COUNT(DISTINCT c.subscriber_id) AS dau
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY t.regency, DATE(c.event_ts);

CREATE INDEX IF NOT EXISTS idx_das_reg_d ON daily_active_subs(regency, d);

-- Join with events to see lift during event days
SELECT e.event_name, e.regency, e.start_date, e.end_date,
       d.d, d.dau
FROM tourism_events e
JOIN daily_active_subs d ON d.regency = e.regency
WHERE d.d BETWEEN e.start_date - INTERVAL '3 day' AND e.end_date + INTERVAL '3 day'
ORDER BY e.event_name, d.d;
