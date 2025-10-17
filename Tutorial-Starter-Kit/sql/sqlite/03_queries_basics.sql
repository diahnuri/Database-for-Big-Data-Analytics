-- 03_queries_basics.sql (SQLite)
-- Counts
SELECT COUNT(*) AS n_subscribers FROM subscribers;
SELECT COUNT(*) AS n_towers FROM towers;
SELECT COUNT(*) AS n_events FROM cdr_events;

-- Recent events
SELECT * FROM cdr_events ORDER BY event_ts DESC LIMIT 10;

-- Aggregation by type
SELECT event_type, COUNT(*) AS n
FROM cdr_events
GROUP BY event_type
ORDER BY n DESC;

-- Top 5 busiest towers
SELECT c.tower_id, t.regency, COUNT(*) AS n
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY c.tower_id, t.regency
ORDER BY n DESC
LIMIT 5;

-- Events by regency and day
SELECT t.regency, substr(event_ts, 1, 10) AS d, COUNT(*) AS n
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY t.regency, substr(event_ts, 1, 10)
ORDER BY t.regency, d;
