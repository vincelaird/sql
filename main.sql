CREATE TABLE bands (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  release_year INT,
  band_id INT NOT NULL,
  CONSTRAINT FK_albums_bands FOREIGN KEY (band_id) REFERENCES bands(id)
);

INSERT INTO bands (name)
VALUES ('Iron Maiden'), ('Deuce'), ('Avenged Sevenfold'), ('Ankor');

INSERT INTO albums (name, release_year, band_id)
VALUES ('The Number of the Beasts', 1985, 1),
       ('Power Slave', 1984, 2),
       ('Nightmare', 2018, 2),
       ('Nightmare', 2010, 3),
       ('Test Album', NULL, 3);

-- change release year for album of id 1 from 1984 to 1982
UPDATE albums
SET release_year = 1982
WHERE id = 1;

-- albums released prior to 2000
SELECT * FROM albums
WHERE release_year < 2000;

-- any characters, the string er, any characters after, or id of band is 2
SELECT * FROM albums
WHERE name LIKE '%er%' OR band_id = 2;

-- release year is 1984 and band id is 1
SELECT * FROM albums
WHERE release_year = 1982 AND band_id = 1;

-- release year was between 2000 and 2018
SELECT * FROM albums
WHERE release_year BETWEEN 2000 AND 2018;

-- albums without a release year
SELECT * FROM albums
WHERE release_year IS NULL;

SELECT * FROM bands
INNER JOIN albums ON bands.id = albums.band_id;

-- LEFT JOIN (includes bands with no albums)
SELECT * FROM bands
LEFT JOIN albums ON bands.id = albums.band_id;

-- RIGHT JOIN (includes albums with no bands)
SELECT * FROM bands
RIGHT JOIN albums ON bands.id = albums.band_id;

-- average of release year
SELECT AVG(release_year) FROM albums;

-- counts albums by band id
SELECT band_id, COUNT(band_id) FROM albums
GROUP BY band_id;

-- add band name to results (showing only bands with 1 album)
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands AS b
LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING COUNT(a.id) = 1;
