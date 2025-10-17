-- 01_schema.sql (PostgreSQL)
CREATE SCHEMA IF NOT EXISTS mpd;
SET search_path = mpd, public;

DROP TABLE IF EXISTS cdr_events CASCADE;
DROP TABLE IF EXISTS subscribers CASCADE;
DROP TABLE IF EXISTS towers CASCADE;
DROP TABLE IF EXISTS tourism_events CASCADE;

CREATE TABLE towers (
    tower_id     INT PRIMARY KEY,
    regency      TEXT NOT NULL,
    latitude     NUMERIC(9,6),
    longitude    NUMERIC(9,6)
);

CREATE TABLE subscribers (
    subscriber_id INT PRIMARY KEY,
    home_regency  TEXT NOT NULL,
    home_tower_id INT NOT NULL REFERENCES towers(tower_id),
    sim_type      TEXT CHECK (sim_type IN ('prepaid','postpaid'))
);

CREATE TABLE cdr_events (
    event_id      BIGINT PRIMARY KEY,
    subscriber_id INT NOT NULL REFERENCES subscribers(subscriber_id),
    tower_id      INT NOT NULL REFERENCES towers(tower_id),
    event_type    TEXT CHECK (event_type IN ('call','sms','data')),
    event_ts      TIMESTAMP NOT NULL
);

CREATE TABLE tourism_events (
    event_id     INT PRIMARY KEY,
    event_name   TEXT NOT NULL,
    regency      TEXT NOT NULL,
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL
);
