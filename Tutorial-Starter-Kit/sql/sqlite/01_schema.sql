-- 01_schema.sql (SQLite)
DROP TABLE IF EXISTS cdr_events;
DROP TABLE IF EXISTS subscribers;
DROP TABLE IF EXISTS towers;
DROP TABLE IF EXISTS tourism_events;

CREATE TABLE towers (
    tower_id     INTEGER PRIMARY KEY,
    regency      TEXT NOT NULL,
    latitude     REAL,
    longitude    REAL
);

CREATE TABLE subscribers (
    subscriber_id INTEGER PRIMARY KEY,
    home_regency  TEXT NOT NULL,
    home_tower_id INTEGER NOT NULL,
    sim_type      TEXT CHECK (sim_type IN ('prepaid','postpaid'))
);

CREATE TABLE cdr_events (
    event_id      INTEGER PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    tower_id      INTEGER NOT NULL,
    event_type    TEXT CHECK (event_type IN ('call','sms','data')),
    event_ts      TEXT NOT NULL
);

CREATE TABLE tourism_events (
    event_id     INTEGER PRIMARY KEY,
    event_name   TEXT NOT NULL,
    regency      TEXT NOT NULL,
    start_date   TEXT NOT NULL,
    end_date     TEXT NOT NULL
);
