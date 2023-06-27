CREATE SCHEMA IF NOT EXISTS kakarotosfc;
USE kakarotosfc;

--drop tables to keep testing clean on every try. This will be removed once we implement this productively. 
drop table if exists team_performance;
drop table if exists player_performance;
drop table if exists season;
drop table if exists player;
drop table if exists product;
drop table if exists collection;

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
  yellow_cards INT NOT NULL,
  blue_cards INT NOT NULL,
  red_cards INT NOT NULL,
  mvp_matches INT NOT NULL,
  CONSTRAINT fk_player_performance_player_id
    FOREIGN KEY (player_id)
    REFERENCES player (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_player_performance_season
    FOREIGN KEY (season)
    REFERENCES season (season)
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
    FOREIGN KEY (season)
    REFERENCES season (season)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS collection (
  collection VARCHAR(50) NOT NULL,
  start_date DATE NULL,
  end_date DATE NULL,
  PRIMARY KEY (collection)
);

CREATE TABLE IF NOT EXISTS product (
  id INT NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) NULL,
  size VARCHAR(50) NULL,
  price FLOAT NOT NULL,
  units_available INT NOT NULL,
  product_image VARCHAR(255) NULL,
  collection VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (collection)
  REFERENCES collection (collection)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
);