# Databases for Big Data Analytics – Tutorial
This repository contains tutorials how to store, manage, manipulate data into database with SQL and No SQL technologies. 
The tutorial is equipped by data samples and hands-on instructions that can be applied directly to RDBMS (PostgreSQL) and NoSQL (MongoDB).
The tutorial also includes synthetic MPD-style datasets and ready-to-run scripts.
Happy learning ^_^

## Data
- `data/towers.csv` — cell towers with location & regency (Bali)
- `data/subscribers.csv` — subscribers with home_regency, home_tower
- `data/cdr_events.csv` — CDR-like events (call/sms/data) from 2025-09-01 to 2025-09-25
- `data/tourism_events.csv` — example tourism events

All data are synthetic and safe for classroom use.

## Option A — PostgreSQL (recommended)
1. Create DB and load schema:
   ```bash
   createdb mpd
   psql -d mpd -f sql/postgres/01_schema.sql
   ```
2. From inside the project folder (so relative paths work), load data using psql `\copy`:
   ```bash
   psql -d mpd -f sql/postgres/02_load_data.sql
   psql -d mpd -f sql/postgres/03_indexes.sql
   ```
3. Run exercises:
   ```bash
   psql -d mpd -f sql/postgres/04_queries_basics.sql
   psql -d mpd -f sql/postgres/05_queries_intermediate.sql
   psql -d mpd -f sql/postgres/06_window_functions.sql
   psql -d mpd -f sql/postgres/07_tourism_derived.sql
   ```

## Option B — SQLite (zero-setup)
1. Create DB and schema:
   ```bash
   sqlite3 mpd.db < sql/sqlite/01_schema.sql
   ```
2. Import data & create indexes (must run via sqlite3 CLI due to `.import`):
   ```bash
   sqlite3 mpd.db < sql/sqlite/02_import.sql
   ```
3. Run exercises:
   ```bash
   sqlite3 mpd.db < sql/sqlite/03_queries_basics.sql
   sqlite3 mpd.db < sql/sqlite/04_queries_intermediate.sql
   sqlite3 mpd.db < sql/sqlite/05_window_functions.sql
   ```

## Option C — MongoDB (NoSQL taste)
- Import JSON Lines:
  ```bash
  mongoimport --db mpd --collection cdr_events --file mongo/cdr_events.jsonl --type json --jsonArray=false
  ```
- Try queries from `mongo/mongo_commands.js` (open in `mongosh`).

## Python Integration
- PostgreSQL with SQLAlchemy: `python/python/query_postgres_sqlalchemy.py` (set `DATABASE_URL` first).
- SQLite quick demo: `python/python/query_sqlite.py` (produces `events_by_regency_day_sqlite.csv`).

---

### **Session 1 — Setup & First Queries**
**Goals:** Ensure everyone can connect; understand tables; run basic queries.
- *Theory (quick):* relational DB concepts, tables, keys, indexes; MPD context.
- *Hands-on:*
  1. Create DB and load schema & data (Option A or B above).
  2. Run `04_queries_basics.sql` first 3 queries to verify row counts.
  3. Write your own:
     - Count events per `event_type` for a given date.
     - List 10 most recent events for any subscriber.
- *Deliverable:* screenshot of row counts and one custom query.

### **Session 2 — SQL for Analysis (GROUP BY, HAVING, JOIN)**
**Goals:** Comfort with filtering, grouping, and joining across tables.
- *Hands-on tasks:*
  1. Top-3 busiest towers **per regency** (adapt example in `05_queries_intermediate.sql`).
  2. For each regency-day, compute share of `data` vs total events.
  3. Find **subscribers** who were active in **two different regencies in the same day**.
- *Stretch:* Identify the **peak hour** per regency.

### **Session 3 — Subqueries & Window Functions**
**Goals:** Derive “usual environment” and moving averages.
- *Hands-on tasks:*
  1. Implement the **night-time usual tower** query and save results to a temp table.
  2. Compute a **3-day moving average** of daily unique active subscribers by regency (see `07_tourism_derived.sql` for DAU).
  3. Rank subscribers by fraction of events outside home_regency.
- *Stretch:* Find top-5 **itinerant** subscribers per regency (highest outside-home fraction).

### **Session 4 — NoSQL (MongoDB) for Semi-Structured Data**
**Goals:** Store and query nested/JSON-like data; pros/cons.
- *Hands-on tasks:*
  1. Import `mongo/cdr_events.jsonl`.
  2. Aggregation pipeline: events by `event_type`, top regencies by activity.
  3. Filter window: active subscribers during **Ubud Arts Fair**.
- *Stretch:* Design a document to store **trip segments** per subscriber.
---

## Expected Outcomes (rubric)
- **Beginner:** runs queries, explains joins and group-bys, exports a CSV.
- **Intermediate:** window functions, event-window analysis, simple movement heuristics.
- **Advanced (stretch):** performance tuning (indexes), compares SQL vs Spark/DuckDB, proposes schema improvements.

Good luck and have fun!

## Author
**Siti Mariyah, Ph.D.**
- _Lecturer @ Politeknik Statistika STIS_
- _Data Scientist @ Badan Pusat Statistik_


