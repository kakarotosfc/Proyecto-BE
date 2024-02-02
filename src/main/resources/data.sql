CREATE SCHEMA IF NOT EXISTS kakarotosfc;
USE kakarotosfc;

drop table if exists kakarotosfc.player_performance;
drop table if exists kakarotosfc.team_performance;
drop table if exists kakarotosfc.player;
drop table if exists kakarotosfc.season;
drop table if exists kakarotosfc.units_per_size;
drop table if exists kakarotosfc.product_image;
drop table if exists kakarotosfc.product;
drop table if exists kakarotosfc.collection;
drop table if exists kakarotosfc.app_user_role;
drop table if exists kakarotosfc.app_user;
drop table if exists kakarotosfc.roles;

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

CREATE TABLE IF NOT EXISTS roles (
  id INT NOT NULL,
  role VARCHAR(255) NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS app_user_role (
  app_user_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (app_user_id, role_id),
  FOREIGN KEY (role_id) REFERENCES roles (id)
);

CREATE TABLE IF NOT EXISTS app_user (
  id INT AUTO_INCREMENT NOT NULL,
  credentials_expired BOOLEAN NULL,
  disabled BOOLEAN NULL,
  expired BOOLEAN NULL,
  locked BOOLEAN NULL,
  password BOOLEAN NULL,
  username BOOLEAN NULL,
  PRIMARY KEY (id)
);

ALTER TABLE app_user_role
ADD CONSTRAINT fk_app_user_role_app_user
FOREIGN KEY (app_user_id)
REFERENCES app_user (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

insert into kakarotosfc.roles values (1,"ROLE_ADMIN");
insert into kakarotosfc.roles values (2,"ROLE_USER");

/*
insert into kakarotosfc.player values (1, 'Franco Madou', 1, 'Goalkeeper', 'R', 1, 4, '2022-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (2, 'Evanilson Dos Santos', 2, 'Defender', 'R', 2, 3, '2022-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (3, 'Pedro Torres', 3, 'Midfielder', 'R', 2, 3, '2021-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (4, 'Adler Guadagnoli', 7, 'Defender', 'R', 3, 4, '2023-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (5, 'Sergio Rago', 9, 'Midfielder', 'R', 2, 3, '2019-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (6, 'Luis Vivas', 10, 'Defender', 'R', 3, 4, '2019-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (7, 'Gabriel Gonzalez', 12, 'Midfielder', 'R', 2, 4, '2022-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (8, 'Javier Hernandez', 14, 'Midfielder', 'R', 3, 5, '2022-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (9, 'Daniel Palacios', 16, 'Striker', 'R', 2, 4, '2022-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (10, 'Jonas Meza', 17, 'Midfielder', 'R', 3, 5, '2023-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (11, 'Lucas Iscariote', 19, 'Defender', 'R', 2, 3, '2019-01-01', '2023-07-23', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (12, 'Edward Monzon', 23, 'Defender', 'R', 2, 3, '2021-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (13, 'Gabriel Macias', 25, 'Striker', 'R', 3, 4, '2023-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (14, 'Tirso Gonzalez', 55, 'Goalkeeper', 'R', 1, 3, '2022-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (15, 'Eliecer Perez', 69, 'Defender', 'R', 2, 3, '2019-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (16, 'Keiver Faneite', 5, 'Midfielder', 'R', 2, 3, '2023-08-05', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.player values (17, 'Agustin Molina', 19, 'Striker', 'R', 2, 4, '2019-01-01', null, 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');

insert into kakarotosfc.season values ('VERANO 2023', '2022-12-08', '2023-03-01');
insert into kakarotosfc.season values ('APERTURA 2023', '2023-03-08', '2023-07-01');
insert into kakarotosfc.season values ('CLAUSURA 2023', '2023-08-05', null);

insert into kakarotosfc.player_performance values (1, 'APERTURA 2023', 10, 0, 0, 10, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (2, 'APERTURA 2023', 10, 0, 0, 0, 0, 2, 0, 0, 0);
insert into kakarotosfc.player_performance values (3, 'APERTURA 2023', 10, 1, 1, 0, 0, 1, 0, 0, 0);
insert into kakarotosfc.player_performance values (4, 'APERTURA 2023', 10, 4, 2, 0, 0, 1, 0, 0, 1);
insert into kakarotosfc.player_performance values (5, 'APERTURA 2023', 10, 2, 1, 0, 0, 2, 0, 0, 0);
insert into kakarotosfc.player_performance values (6, 'APERTURA 2023', 10, 2, 3, 0, 0, 2, 0, 0, 0);
insert into kakarotosfc.player_performance values (7, 'APERTURA 2023', 10, 1, 1, 0, 0, 1, 0, 0, 0);
insert into kakarotosfc.player_performance values (8, 'APERTURA 2023', 10, 3, 2, 0, 0, 1, 0, 0, 1);
insert into kakarotosfc.player_performance values (9, 'APERTURA 2023', 10, 3, 0, 0, 0, 2, 1, 0, 1);
insert into kakarotosfc.player_performance values (10, 'APERTURA 2023', 10, 4, 2, 0, 0, 1, 0, 0, 1);
insert into kakarotosfc.player_performance values (11, 'APERTURA 2023', 10, 0, 0, 0, 0, 1, 0, 0, 0);
insert into kakarotosfc.player_performance values (12, 'APERTURA 2023', 10, 1, 1, 17, 1, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (13, 'APERTURA 2023', 10, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (14, 'APERTURA 2023', 10, 1, 1, 0, 0, 2, 0, 0, 0);
insert into kakarotosfc.player_performance values (15, 'APERTURA 2023', 10, 1, 1, 0, 0, 2, 0, 0, 0);

insert into kakarotosfc.player_performance values (1, 'CLAUSURA 2023', 4, 0, 0, 10, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (2, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (3, 'CLAUSURA 2023', 4, 1, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (4, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (5, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (6, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 1, 0, 0, 0);
insert into kakarotosfc.player_performance values (7, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (8, 'CLAUSURA 2023', 4, 0, 1, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (9, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (10, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (12, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (13, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (14, 'CLAUSURA 2023', 4, 0, 0, 4, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (15, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (16, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);
insert into kakarotosfc.player_performance values (17, 'CLAUSURA 2023', 4, 0, 0, 0, 0, 0, 0, 0, 0);

insert into kakarotosfc.team_performance values ('VERANO 2023', 6, 1, 0, 5, 8, 19, 3, '3/4');
insert into kakarotosfc.team_performance values ('APERTURA 2023', 10, 3, 3, 4, 22, 27, 12, '8/11');
insert into kakarotosfc.team_performance values ('CLAUSURA 2023', 4, 0, 0, 4, 1, 14, 0, '12/12');

insert into kakarotosfc.collection values ('KAKAROTO', '2021-03-01', '2022-05-05', false);
insert into kakarotosfc.collection values ('VEGETA BLASTI', '2023-03-08', '2023-07-01', false);
insert into kakarotosfc.collection values ('MAJIN BOO PHYSIOPARTNERS', '2023-08-05', null, true);

insert into kakarotosfc.product values (1, 'Camiseta Jugador', 5000, 'KAKAROTO');
insert into kakarotosfc.product values (2, 'Short Jugador', 2500, 'KAKAROTO');
insert into kakarotosfc.product values (3, 'Uniforme Jugador', 6800, 'KAKAROTO');
insert into kakarotosfc.product values (4, 'Camiseta Portero', 5000, 'KAKAROTO');
insert into kakarotosfc.product values (5, 'Short Portero', 2500, 'KAKAROTO');
insert into kakarotosfc.product values (6, 'Uniforme Portero', 6800, 'KAKAROTO');
insert into kakarotosfc.product values (7, 'Camiseta Jugador', 5000, 'VEGETA BLASTI');
insert into kakarotosfc.product values (8, 'Short Jugador', 2500, 'VEGETA BLASTI');
insert into kakarotosfc.product values (9, 'Uniforme Jugador', 6800, 'VEGETA BLASTI');
insert into kakarotosfc.product values (10, 'Camiseta Portero', 5000, 'VEGETA BLASTI');
insert into kakarotosfc.product values (11, 'Short Portero', 2500, 'VEGETA BLASTI');
insert into kakarotosfc.product values (12, 'Uniforme Portero', 6800, 'VEGETA BLASTI');
insert into kakarotosfc.product values (13, 'Camiseta Jugador', 5000, 'MAJIN BOO PHYSIOPARTNERS');
insert into kakarotosfc.product values (14, 'Short Jugador', 2500, 'MAJIN BOO PHYSIOPARTNERS');
insert into kakarotosfc.product values (15, 'Uniforme Jugador', 6800, 'MAJIN BOO PHYSIOPARTNERS');
insert into kakarotosfc.product values (16, 'Camiseta Portero', 5000, 'MAJIN BOO PHYSIOPARTNERS');
insert into kakarotosfc.product values (17, 'Short Portero', 2500, 'MAJIN BOO PHYSIOPARTNERS');
insert into kakarotosfc.product values (18, 'Uniforme Portero', 6800, 'MAJIN BOO PHYSIOPARTNERS');

insert into kakarotosfc.product_image values (1, 1, 'Frente de camiseta jugador KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (2, 1, 'Espalda de camiseta jugador KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (3, 2, 'Frente de short jugador KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (4, 2, 'Espalda de short jugador KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (5, 3, 'Frente de uniforme jugador KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (6, 3, 'Espalda de uniforme jugador KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (7, 4, 'Frente de camiseta portero KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (8, 4, 'Espalda de camiseta portero KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (9, 5, 'Frente de short portero KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (10, 5, 'Espalda de short portero KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (11, 6, 'Frente de uniforme portero KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (12, 6, 'Espalda de uniforme portero KAKAROTO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (13, 7, 'Frente de camiseta jugador VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (14, 7, 'Espalda de camiseta jugador VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (15, 8, 'Frente de short jugador VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (16, 8, 'Espalda de short jugador VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (17, 9, 'Frente de uniforme jugador VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (18, 9, 'Espalda de uniforme jugador VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (19, 10, 'Frente de camiseta portero VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (20, 10, 'Espalda de camiseta portero VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (21, 11, 'Frente de short portero VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (22, 11, 'Espalda de short portero VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (23, 12, 'Frente de uniforme portero VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (24, 12, 'Espalda de uniforme portero VEGETA', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (25, 13, 'Frente de camiseta jugador MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (26, 13, 'Espalda de camiseta jugador MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (27, 14, 'Frente de short jugador MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (28, 14, 'Espalda de short jugador MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (29, 15, 'Frente de uniforme jugador MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (30, 15, 'Espalda de uniforme jugador MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (31, 16, 'Frente de camiseta portero MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (32, 16, 'Espalda de camiseta portero MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (33, 17, 'Frente de short portero MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (34, 17, 'Espalda de short portero MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (35, 18, 'Frente de uniforme portero MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');
insert into kakarotosfc.product_image values (36, 18, 'Espalda de uniforme portero MAJIN BOO', 'https://i.pinimg.com/564x/2b/31/5b/2b315b08283f31a440c6c7124801a374.jpg');

insert into kakarotosfc.units_per_size values (1, 1, 'S', 1);
insert into kakarotosfc.units_per_size values (2, 1, 'M', 17);
insert into kakarotosfc.units_per_size values (3, 1, 'L', 22);
insert into kakarotosfc.units_per_size values (4, 1, 'XL', 5);
insert into kakarotosfc.units_per_size values (5, 2, 'S', 10);
insert into kakarotosfc.units_per_size values (6, 2, 'M', 18);
insert into kakarotosfc.units_per_size values (7, 2, 'L', 5);
insert into kakarotosfc.units_per_size values (8, 2, 'XL', 17);
insert into kakarotosfc.units_per_size values (9, 3, 'S', 11);
insert into kakarotosfc.units_per_size values (10, 3, 'M', 0);
insert into kakarotosfc.units_per_size values (11, 3, 'L', 17);
insert into kakarotosfc.units_per_size values (12, 3, 'XL', 1);
insert into kakarotosfc.units_per_size values (13, 4, 'S', 10);
insert into kakarotosfc.units_per_size values (14, 4, 'M', 11);
insert into kakarotosfc.units_per_size values (15, 4, 'L', 10);
insert into kakarotosfc.units_per_size values (16, 4, 'XL', 5);
insert into kakarotosfc.units_per_size values (17, 5, 'S', 6);
insert into kakarotosfc.units_per_size values (18, 5, 'M', 15);
insert into kakarotosfc.units_per_size values (19, 5, 'L', 21);
insert into kakarotosfc.units_per_size values (20, 5, 'XL', 7);
insert into kakarotosfc.units_per_size values (21, 6, 'S', 24);
insert into kakarotosfc.units_per_size values (22, 6, 'M', 4);
insert into kakarotosfc.units_per_size values (23, 6, 'L', 21);
insert into kakarotosfc.units_per_size values (24, 6, 'XL', 25);
insert into kakarotosfc.units_per_size values (25, 7, 'S', 15);
insert into kakarotosfc.units_per_size values (26, 7, 'M', 13);
insert into kakarotosfc.units_per_size values (27, 7, 'L', 17);
insert into kakarotosfc.units_per_size values (28, 7, 'XL', 2);
insert into kakarotosfc.units_per_size values (29, 8, 'S', 13);
insert into kakarotosfc.units_per_size values (30, 8, 'M', 10);
insert into kakarotosfc.units_per_size values (31, 8, 'L', 19);
insert into kakarotosfc.units_per_size values (32, 8, 'XL', 17);
insert into kakarotosfc.units_per_size values (33, 9, 'S', 23);
insert into kakarotosfc.units_per_size values (34, 9, 'M', 14);
insert into kakarotosfc.units_per_size values (35, 9, 'L', 8);
insert into kakarotosfc.units_per_size values (36, 9, 'XL', 3);
insert into kakarotosfc.units_per_size values (37, 10, 'S', 2);
insert into kakarotosfc.units_per_size values (38, 10, 'M', 16);
insert into kakarotosfc.units_per_size values (39, 10, 'L', 24);
insert into kakarotosfc.units_per_size values (40, 10, 'XL', 25);
insert into kakarotosfc.units_per_size values (41, 11, 'S', 7);
insert into kakarotosfc.units_per_size values (42, 11, 'M', 16);
insert into kakarotosfc.units_per_size values (43, 11, 'L', 7);
insert into kakarotosfc.units_per_size values (44, 11, 'XL', 24);
insert into kakarotosfc.units_per_size values (45, 12, 'S', 12);
insert into kakarotosfc.units_per_size values (46, 12, 'M', 19);
insert into kakarotosfc.units_per_size values (47, 12, 'L', 15);
insert into kakarotosfc.units_per_size values (48, 12, 'XL', 8);
insert into kakarotosfc.units_per_size values (49, 13, 'S', 17);
insert into kakarotosfc.units_per_size values (50, 13, 'M', 9);
insert into kakarotosfc.units_per_size values (51, 13, 'L', 16);
insert into kakarotosfc.units_per_size values (52, 13, 'XL', 15);
insert into kakarotosfc.units_per_size values (53, 14, 'S', 4);
insert into kakarotosfc.units_per_size values (54, 14, 'M', 14);
insert into kakarotosfc.units_per_size values (55, 14, 'L', 11);
insert into kakarotosfc.units_per_size values (56, 14, 'XL', 22);
insert into kakarotosfc.units_per_size values (57, 15, 'S', 25);
insert into kakarotosfc.units_per_size values (58, 15, 'M', 19);
insert into kakarotosfc.units_per_size values (59, 15, 'L', 15);
insert into kakarotosfc.units_per_size values (60, 15, 'XL', 20);
insert into kakarotosfc.units_per_size values (61, 16, 'S', 19);
insert into kakarotosfc.units_per_size values (62, 16, 'M', 4);
insert into kakarotosfc.units_per_size values (63, 16, 'L', 10);
insert into kakarotosfc.units_per_size values (64, 16, 'XL', 17);
insert into kakarotosfc.units_per_size values (65, 17, 'S', 13);
insert into kakarotosfc.units_per_size values (66, 17, 'M', 4);
insert into kakarotosfc.units_per_size values (67, 17, 'L', 0);
insert into kakarotosfc.units_per_size values (68, 17, 'XL', 19);
insert into kakarotosfc.units_per_size values (69, 18, 'S', 18);
insert into kakarotosfc.units_per_size values (70, 18, 'M', 2);
insert into kakarotosfc.units_per_size values (71, 18, 'L', 10);
insert into kakarotosfc.units_per_size values (72, 18, 'XL', 22);
*/