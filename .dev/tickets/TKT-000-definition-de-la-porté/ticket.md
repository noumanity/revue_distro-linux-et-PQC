# Définir la portée de ce repo

> ## ✅ Ticket clôturé — 2026-06-12
> Toutes les tâches (1 à 7) sont réalisées.
> Livrables : [`/README.md`](../../../README.md), [`/abstract.md`](../../../abstract.md)
> (référence), [`01-premier-jet.md`](01-premier-jet.md) (matériel de promotion),
> [`/.dev/fondations/FND-001-recherche-preliminaire-pqc-distributions-linux.md`](../../fondations/FND-001-recherche-preliminaire-pqc-distributions-linux.md).

## Contexte

Nous allons présenter aux Rencontres Linux du Québec:

> Revue des effets du "risque quantique" sur le roadmap des grandes distributions Linux

## Problématique

Fournir les informations nécessaires à la promotion de l'évènement:

- nom du présentateur: Jérémy Viau-Trudel => https://www.linkedin.com/in/jvtrudel/
- photo => https://media.licdn.com/dms/image/v2/D4E03AQECsDfKLjHphg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1712225837200?e=1782950400&v=beta&t=YW_dbRFkgpeTGhZYMHMlKhkclFSSRMd6_NBYvgomqd0
- Titre de la présentation
- Abstract


## Tâches

### 1. premier jet ✅

À partir des informations disponible, esquisser une première version.

Générer tous les fichiers de travail dans le répertoire du ticket.

### 2. Présision sur la conférence ✅

- durée: 30 minutes incluant une partie "démonstration"
- audience: communauté linux de la ville de Québec (présentiel) et de tout la province de Québec (en ligne). Niveaux: amateurs à professionnels. 
- voix: Amicale, accessible, mais très rigoureux pour tout ce qui est technique
- contraintes: les informations communiquer et la maitrise du sujet doit être irréprochable
- objectifs de communication:
  - informer de ce qu'est la "menace quantique"
  - montrer que c'est une réalité et que c'est un sujet pris au sérieux pas les éditeurs de distribution
  - rassurer: c'est simplement un enjeu de modernisation des infrastructure de cryptographie
  - appel à l'action: contactez-moi si vous voulez parler de ce sujet
- contenu:
  - ajouter également un volet des distributions spécialisées pour les images de conteneurs

Adapter pour tenir compte de ces éléments.

### 3. Bio de l'auteur ✅

- Récupérer les informations de l'auteur à partir de l'url.
- Afficher la photo dans le document.
- Rédiger une section "biographie" qui fait ressortir les éléments pertinent avec la présentation

### 4. Utiliser le CV ✅

La biographie n'est pas représentative et contient de nombreuses erreurs factuelles. 
Utiliser le document @CV Long... et réécrire complètement.

Les points à mettre en évidences:
- Études et recherche de haut niveau en chimie quantique: simulation électronique en champ laser intense. => C'est là que j'ai commencé à utiliser linux
- depuis 10 ans: professionnel en TI, consultant spécialisé linux. intervenu en DevSecOps à plusieurs reprises. et ce tant on-prem, en infonuagique que en edge computing
- depuis 5 ans développe un "Studio DeepTech" dans lequel il travaille sur des sujets complexes.


### 5. Recherche préliminaire ✅

Faire une recheche exhaustive sur les sujets suivants:
- distributions linux, leur usage/spécialisation et le roadmap de développement de chacune
- Inrégration des enjeux PQC dans les OS représentatifs

Écrire un essaie dsur le sujet et déposer le dans le répertoire @.dev/fondations

Est-ce que toutes les distributions ont intégrer la modernisation crypto? Lesquelles sont le plus avancé? Y en a-t-il qui se distingues sur le sujet.


### 6. Inclure + de distributions ✅

La recherche précédente semble très limité. Inclure RockyLinux. Prendre la liste des 20 images linux et des 10 images de conteneurs les plus utiliser et les inclure dans l'essaie


### 7. Définir la portée du repo ✅


L'unique objectif de ce répo est de produire la présentation, de la partager et de partager tout matériel complémentaire.

Rédiger un readme pour communiquer rapodement et succintement la portée et les objectifs du repo.

Considérer la version écrite manuellement dans @abstract.md comme version de référence.