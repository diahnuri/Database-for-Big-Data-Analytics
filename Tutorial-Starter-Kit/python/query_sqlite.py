# python/query_sqlite.py
# Usage:
#   python query_sqlite.py

import sqlite3
import pandas as pd

con = sqlite3.connect("mpd.db")
q = '''
SELECT t.regency, substr(c.event_ts, 1, 10) AS d, COUNT(*) AS n
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY t.regency, substr(c.event_ts, 1, 10)
ORDER BY t.regency, d;
'''
df = pd.read_sql_query(q, con)
print(df.head())
df.to_csv("events_by_regency_day_sqlite.csv", index=False)
print("Saved: events_by_regency_day_sqlite.csv")
