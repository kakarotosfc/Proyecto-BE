CREATE SCHEMA IF NOT EXISTS kakarotos;
USE kakarotos;

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
  PRIMARY KEY (id)
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