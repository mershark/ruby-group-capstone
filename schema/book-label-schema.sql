-- Label Table
CREATE TABLE label (
  ID SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  color VARCHAR(50)
);

-- Book Table
CREATE TABLE book (
  ID SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  publish_date DATE NOT NULL,
  publisher VARCHAR(50) NOT NULL,
  cover_state VARCHAR(50) NOT NULL,
  archived BOOLEAN NOT NULL,
  label_ID INT REFERENCES label(ID)
);

-- Item Table
CREATE TABLE item (
  ID SERIAL PRIMARY KEY,
  genre VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  label_ID INT REFERENCES label(ID),
  source VARCHAR(255) NOT NULL,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL
);
