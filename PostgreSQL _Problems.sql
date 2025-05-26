Active:1748032491760 @@ localhost @ 5432 @ conservation_db

CREATE DATABASE conservation_db;

-- Information to demonstrate the structure, format, and content of this tables

-- Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    region VARCHAR(60) NOT NULL
);

-- Species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(40) NOT NULL,
    scientific_name VARCHAR(60) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

-- Sightings Table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species (species_id) ON DELETE CASCADE,
    ranger_id INT REFERENCES rangers (ranger_id) ON DELETE CASCADE,
    location VARCHAR(250) NOT NULL,
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);

-- ---------------------------------------------------------------
-- Information to demonstrate the structure, format, and content of this data

-- Insert  to rangers data
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        1,
        'Alice Green',
        'Northern Hills'
    ),
    (2, 'Bob White', 'River Delta'),
    (
        3,
        'Carol King',
        'Mountain Range'
    );

-- Insert to Species data

INSERT INTO
    species (
        species_id,
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        1,
        'Snow Leopard',
        'Panthera uncia ',
        '1775-01-01',
        'Endangered'
    ),
    (
        2,
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        3,
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        4,
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- Insert to sightings data

INSERT INTO
    sightings (
        sighting_id,
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        1,
        'Peak Ridge ',
        '2024-05-10 07:45:00',
        'Camera trap image captured '
    ),
    (
        2,
        2,
        2,
        'Bankwood Area ',
        '2024-05-12 16:20:00 ',
        'Juvenile seen'
    ),
    (
        3,
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00 ',
        'Feeding observed '
    ),
    (
        4,
        1,
        2,
        ' Snowfall Pass ',
        '2024-05-18 18:30:00',
        NULL
    );

-- --------------------------------------------------------------------------------
-- Challenges that come with PostgreSQL Problems

-- Problems Number 1
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        4,
        'Derek Fox',
        'Coastal Plains'
    );

-- problems 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- problems 3
SELECT * FROM sightings 
WHERE
 location LIKE '%Pass%';

-- problems 4

SELECT r.name,COUNT(s.sighting_id) AS total_sightings
FROM rangers r
    JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY
    r.name;

-- problems-5

SELECT s.common_name
FROM species s
WHERE
    s.species_id NOT IN (
        SELECT DISTINCT
            species_id
        FROM sightings
    );

-- problems-6
SELECT c ommon_name, sighting_time, name
FROM
    sightings
    JOIN species ON species.species_id = sightings.species_id
    JOIN rangers ON rangers.ranger_id = sightings.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- problems-7

UPDATE species
SET
    conservation_status ='Historic'
WHERE
    extract(
        y
        FROM discovery_date
    ) < '1800';

-- problems-8
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) >= 12
        AND EXTRACT(
            HOUR
            FROM sighting_time
        ) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;


-- problems- 9
DELETE FROM rangers
WHERE
    NOT EXISTS (
        SELECT
        FROM sightings
        WHERE
            sightings.ranger_id = rangers.ranger_id
    );

    SELECT * FROM rangers;
    SELECT * FROM species;
    SELECT * FROM sightings;