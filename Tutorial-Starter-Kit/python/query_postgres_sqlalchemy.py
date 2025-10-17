# python/query_postgres_sqlalchemy.py
# Usage: set DATABASE_URL env var, e.g.:
#   export DATABASE_URL='postgresql+psycopg2://user:password@localhost:5432/mpd'
# Then:  python query_postgres_sqlalchemy.py

import os
import pandas as pd
from sqlalchemy import create_engine

db_url = os.getenv("DATABASE_URL", "postgresql+psycopg2://user:password@localhost:5432/mpd")
engine = create_engine(db_url)

# Example: events by regency and day
q = '''
SET search_path = mpd, public;
SELECT t.regency, DATE(c.event_ts) AS d, COUNT(*) AS n
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY t.regency, DATE(c.event_ts)
ORDER BY t.regency, d;
'''
with engine.connect() as conn:
    conn.execute("SET search_path = mpd, public;")
    df = pd.read_sql(q, conn)
print(df.head())

# Save to CSV
df.to_csv("events_by_regency_day.csv", index=False)
print("Saved: events_by_regency_day.csv")
