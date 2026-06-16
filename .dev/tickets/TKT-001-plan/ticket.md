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

...

## Tâches

### 1. Avancer vers le plan de la présentation

#### Contexte

Je sais exactement (du moins intuitivement) ce que je veux communiquer. Mais lorsque je tente de le mettre par écrit, j'ai de la difficulté. Voici ce qui se produit:

- J'ai trop d'idées alors la sélection du contenu pour que ce ne soit pas trop long est difficile,
- Mon premier réflexe est de tout mettre sur la table (divergence) pour en extraire l'essentiel par la suite (convergence).
- Je suis convaicu que cette méthode est bonne et adaptée à ma façon de penser. Mais, d'un point de vue opérationnel, ça cause des difficultés parce que:
  - c'est trop long
  - je continue toujours à diverger, ça n'arrête jamais,
  - il faut que je mette un frein à la divergence, mais ça fait que mon travail n'est pas fini et ça me frustre et je ne suis pas satisfait.
  - j'accorde peut-être trop d'importance à terminer à la perfection les étapes intermédiaires de travail...

La section "## structure" se voulait d'abord une ébeauche de plan de présentation, puis le contenu des 10 diapos, puis s'est transformé finalement en ébeauche d'un document complet sur PQC + Linux...

Je dois rapidement recentrer le travail. Voici ce que nous allons faire =>

#### TODO

1. Clarifier les objectifs de communication et les mettre au centre de notre travail pour accélérer:

- objectif ultime: être perçu comme la référence en matière PQC par les décideurs en cybersécurité
- objectif opérationnel: livrer et performer une présentation intéressante et irréprochable à la communauté linux du Québec

2. Produire l'argumentaire / le récit que la présentation doit supporter (end in mind, what matters)

3. Produire un plan de présentation en 10 diapos.

4. Pour chaque diapo, produire le contenu détaillé sous forme de verbatim.

Mettre ces 4 livrables dans le répertoire `@.dev/artefacts`. 
 