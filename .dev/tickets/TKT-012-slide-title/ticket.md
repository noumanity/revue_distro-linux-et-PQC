# Slide 00 : titre

## Contexte

on a besoin d'une page de présentation qui doit contenir:

- le titre: Comment les distributions Linux s'adaptent-elles au "risque quantique"?

- liste des auteurs:
  - Jérémy Viau-Trudel - Spécialiste DevSecOps
  - André Gerges - Conseiller en recherche en cybersécurité et conformité
  - Ikram Zahiri - Étudiante en génie logiciel

- date et heure: mercredi 17 juin 17h
- endroit: Québec - au Paccini de Ste-Foy

- préparé pour : Rencontre Linux Québec

- logo présentateur: @src/assets/noumanity-norma.svg
- logo organisateur: @"src/assets/Rencontres Linux au Québec.webp"

## Tâches

### 1. créer le modèle 

Adapté le modèle `title` pour pouvoir afficher toutes ces informations

Designer une mise en page moderne, aérée.

Le titre doit être le plus lisible

Ensuite les auteurs

Finalement les autres informations

Les logos sont en bas à droite, pas trop gros, max 1/6 de la hauteur totale

Implémenter

### 2. ajustements

- pas de background
- par de barre horizontale
- le titre plus gros
- tous les items du bloc auteurs doivent ête alignés à gauche
- le bloc lui même reste centré
- descendre un peu les logos: il y a actuellement collision entre logos et date + heure

### 3. ajustements mineurs

- Utiliser la fonte Abeezee pour le titre et arimo pour toule reste
- grossir le tire de 1.75x et justifier à gauche
- diminuer le logo présentateur de -0.5x, laisser le logo organisateur comme ça

### 4. fine tuning

- titre: diminuer la fonte de 0.25x. diminuer (éliminer max) l'espassement interligne
- aligner en bas le bloc evenement. utiliser la même baseline que le bock logos
-block logos: les 2 logos doivent avoir le même baseline
