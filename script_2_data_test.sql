
/* TIFOSI - Script 2 : Remplissage de la base de données pour test */


USE tifosi;

SET FOREIGN_KEY_CHECKS = 0;


/* TABLE : marque   */

INSERT INTO marque (id_marque, nom) VALUES
    (1, 'Coca-cola'),
    (2, 'Cristalline'),
    (3, 'Monster'),
    (4, 'Pepsico');


/*  TABLE : ingredient  */

INSERT INTO ingredient (id_ingredient, nom) VALUES
    (1,  'Ail'),
    (2,  'Ananas'),
    (3,  'Artichaut'),
    (4,  'Bacon'),
    (5,  'Base Tomate'),
    (6,  'Base crème'),
    (7,  'Champignon'),
    (8,  'Chèvre'),
    (9,  'Cresson'),
    (10, 'Emmental'),
    (11, 'Gorgonzola'),
    (12, 'Jambon cuit'),
    (13, 'Jambon fumé'),
    (14, 'Oeuf'),
    (15, 'Oignon'),
    (16, 'Olive noire'),
    (17, 'Olive verte'),
    (18, 'Parmesan'),
    (19, 'Piment'),
    (20, 'Poivre'),
    (21, 'Pomme de terre'),
    (22, 'Raclette'),
    (23, 'Salami'),
    (24, 'Tomate cerise'),
    (25, 'Mozarella');


/* TABLE : boisson  
--  id_marque : 1=Coca-cola  2=Cristalline  3=Monster  4=Pepsico */

INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
    (1,  'Coca-cola zéro',           1),
    (2,  'Coca-cola original',        1),
    (3,  'Fanta citron',              1),
    (4,  'Fanta orange',              1),
    (5,  'Capri-sun',                 1),
    (6,  'Pepsi',                     4),
    (7,  'Pepsi Max Zéro',            4),
    (8,  'Lipton zéro citron',        4),
    (9,  'Lipton Peach',              4),
    (10, 'Monster energy ultra gold', 3),
    (11, 'Monster energy ultra blue', 3),
    (12, 'Eau de source',             2);


/* TABLE : foccacia  (source : focaccia.xlsx) */

INSERT INTO foccacia (id_foccacia, nom, prix) VALUES
    (1, 'Mozaccia',        9.80),
    (2, 'Gorgonzollaccia', 10.80),
    (3, 'Raclaccia',        8.90),
    (4, 'Emmentalaccia',    9.80),
    (5, 'Tradizione',       8.90),
    (6, 'Hawaienne',       11.20),
    (7, 'Américaine',      10.80),
    (8, 'Paysanne',        12.80);


--  TABLE : comprend  (foccacia / ingredient)

--  Quantités par défaut si non précisées dans la recette :
--    Ail:2  Ananas:40  Artichaut:20  Bacon:80  Base Tomate:200
--    Base crème:200  Champignon:40  Chèvre:50  Cresson:20
--    Emmental:50  Gorgonzola:50  Jambon cuit:80  Jambon fumé:80
--    Oeuf:50  Oignon:20  Olive noire:20  Olive verte:20
--    Parmesan:50  Piment:2  Poivre:1  Pomme de terre:80
--    Raclette:50  Mozarella:50

INSERT INTO comprend (id_foccacia, id_ingredient, quantite) VALUES

    -- Mozaccia (1) :

    (1, 5,  200),
    (1, 25,  50),
    (1, 9,   20),
    (1, 13,  80),
    (1, 1,    2),
    (1, 3,   20),
    (1, 7,   40),
    (1, 18,  50),
    (1, 20,   1),
    (1, 16,  20),

    -- Gorgonzollaccia (2) :
   
    (2, 5,  200),
    (2, 11,  50),
    (2, 9,   20),
    (2, 1,    2),
    (2, 7,   40),
    (2, 18,  50),
    (2, 20,   1),
    (2, 16,  20),

    -- Raclaccia (3) :
  
    (3, 5,  200),
    (3, 22,  50),
    (3, 9,   20),
    (3, 1,    2),
    (3, 7,   40),
    (3, 18,  50),
    (3, 20,   1),

    -- Emmentalaccia (4) :
 
    (4, 6,  200),
    (4, 10,  50),
    (4, 9,   20),
    (4, 7,   40),
    (4, 18,  50),
    (4, 20,   1),
    (4, 15,  20),

    -- Tradizione (5) :

    (5, 5,  200),
    (5, 25,  50),
    (5, 9,   20),
    (5, 12,  80),
    (5, 7,   80),  -- quantité spéciale : 80g
    (5, 18,  50),
    (5, 20,   1),
    (5, 16,  10),  -- quantité spéciale : 10g
    (5, 17,  10),  -- quantité spéciale : 10g

    -- Hawaienne (6) :

    (6, 5,  200),
    (6, 25,  50),
    (6, 9,   20),
    (6, 4,   80),
    (6, 2,   40),
    (6, 19,   2),
    (6, 18,  50),
    (6, 20,   1),
    (6, 16,  20),

    -- Américaine (7) :
  
    (7, 5,  200),
    (7, 25,  50),
    (7, 9,   20),
    (7, 4,   80),
    (7, 21,  40),  -- quantité spéciale : 40g
    (7, 18,  50),
    (7, 20,   1),
    (7, 16,  20),

    -- Paysanne (8) :

    (8, 6,  200),
    (8, 8,   50),
    (8, 9,   20),
    (8, 21,  80),
    (8, 13,  80),
    (8, 1,    2),
    (8, 3,   20),
    (8, 7,   40),
    (8, 18,  50),
    (8, 20,   1),
    (8, 16,  20),
    (8, 14,  50);


/*  TABLE : menu   */

INSERT INTO menu (nom, prix) VALUES
    ('Menu Classico',  14.50),
    ('Menu Gourmand',  17.50),
    ('Menu Tropical',  16.20),
    ('Menu Montagne',  15.90);


/*  TABLE : contient  (menu / boisson) */


INSERT INTO contient (id_menu, id_boisson) VALUES
    (1, 2),   -- Menu Classico  → Coca-cola original
    (1, 12),  -- Menu Classico  → Eau de source
    (2, 1),   -- Menu Gourmand  → Coca-cola zéro
    (2, 9),   -- Menu Gourmand  → Lipton Peach
    (3, 3),   -- Menu Tropical  → Fanta citron
    (3, 5),   -- Menu Tropical  → Capri-sun
    (4, 10),  -- Menu Montagne  → Monster ultra gold
    (4, 12);  -- Menu Montagne  → Eau de source


/*  TABLE : est_constitue  (menu / foccacia) */

INSERT INTO est_constitue (id_menu, id_foccacia) VALUES
    (1, 5),  -- Menu Classico  → Tradizione
    (2, 8),  -- Menu Gourmand  → Paysanne
    (3, 6),  -- Menu Tropical  → Hawaienne
    (4, 3),  -- Menu Montagne  → Raclaccia
    (4, 2);  -- Menu Montagne  → Gorgonzollaccia


/*  TABLE : client   */

INSERT INTO client (nom, email, code_postal) VALUES
    ('Dupont Marie',   'marie.dupont@email.fr',   31000),
    ('Martin Lucas',   'lucas.martin@email.fr',   75001),
    ('Rossi Giovanni', 'g.rossi@email.it',         69001),
    ('Petit Sophie',   'sophie.petit@email.fr',   33000),
    ('Garcia Carlos',  'carlos.garcia@email.es',  13001);


/*  TABLE : achete  (client / menu) */

INSERT INTO achete (id_client, id_menu, date_achat) VALUES
    (1, 1, '2024-03-01'),
    (1, 2, '2024-03-15'),
    (2, 3, '2024-03-05'),
    (3, 1, '2024-03-10'),
    (4, 4, '2024-03-12'),
    (5, 2, '2024-03-20');

SET FOREIGN_KEY_CHECKS = 1;

