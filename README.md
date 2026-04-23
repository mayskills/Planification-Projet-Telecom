# Planification Capacitaire Projet Télécom - Sénégal

## Objectif du projet

Ce projet vise à analyser la charge des équipes projet télécom au Sénégal afin de :

- Identifier les situations de **sur-allocation (>100%)**
- Détecter les conflits entre **affectations et congés**
- Optimiser la **planification des ressources humaines**
- Améliorer la **rentabilité des projets**

## Contexte métier

Dans les projets télécom (déploiement réseau, fibre, 4G/5G), la planification capacitaire est essentielle :

- Les ressources sont limitées et hautement spécialisées  
- Les projets ont des délais stricts imposés par les opérateurs  
- Une mauvaise allocation peut provoquer des **retards critiques**  
- Les surcharges entraînent une baisse de productivité et des erreurs  
- L’optimisation des ressources impacte directement la **rentabilité projet**

  
## Modélisation de la base de données

### Tables principales

#### `collaborateurs`
- `id_collab` (PK)
- nom, prenom
- competence_principale
- taux_journalier
- cout_interne
- date_entree
- localisation

#### `projets`
- `id_projet` (PK)
- nom_projet
- client (Orange SN, Free SN, Expresso, Yas SN)
- date_debut_prev, date_fin_prev
- budget_jh
- statut

#### `affectations`
- `id_affect` (PK)
- `id_collab` (FK → collaborateurs)
- `id_projet` (FK → projets)
- date_debut, date_fin
- pct_allocation
- role_projet

#### `conges`
- `id_conge` (PK)
- `id_collab` (FK → collaborateurs)
- date_debut, date_fin
- type_conge

## Relations clés

- Un **collaborateur** peut avoir plusieurs **affectations**
- Un **projet** peut avoir plusieurs **collaborateurs**
- Un **collaborateur** peut avoir plusieurs **congés**

```mermaid
erDiagram
COLLABORATEURS ||--o{ AFFECTATIONS : "affecté"
PROJETS ||--o{ AFFECTATIONS : "contient"
COLLABORATEURS ||--o{ CONGES : "prend"
