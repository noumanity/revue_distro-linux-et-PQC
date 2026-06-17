# Slide Remerciement

## Contexte


On veut une page avec écrit en haut assez gros: "Merci de prendre au sérieux la 'menace' quantique"

Puis, au centre de la page, focus de l'attention: "Questions?"

pas de titre

En bas à droite, afficher un code qr (1/5 de la hauteur max) pointant vers => https://github.com/noumanity/pqc-linux 
avec l'url écrit en dessous de l'url






## Tâches

### 1. Modèle de remerciement

Créer un modèle `remerciements` qui implémente cette diapo de remerciements et implémenter dans slide-12

### 2. Ajustements

- augmenter la taille du message de 0.5x
- afficher l'url sans le protocol 'https'. Mais il doit être dans le code qr

### 3. fine tuning

- diminuer le message de -0.2x
- éliminer l'espace interligne du message
- respecter la bordure en haut
- le focus doit être parfaitement au centre de la page

### 4. correction glitch

Pourquoi le message est au centre?

Voici ce qui est attendu:

- tous les diapos on une bordure de "sécurité-affichage" des quatre côtés. Aucun contenu de doit empiété sur cette bordure
- le message doit être aligné vers le haut, collé sur la bordure supérieur