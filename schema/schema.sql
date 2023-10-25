CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  genre VARCHAR(255),
  author VARCHAR(255),
  label VARCHAR(255),
  source VARCHAR(255),
  publish_date DATE
);


CREATE TABLE movies (
  item_id INT PRIMARY KEY REFERENCES items(id),
  silent BOOLEAN
);


CREATE TABLE sources (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);


ALTER TABLE items
ADD COLUMN source_id INT REFERENCES sources(id);
