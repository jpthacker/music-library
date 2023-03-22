TRUNCATE TABLE artists, albums RESTART IDENTITY;

INSERT INTO artists (name, genre) VALUES ('Pixies', 'rock');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', 1988, 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', 1972, 2);