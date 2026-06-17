# Zone d'ajustement des modèles de diapo



## Tâches

### 1. politique de pagination

par défaut, il n'y a pas de pagination

### 2. plain => section et titres

Ajouter au modèle plain une paramètre section

afficher en bas aligné à droite la section commun un pied de page

### 3. marges et titres

L'affichage des titres doit être uniforme peu importe le modèle.

Également, le respect des marges de sécurité est imposé à toutes les diapositives

Corriger le titre de `plain`. Il doit être comme le message de `remerciements`, mais aligné à gauche et touchant les bordures gauche et haut

### 5. numérotation

on numérote séquentiellement les sections et les diapositive:

<num_section>.<num_diapo_de_section>

On ne numérote pas les variations. Une variation garde inchangée la numérotation

Utiliser ce numéro dans l'affichage du titre:

<sec>.<diapo>  <Titre>

Utiliser ce numéro dans l'affichage de la section:


<sec>.  <Section>


### 6. fine tuning

Pour le numéro du titre, Utiliser la même police, couleur, taille, etc que le titre.


### 7. Ajout d'un modèle `tableau`

Le tableau est une extention de plain.

Permettant de:

- prendre les données d'un fichier structuré
- s'assurer d'un rendu lisible dans le pdf

Fonctionnalités:
- numérotation des tableaux
- prend les données dans un csv
- spécifie le ratio de l'espace occupé par les colonnes
- spécifie si on accepte les saut de ligne


Comportement attendu:

- Par défaut, le tableau occupe tout l'espace disponible horizontalement
- le tableau l'empète pas sur les marges
- le contenu ne déborde dans la vue pdf.
- S'il y a un débordement est identifié, je vois 2 manières de traiter:
  - déborder en Rapportant un warning en orange dans l'output de la commande
  - diminuer la police dynamiquement pour que tout le contenu rendre dans la page
- les variations entre `plain` et `talbeau` (dérivation de plain) sont possible et autorisés. C'est à dire que pour une même diapo on peut avoir des variations de modèle plain et d'autres tableau

TODO

1. implémenter le modèle `tableau`

2. convertir slide-05, variations 2 et 3, en `tableau`

### 8. fine tune + use it

pour améliorer la lisibilité des tableaux, une couleur de background très pâle sur les lignes en alternance

Ensuite converti toutes les variations qui on des tableau vers le modèle `tableau`

### 9. on ne voit pas la couleur des lignes impair

Appliquer une couleur de fond à toutes les lignes impair.

### 10. bug

Pourquoi ça ne marche pas?

Je ne vois pas la couleur sur le pdf.

Utiliser le rose pour tester

### 11. Fix numérotation

La numérotation n'est pas correcte.

Voici ce qu'il faut faire

format titre=> X.Y titre
format section => X. section

ordre: suivre l'ordre séquentiel ascendant des diapos de type `plain` ou dérivé de plain (tableau)

pour l'incrémentation, on considère: la diapo courante et la 

pour la première diapo / section , on commence à 1

1. incrément de section

à chaque fois que la section courrante est différente de la section précédente, X = X+1

2. incrément de diapo

à chaque fois que la diapo courrante est différente de la diapo précédente, Y = Y+1

### 12. glitch

- remettre en gris (noir noumanity 10%)
- mettre la couleur sur les lignes pair
