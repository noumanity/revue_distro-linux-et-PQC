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

### 2. Préciser le plan à haut niveau

#### Voici ce qui ne fonctionne pas

##### [directive transversale] Linux et l'application de la cybersécurité doivent être au premier plan, pas le quantique

- équilibre entre PQC vs linux
- équilibre théorique / philosiphique vs méthodologique vs pratique

##### [transversal] Le récit

- les actes 1,2 et 3 sont fortement liés
- le contenu de acte 2 est revue en profondeur. voir section "diapo 3" plus bas
- acte 4: recadrage du message => regardez, l'enjeu est pris en charge, voici comment. Message pour décideurs-cyber => Et vous? Êtes-vous parmis ceux qui prenne en charge PQC ou non?
- on laisse tombé le contenu de l'acte 5. Ce n'est pas un sujet à mettre de l'avant ici.
- acte 6 devrait être le coeur de la présentation. Développer
- acte 7: la présentation de termine par une démo. le récit: "nous allons vous montrer comment vérifier le PQC. Vous serez capable de la faire vous même".  On donne une vrai compétence utilisable par les participants à leur retour à la maison. Message pour les décideurs => nous livrons de la valeur directement applicable dans votre entreprise pour améliorer votre prise en charge PQC.


##### diapo 1: on conserve


##### diapo 2: on conserve

##### diapo 3: on change l'angle d'approche

On conserve l'idée de dédramatiser. Mais change d'angle. On laisse tombé l'illustration historique. On l'applique concrètement en développant la notion de "risque quantique". 

message pour audience décideurs-cybersécurité: prendre en charge le PQC est un impératif urgent de gestion de risque + le PQC impose de vérifier notre chaine d'approvisionnement logiciel -> premier pas vérifier

On change la perspective:
- le risque quantique est un déclencheur,
- l'enjeu réel c'est la gestion du la cryptographique
- il y a un danger important => ne pas agir -> enchainement possible sur HNDL / qu'est-ce qui arriverait si on agissait pas maintenant ?

Voir TKT-010 section "penser la menace quantique"

##### diapo 4: le message -> agir maintenant maintenant

On passe de "tell" -> c'est sérieux,  à "show" -> communauté cyber internationnal + autorités canadiennes prennent cet enjeu au sérieux

- [interaction avec audience] Qu'est-ce qui arriverait si on n'agissait pas dès maintenant?
- La communauté internationale de cybersécurité a agit -> voici comment
- les autorités canadiennes ont agit -> voici comment (roadmap de CCCS et obligations contraignante)

message à décideurs-cybersécurité => C'est un enjeu important. Est-ce qu'il est couvert par vos processus cyber? Fait-il partie de vos axes d'analyse, de vos veilles stratégiques?

##### diapo 5: recadrage nécessaire

On passe immédiatement à "du concret linux". 

voici ce dont la diapo 5 traitera:

- Message à decideurs-cyber => linux est une infrastructure stratégique fondamentale et irremplaçable -> [conséquence] il faut l'entretenir. donc investir dans son entretien.
- coeur du contenu: les 6 catégories d'usage de linux
- l'importance, le rôle et l'implémentation de la crypto dépend grandement de la catégorie d'usage et chaque type d'usage comporte ses défis
- inclure 2 tableaux:
  - catégorie, distributions dominantes, usage, importance stratégique 
  - catégorie, distributions, usage crypto, défis cryptos
- message audience linux: Vous devez comprendre

##### diapo 6: recadrage nécessaire

On arrive dans le vif du sujet et la technique.

- Message à décideurs-cyber => les équipes opérationnels linux ont besoin d'une formation basique de linux-PQC. En 1 journée de formation, ça leur permet de prendre en charge 80% du risque opérationnel. Et ça fait les rend capable d'identifier et de remonter le risque à équipe cyber.

- Malgré la diversité des distributions, on a seulement un petit nombre de "briques logicielles" à considérer
- décrire à haut niveau (1 tableau)
- ensuite (en raison de upstream/downstream), "le flux de mise en production des améliorations" dépend de 
- caractériser le "flux":
  - feuille de route (choix stratégique de l'éditeur)
  - modèle de publication
- tableau: categorie, distro, modèle de publication, feuille de route PQC


- messages à audience linux:
  - connaissez-vous la feuille de route PQC?
  - est-ce que le doublet roadmap+publication est cohérent avec vos besoins de protection (sécurité des données)

##### diapo 7: Le + technique

On conserve.

Explique en détail et techniquement ce que sont les "briques fondamentales de la crypto linux".

tableau: brique (librairie), no de version début PQC, fonctionalité PQC livrées + no de version, next PQC sur roadmap.

Contenu le + important pour audience linux.

On étend au besoin.


##### diapo 8 -> tableau recapitulatif

tableau similaire à ceux de diapo 5
 
tableau:  catégorie, distributions, maturité PQC (meneur, challenger ou à la traine), pourquoi ?


#### diapo 9 -> diapo démo

la démo fait l'objet d'une préparation à part.

on utilise "diapo demo" comme placeholder 

##### conclusion et appel

diapo x: ne pas compter dans les 10

#### TODO

On retravaille les 4 documents dans `@.dev/artefacts/`

On concerve inchangé les objectifs de comm 01.

On prend en compte les directives et commentaires précédents pour réécrire:

- le récit 02
- le plan 03, et
- le verbatim 04

### 3. 2e round d'ajustement

#### Feedback de la dernière révision

##### Considérations tactiques de communication (motifs récurents) 

1. Ajouter: tactique rhétorique pour l'appel l'action et pour établir notre crédibilité

-> DÉCISION: On adopte la stratégie décrite à la section "leitmotiv" de TKT-010.

2. recadrer -> responsabilisé -> outiller

-> Décision: adopté

3. posture expert spécialiste de référence

calme, concret, compétent

-> décision: adopté

##### Le récit

Décision: maturité suffisante

TODO:

- adapter pour bien exprimer la tactique de communication
- réécrire pour supprimer les références aux versions précédente
- on vise une version finale: auto-cohérent, audience: noumanity&co

##### Le plan

Décision: maturité suffisante

TODO:

généralités:

- réécrire pour supprimer les références aux versions précédente
- on vise une version finale: auto-cohérent, audience: noumanity&co

Ajustements mineurs:

- objectif de la diapo: doit être l'objectif de la diapo
- pour chaque diapo, mettre message décideurs-cyber + message communauté-linux


#### TODO

Mettre à jour les documents `@.dev/artefacts/*`

- ne pas toucher à 01
- mettre 02 et 03 au propre pour une audience noumanity&co (équipe de préparation de la présentation) en tenant compte des directives et commentaires du ticket
- dans 04-verbatim, estimer le temps nécessaire pour présenter chaque diapositive

### 4. Pré-requis au plan de communication

Produire un Essai de Fondation Exhaustif à propos du plan de communication

Tenir compte des cadres théoriques et méthodologiques suivants:
- communication stratégique
- communication professionnelle
- analyse bourdieusienne (identifier les champs pertinents, les acteurs et positions dans chaque champs, leurs pratiques, habitus, capital, illusio et doxa)
- les pilliers de la communication


Rechercher et inclure tous les autres cadres théoriques pertinents qui n'ont pas été mentionnés ci-haut.

Adapté pour les contextes: 
- développement d'affaire en technologie de l'information, cybersécurité, en grande entreprise et gouvernemental
- communauté techniques
- communauté linux
- ville de Québec
- startup de service
- posture de leadership

### 5. Plan de communication

01 objectifs de comm devient => Plan de communication

S'appuyer sur le cadre théorique de  FND-012

- extraire les éléments de tactique de comm du document "02 récit" et les inclure dans le plan de communication

Dans le répertoire du ticket, produire une analyse critique de "03 plan de présentation" en confrontant les éléments théorique de FND-012, les objectifs de comm de 02 et la performance envisagée par 03.