
/*  TIFOSI - Script 3 : Requêtes de test de la BDD */


USE tifosi;


/*  REQUÊTE 1 - Liste des focaccias par ordre alphabétique */

SELECT nom
FROM foccacia
ORDER BY nom ASC;
/*
  Résultat  :
  Américaine
  Emmentalaccia
  Gorgonzollaccia
  Hawaienne
  Mozaccia
  Paysanne
  Raclaccia
  Tradizione
*/


/*  REQUÊTE 2 - Afficher le nombre total d'ingrédients */

SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;
/*
  Résultat : 25
  25 ingrédients insérés dans le script 02
*/


/* REQUÊTE 3 - Afficher le prix moyen des focaccias.*/

SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM foccacia;
/*
  Résultat :
  (9.80 + 10.80 + 8.90 + 9.80 + 8.90 + 11.20 + 10.80 + 12.80) / 8
  = 83.00 / 8 = 10.38 €
*/


/*  REQUÊTE 4 - Afficher la liste des boissons avec leur marque, triée par nom de boisson. */

SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;
/*
  Résultat  :
  Capri-sun                | Coca-cola
  Coca-cola original       | Coca-cola
  Coca-cola zéro           | Coca-cola
  Eau de source            | Cristalline
  Fanta citron             | Coca-cola
  Fanta orange             | Coca-cola
  Lipton Peach             | Pepsico
  Lipton zéro citron       | Pepsico
  Monster energy ultra blue| Monster
  Monster energy ultra gold| Monster
  Pepsi                    | Pepsico
  Pepsi Max Zéro           | Pepsico
*/



/*  REQUÊTE 5 - Afficher la liste des ingrédients pour une Raclaccia. */

SELECT i.nom AS ingredient, c.quantite AS quantite_g
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;
/*
  Résultat :
  Ail           | 2
  Base Tomate   | 200
  Champignon    | 40
  Cresson       | 20
  Parmesan      | 50
  Poivre        | 1
  Raclette      | 50
*/


/*  REQUÊTE 6 - Afficher le nom et le nombre d'ingrédients pour chaque focaccia. */

SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
GROUP BY f.id_foccacia, f.nom
ORDER BY nb_ingredients DESC, f.nom ASC;
/*
  Résultat  :
  Paysanne        - 12
  Mozaccia        - 10
  Tradizione      - 9
  Hawaienne       - 9
  Américaine      - 8
  Gorgonzollaccia - 8
  Emmentalaccia   - 7
  Raclaccia       - 7
*/


/*  REQUÊTE 7 - Afficher le nom de la focaccia qui a le plus d'ingrédients. 

 (Sous-requête pour trouver le MAX, puis HAVING pour filtrer.) */


SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
GROUP BY f.id_foccacia, f.nom
HAVING COUNT(c.id_ingredient) = (
    SELECT MAX(nb)
    FROM (
        SELECT COUNT(id_ingredient) AS nb
        FROM comprend
        GROUP BY id_foccacia
    ) AS sous_requete
);
/*
  Résultat  :
  Paysanne - 12
*/


/* REQUÊTE 8 - Afficher la liste des focaccias qui contiennent de l'ail. */

SELECT f.nom AS focaccia
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;
/*
  Résultat 5 focaccias contiennent de l'ail :
  Gorgonzollaccia
  Mozaccia
  Paysanne
  Raclaccia
*/



/* REQUÊTE 9 - Afficher la liste des ingrédients inutilisés */

SELECT i.nom AS ingredient_inutilise
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_foccacia IS NULL
ORDER BY i.nom ASC;
/*
  Résultat  :
  Salami     
  Tomate cerise 
*/


/* REQUÊTE 10 - Afficher la liste des focaccias qui n'ont PAS de champignons. */

SELECT f.nom AS focaccia
FROM foccacia f
WHERE f.id_foccacia NOT IN (
    SELECT c.id_foccacia
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;
/*
  Résultat 2 :
  Américaine 
  Hawaienne
*/

