INSERT INTO subscribers (subscriber_id, home_regency, home_tower_id, sim_type)
	VALUES (301, 'Denpasar', 12, 'prepaid');

INSERT INTO (tower_id,regency,latitude,longitude)
VALUES 
	(1,Badung,-8.219533,114.970542),
	(2,Badung,-8.156052,115.306578),
	(3,Badung,-8.729367,115.668309),
	(4,Badung,-8.229145,115.421884),
	(5,Bangli,-8.703915,114.985502),
	(6,Bangli,-8.521901,115.604794);


COPY subscribers(subscriber_id, home_regency, home_tower_id, sim_type)
FROM '/path/to/subscribers.csv'
DELIMITER ','
CSV HEADER;