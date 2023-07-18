CREATE SCHEMA IF NOT EXISTS kakarotosfc;
USE kakarotosfc;

--drop tables to keep testing clean on every try. This will be removed once we implement this productively. 
drop table if exists team_performance;
drop table if exists player_performance;
drop table if exists season;
drop table if exists player;
drop table if exists product_image;
drop table if exists units_per_size;
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

insert into kakarotosfc.collection values ('KAKAROTO', '2021-03-01', '2022-05-05', false);
insert into kakarotosfc.collection values ('VEGETA BLASTI', '2023-03-08', '2023-07-01', true);
insert into kakarotosfc.collection values ('MAJIN BOO PHYSIOPARTNERS', '2023-08-05', null, false);
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
insert into kakarotosfc.units_per_size values (1, 1, 'S', 24);
insert into kakarotosfc.units_per_size values (2, 1, 'M', 1);
insert into kakarotosfc.units_per_size values (3, 1, 'L', 14);
insert into kakarotosfc.units_per_size values (4, 1, 'XL', 17);
insert into kakarotosfc.units_per_size values (5, 2, 'S', 1);
insert into kakarotosfc.units_per_size values (6, 2, 'M', 17);
insert into kakarotosfc.units_per_size values (7, 2, 'L', 16);
insert into kakarotosfc.units_per_size values (8, 2, 'XL', 21);
insert into kakarotosfc.units_per_size values (9, 3, 'S', 17);
insert into kakarotosfc.units_per_size values (10, 3, 'M', 0);
insert into kakarotosfc.units_per_size values (11, 3, 'L', 14);
insert into kakarotosfc.units_per_size values (12, 3, 'XL', 13);
insert into kakarotosfc.units_per_size values (13, 4, 'S', 16);
insert into kakarotosfc.units_per_size values (14, 4, 'M', 3);
insert into kakarotosfc.units_per_size values (15, 4, 'L', 6);
insert into kakarotosfc.units_per_size values (16, 4, 'XL', 18);
insert into kakarotosfc.units_per_size values (17, 5, 'S', 22);
insert into kakarotosfc.units_per_size values (18, 5, 'M', 12);
insert into kakarotosfc.units_per_size values (19, 5, 'L', 21);
insert into kakarotosfc.units_per_size values (20, 5, 'XL', 11);
insert into kakarotosfc.units_per_size values (21, 6, 'S', 13);
insert into kakarotosfc.units_per_size values (22, 6, 'M', 9);
insert into kakarotosfc.units_per_size values (23, 6, 'L', 12);
insert into kakarotosfc.units_per_size values (24, 6, 'XL', 24);
insert into kakarotosfc.units_per_size values (25, 7, 'S', 6);
insert into kakarotosfc.units_per_size values (26, 7, 'M', 0);
insert into kakarotosfc.units_per_size values (27, 7, 'L', 1);
insert into kakarotosfc.units_per_size values (28, 7, 'XL', 23);
insert into kakarotosfc.units_per_size values (29, 8, 'S', 21);
insert into kakarotosfc.units_per_size values (30, 8, 'M', 14);
insert into kakarotosfc.units_per_size values (31, 8, 'L', 21);
insert into kakarotosfc.units_per_size values (32, 8, 'XL', 25);
insert into kakarotosfc.units_per_size values (33, 9, 'S', 11);
insert into kakarotosfc.units_per_size values (34, 9, 'M', 5);
insert into kakarotosfc.units_per_size values (35, 9, 'L', 1);
insert into kakarotosfc.units_per_size values (36, 9, 'XL', 8);
insert into kakarotosfc.units_per_size values (37, 10, 'S', 14);
insert into kakarotosfc.units_per_size values (38, 10, 'M', 4);
insert into kakarotosfc.units_per_size values (39, 10, 'L', 6);
insert into kakarotosfc.units_per_size values (40, 10, 'XL', 9);
insert into kakarotosfc.units_per_size values (41, 11, 'S', 4);
insert into kakarotosfc.units_per_size values (42, 11, 'M', 16);
insert into kakarotosfc.units_per_size values (43, 11, 'L', 3);
insert into kakarotosfc.units_per_size values (44, 11, 'XL', 4);
insert into kakarotosfc.units_per_size values (45, 12, 'S', 5);
insert into kakarotosfc.units_per_size values (46, 12, 'M', 19);
insert into kakarotosfc.units_per_size values (47, 12, 'L', 21);
insert into kakarotosfc.units_per_size values (48, 12, 'XL', 21);
insert into kakarotosfc.units_per_size values (49, 13, 'S', 1);
insert into kakarotosfc.units_per_size values (50, 13, 'M', 25);
insert into kakarotosfc.units_per_size values (51, 13, 'L', 19);
insert into kakarotosfc.units_per_size values (52, 13, 'XL', 19);
insert into kakarotosfc.units_per_size values (53, 14, 'S', 8);
insert into kakarotosfc.units_per_size values (54, 14, 'M', 9);
insert into kakarotosfc.units_per_size values (55, 14, 'L', 14);
insert into kakarotosfc.units_per_size values (56, 14, 'XL', 24);
insert into kakarotosfc.units_per_size values (57, 15, 'S', 22);
insert into kakarotosfc.units_per_size values (58, 15, 'M', 23);
insert into kakarotosfc.units_per_size values (59, 15, 'L', 3);
insert into kakarotosfc.units_per_size values (60, 15, 'XL', 25);
insert into kakarotosfc.units_per_size values (61, 16, 'S', 7);
insert into kakarotosfc.units_per_size values (62, 16, 'M', 8);
insert into kakarotosfc.units_per_size values (63, 16, 'L', 4);
insert into kakarotosfc.units_per_size values (64, 16, 'XL', 6);
insert into kakarotosfc.units_per_size values (65, 17, 'S', 11);
insert into kakarotosfc.units_per_size values (66, 17, 'M', 12);
insert into kakarotosfc.units_per_size values (67, 17, 'L', 8);
insert into kakarotosfc.units_per_size values (68, 17, 'XL', 13);
insert into kakarotosfc.units_per_size values (69, 18, 'S', 24);
insert into kakarotosfc.units_per_size values (70, 18, 'M', 3);
insert into kakarotosfc.units_per_size values (71, 18, 'L', 24);
insert into kakarotosfc.units_per_size values (72, 18, 'XL', 18);
