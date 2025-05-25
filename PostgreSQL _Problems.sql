-- Active: 1748032491760@@localhost@5432@conservation_db
CREATE DATABASE conservation_db;


-- Information to demonstrate the structure, format, and content of this simple

-- Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    region VARCHAR(70) NOT NULL
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

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;










