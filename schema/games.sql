CREATE TABLE games (
  id INT PRIMARY KEY,
  publish_date VARCHAR(255),
  archived BOOLEAN,
  multiplayer BOOLEAN,
  last_played_at VARCHAR(255),
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- authors table
CREATE TABLE authors (
  id INT PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);