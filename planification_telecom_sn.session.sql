-- 2. Création des tables
-- Table Collaborateurs

CREATE TABLE collaborateurs (
    id_collab SERIAL PRIMARY KEY, -- identifiant collaborateur
    nom VARCHAR(50), -- nom collaborateur
    prenom VARCHAR(50), -- prénom collaborateur
    competence_principale VARCHAR(100), 
    taux_journalier NUMERIC(10,2),
    cout_interne NUMERIC(10,2),
    date_entree DATE,
    localisation VARCHAR(50) -- Adresse
);

-- Table projets
CREATE TABLE projets (
    id_projet VARCHAR(10) PRIMARY KEY,
    nom_projet VARCHAR(100),
    client VARCHAR(50),
    date_debut_prev DATE,
    date_fin_prev DATE,
    budget_jh INTEGER,
    statut VARCHAR(50)
);

-- Table affectations
CREATE TABLE affectations (
    id_affect SERIAL PRIMARY KEY,
    id_collab INTEGER REFERENCES collaborateurs(id_collab),
    id_projet VARCHAR(10) REFERENCES projets(id_projet),
    date_debut DATE,
    date_fin DATE,
    pct_allocation INTEGER,
    role_projet VARCHAR(50)
);

-- Table conges
CREATE TABLE conges (
    id_conge SERIAL PRIMARY KEY,
    id_collab INTEGER REFERENCES collaborateurs(id_collab),
    date_debut DATE,
    date_fin DATE,
    type_conge VARCHAR(20)
);

-- 3. Vérification des données

 -- La base de données

SELECT 1
FROM pg_database
WHERE datname = 'planification_telecom_sn';

 -- Tables
 SELECT *
 FROM collaborateurs;

 SELECT *
 FROM affectations;

 SELECT *
 FROM projets;

 SELECT *
 FROM conges;

-- 4. Insertion des données via le terminal
-- 5. Vérification des données
SELECT *
 FROM collaborateurs;

 SELECT *
 FROM affectations;

 SELECT *
 FROM projets;

 SELECT *
 FROM conges;

 -- 6. Questions

 -- a. Afficher tous les collaborateurs basés à Dakar
  SELECT *
  FROM Collaborateurs
  WHERE localisation = 'Dakar';

 -- b. Trouver les 5 collaborateurs les plus chers (taux_journalier)

 SELECT *
 FROM collaborateurs
 ORDER BY taux_journalier DESC
 LIMIT 5;

 -- c. Calculer le coût interne moyen des collaborateurs

 SELECT AVG(cout_interne)
 FROM collaborateurs;

 SELECT ROUND(AVG(cout_interne),2) AS cout_moyen
 FROM collaborateurs;

 -- d. Compter le nombre de projets par client

 SELECT client, COUNT(client)
 FROM projets
 GROUP BY client;

 SELECT client, COUNT(*) AS nb_projets
 FROM projets
 GROUP BY client;

 -- e. Trouver le budget total (en JH) de tous les projets
 
 SELECT SUM(budget_jh) AS BUDGET_TOTAL
 FROM projets;

 -- f. Identifier les collaborateurs affectés à plus de 100% en avril 2026

 SELECT 
    id_collab,
    SUM(pct_allocation) AS total_allocation
FROM affectations
WHERE date_debut <= '2026-04-30'
AND date_fin >= '2026-04-01'
GROUP BY id_collab
HAVING SUM(pct_allocation) > 100;

 -- g. Trouver le collaborateur avec la plus forte allocation
 
SELECT 
    id_collab,
    SUM(pct_allocation) AS total_allocation
FROM affectations
GROUP BY id_collab
ORDER BY total_allocation DESC
LIMIT 1;

 -- h. Lister les congés en avril 2026

 SELECT *
 FROM conges
 WHERE date_debut >= '2026-04-01' 
 AND date_fin <='2026-04-30';

 -- i. Identifier les collaborateurs en congé et affectés sur un projet en même temps
SELECT DISTINCT Cl.prenom, Cl.nom
FROM collaborateurs Cl
JOIN affectations A ON Cl.id_collab = A.id_collab
JOIN conges Cg ON Cg.id_collab = A.id_collab
WHERE Cg.date_debut <= A.date_fin
AND Cg.date_fin >= A.date_debut;

 -- j. Top 3 projets avec le plus de charge (somme des allocations)

 SELECT P.nom_projet, SUM(A.pct_allocation) AS SOMMEALLOC
 FROM affectations A
 JOIN projets P ON P.id_projet = A.id_projet
 GROUP BY P.id_projet
 ORDER BY SOMMEALLOC DESC
 LIMIT 3;
