CREATE SCHEMA IF NOT EXISTS kakarotosfc;
USE kakarotosfc;

CREATE TABLE IF NOT EXISTS player (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  number INT NOT NULL,
  position VARCHAR(50) NULL,
  foot CHAR NULL,
  weak_foot INT NULL,
  skills INT NULL,
  start_date DATE NOT NULL,
  departure_date DATE NULL,
  image_url VARCHAR(255) NULL,
  PRIMARY KEY (id),
  CONSTRAINT name_unique_constraint UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS season (
  season VARCHAR(50) NOT NULL,
  start_date DATE NULL,
  end_date DATE NULL,
  PRIMARY KEY (season)
);

CREATE TABLE IF NOT EXISTS player_performance (
  player_id INT NOT NULL,
  season VARCHAR(50) NOT NULL,
  matches INT NOT NULL,
  goals INT NOT NULL,
  assists INT NOT NULL,
  goals_received INT NOT NULL,
  clean_sheets INT NOT NULL,
  yellow_cards INT NOT NULL,
  blue_cards INT NOT NULL,
  red_cards INT NOT NULL,
  mvp_matches INT NOT NULL,
  CONSTRAINT fk_player_performance_player_id
    FOREIGN KEY (player_id) REFERENCES player (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_player_performance_season
    FOREIGN KEY (season) REFERENCES season (season)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS team_performance (
  season VARCHAR(50) NOT NULL,
  played_matches INT NOT NULL,
  won_matches INT NOT NULL,
  drawn_matches INT NOT NULL,
  lost_matches INT NOT NULL,
  goals_for INT NOT NULL,
  goals_against INT NOT NULL,
  points INT NOT NULL,
  position_per_rivals VARCHAR(50) NOT NULL,
  CONSTRAINT fk_team_performance_season
    FOREIGN KEY (season) REFERENCES season (season)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS collection (
  collection VARCHAR(50) NOT NULL,
  start_date DATE NULL,
  end_date DATE NULL,
  enabled BOOLEAN NOT NULL,
  PRIMARY KEY (collection)
);

CREATE TABLE IF NOT EXISTS product (
  id INT NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) NULL,
  price FLOAT NOT NULL,
  collection VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (collection) REFERENCES collection (collection)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS product_image (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  image_description VARCHAR(255) NULL,
  image_url VARCHAR(255) NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_product_image_product
    FOREIGN KEY (product_id) REFERENCES product (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS units_per_size (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  size VARCHAR(255) NOT NULL,
  units_available INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_units_per_size_product FOREIGN KEY (product_id) REFERENCES product (id)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION,
  CONSTRAINT unique_product_id_size UNIQUE (product_id, size)
);

CREATE TABLE IF NOT EXISTS auth (
  client VARCHAR(50) NOT NULL,
  token VARCHAR(36) NULL,
  generation_date DATE NULL,
  PRIMARY KEY (client)
);