
/*  TIFOSI - Script 1 : Création du schéma de la base de données */

CREATE DATABASE IF NOT EXISTS tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;


CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi2024!';


USE tifosi;


/* TABLES */

/* Table INGREDIENT */

CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT          NOT NULL AUTO_INCREMENT,
    nom           VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_ingredient PRIMARY KEY (id_ingredient),
    CONSTRAINT uq_ingredient_nom UNIQUE (nom)
);


/* Table MARQUE */

CREATE TABLE IF NOT EXISTS marque (
    id_marque INT          NOT NULL AUTO_INCREMENT,
    nom       VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_marque PRIMARY KEY (id_marque),
    CONSTRAINT uq_marque_nom UNIQUE (nom)
);


/* Table BOISSON */

CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT          NOT NULL AUTO_INCREMENT,
    nom        VARCHAR(50)  NOT NULL,
    id_marque  INT          NOT NULL,
    CONSTRAINT pk_boisson PRIMARY KEY (id_boisson),
    CONSTRAINT uq_boisson_nom UNIQUE (nom),
    CONSTRAINT fk_boisson_marque
        FOREIGN KEY (id_marque)
        REFERENCES marque(id_marque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


/* Table FOCCACIA */

CREATE TABLE IF NOT EXISTS foccacia (
    id_foccacia INT            NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(50)    NOT NULL,
    prix        DECIMAL(5,2)   NOT NULL,
    CONSTRAINT pk_foccacia PRIMARY KEY (id_foccacia),
    CONSTRAINT uq_foccacia_nom UNIQUE (nom),
    CONSTRAINT ck_foccacia_prix CHECK (prix > 0)
);


/* Table CLIENT */

CREATE TABLE IF NOT EXISTS client (
    id_client   INT           NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(50)   NOT NULL,
    email       VARCHAR(150)  NOT NULL,
    code_postal INT           NOT NULL,
    CONSTRAINT pk_client PRIMARY KEY (id_client),
    CONSTRAINT uq_client_email UNIQUE (email)
);


/* Table MENU */

CREATE TABLE IF NOT EXISTS menu (
    id_menu INT            NOT NULL AUTO_INCREMENT,
    nom     VARCHAR(50)    NOT NULL,
    prix    DECIMAL(5,2)   NOT NULL,
    CONSTRAINT pk_menu PRIMARY KEY (id_menu),
    CONSTRAINT uq_menu_nom UNIQUE (nom),
    CONSTRAINT ck_menu_prix CHECK (prix > 0)
);


/* TABLES DE LIAISON */

/* Table COMPREND  (foccacia / ingredient) */

CREATE TABLE IF NOT EXISTS comprend (
    id_foccacia   INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite      INT NOT NULL DEFAULT 1,
    CONSTRAINT pk_comprend PRIMARY KEY (id_foccacia, id_ingredient),
    CONSTRAINT ck_comprend_quantite CHECK (quantite > 0),
    CONSTRAINT fk_comprend_foccacia
        FOREIGN KEY (id_foccacia)
        REFERENCES foccacia(id_foccacia)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_comprend_ingredient
        FOREIGN KEY (id_ingredient)
        REFERENCES ingredient(id_ingredient)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


    /* Table CONTIENT  (menu / boisson) */

CREATE TABLE IF NOT EXISTS contient (
    id_menu    INT NOT NULL,
    id_boisson INT NOT NULL,
    CONSTRAINT pk_contient PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_contient_menu
        FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_contient_boisson
        FOREIGN KEY (id_boisson)
        REFERENCES boisson(id_boisson)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


/* Table ACHETE  (client / menu) */

CREATE TABLE IF NOT EXISTS achete (
    id_client  INT  NOT NULL,
    id_menu    INT  NOT NULL,
    date_achat DATE NOT NULL,
    CONSTRAINT pk_achete PRIMARY KEY (id_client, id_menu, date_achat),
    CONSTRAINT fk_achete_client
        FOREIGN KEY (id_client)
        REFERENCES client(id_client)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_achete_menu
        FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


/* Table EST_CONSTITUE  (menu ↔ foccacia) */

CREATE TABLE IF NOT EXISTS est_constitue (
    id_menu     INT NOT NULL,
    id_foccacia INT NOT NULL,
    CONSTRAINT pk_est_constitue PRIMARY KEY (id_menu, id_foccacia),
    CONSTRAINT fk_est_constitue_menu
        FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_est_constitue_foccacia
        FOREIGN KEY (id_foccacia)
        REFERENCES foccacia(id_foccacia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
