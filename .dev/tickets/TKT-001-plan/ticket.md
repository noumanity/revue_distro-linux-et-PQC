# Plan de la présentation

Nous allons définir le plan de la présentation

## proposition

Voici ce que j'ai en tête:

max 10 slides

### structure:

Pour l'instant, nous allons définir un plan complet (qui sera trop long) et fouiller en profondeur le sujet.

#### Section Intro

##### accroche 

Faire une blague en déstabilisant l'auditeur. On commence comme si la présentation n'avait rien à voir avec une présentation pour une audience linux.

 On montre un faux plan on commence par:

- démonstration du théorème de Shor
- exemple d'implémentation avec Qiskit
- lancer une exécution gratuitement sur l'ordinateur quantique de IBM de Bromont
- ...

puis la chute: mais non, c'est une blague...  **On utilise le mot quantique, mais il n'y a rien de quantique dans ce sujet.**

Seconde variation: les premiers éléments sont barrés

On présente le vrai plan qui est vraiment un plan normal, voir ordinaire pour une présentation plate de cybersécurité

- menaces
- risques
- composants impactés
- stratégie de mitigation
- roadmap PQC de quelques distros linux
- CBOM, scanners, exemples

#### Section Qu'est-ce que le PQC

##### Menace cryptographique

récit: 

- il y a actuellement une course pour briser les algos de crypto-graphie standard
- ce n'est pas la première fois que ça arrive. Raconter 1 ou 2 cas où un algo normé a été obsolète
- qu'est-ce qu'on a fait?... on l'a remplacé par un plus robuste => c'est le quotidien de la pratique en cybersécurité
- En plus, il y a une plusieurs qui tente d'améliorer les algo classiques pour atteindre des perofrmances prétenduement hors de portée du classique
- citer l'exemple: 
  - vulgarisé => https://phys.org/news/2026-05-quantum-supremacy-ran-unexpected-rival.html
  - peer-reviewed => https://www.science.org/doi/10.1126/science.adx2728
  - prépublication ouverte => https://arxiv.org/abs/2503.05693
- message => On gère, pas besoin de paniquer.

Découpage des variations:




##### Pourquoi c'est sérieux

- le risque est incertain...
- MAIS les conséquences du worst case seraient catastrophiques pour l'économie mondiale
- citer une étude de worst case scénario d'un "effondrement quantique"
- En plus il y a le risque HNDL
- Donc, le temps de vie des données est important.
- Une approche cyber complète tient compte de la classification des données. Mais la présentation ici on se limite aux outils de cryptographie


##### Des enjeux bien pris en charge

2 aspects à mettre de l'avant:

- Effort des organismes de normalisation avec exemples: NIST + équivalents européens, algos FPIS
- Leadership Canadien en matière de déploiement: roadmap et exigeance de conformité

##### Les concepts clefs en PQC

Rapporter les concepts important du domaine tels qu'ils sont exprimés dans le milieu PQC:

- Q-Day
- crypto agilité
- etc


#### Section: La position canadienne dans le quantique

Le Canada est leader dans le domaine quantique

- revue recherche Sherbrooke + ontario
- politique actuelle: communication quantique + ...
- position de Québec: triangle Québec - Sherbrooke - Montréal

#### Section: Linux OS

##### Objectif et méthodologie

Sélection des OS: choix retenus

Axes d'analyse à considérer

##### Où se trouve la crypto dans une distribution linux et à quoi elle sert

Selon les cas d'usage. Faire une liste exhaustive des cas d'usage, puis restreindes le 

##### Composants 

OpenSSL, GnuTLS, OpenSSH, le noyau


#### Section Démo : 