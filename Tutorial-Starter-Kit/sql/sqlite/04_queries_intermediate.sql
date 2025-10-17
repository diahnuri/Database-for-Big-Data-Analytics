-- 04_queries_intermediate.sql (SQLite)
-- Join subscribers with events
SELECT s.home_regency, COUNT(*) AS n_events
FROM cdr_events c
JOIN subscribers s ON s.subscriber_id = c.subscriber_id
GROUP BY s.home_regency
ORDER BY n_events DESC;

-- Top towers by regency (use window workaround via correlated subquery)
WITH counts AS (
  SELECT t.regency AS regency, c.tower_id AS tower_id, COUNT(*) AS n
  FROM cdr_events c
  JOIN towers t ON t.tower_id = c.tower_id
  GROUP BY t.regency, c.tower_id
),
ranked AS (
  SELECT c1.*,
         (SELECT COUNT(*) + 1 FROM counts c2 WHERE c2.regency=c1.regency AND c2.n > c1.n) AS rnk
  FROM counts c1
)
SELECT regency, tower_id, n
FROM ranked
WHERE rnk = 1;

-- Subscribers active during "Ubud Arts Fair"
SELECT DISTINCT c.subscriber_id
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
JOIN tourism_events e ON e.regency = t.regency
WHERE e.event_name = 'Ubud Arts Fair'
  AND date(substr(c.event_ts,1,10)) BETWEEN date(e.start_date) AND date(e.end_date)
ORDER BY c.subscriber_id
LIMIT 20;

-- Travel detection: events outside home_regency
SELECT s.subscriber_id,
       SUM(CASE WHEN t.regency <> s.home_regency THEN 1 ELSE 0 END) AS events_outside_home,
       COUNT(*) AS total_events
FROM cdr_events c
JOIN subscribers s ON s.subscriber_id = c.subscriber_id
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY s.subscriber_id
ORDER BY events_outside_home DESC
LIMIT 20;
