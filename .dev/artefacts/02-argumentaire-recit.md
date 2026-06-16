# Argumentaire et récit (le fil que la présentation doit supporter)

> **Livrable 2/4 de la tâche 1 du ticket [TKT-001-plan](../tickets/TKT-001-plan/ticket.md).** On fixe ici le **récit** et le **what matters** (end in mind), avant de découper en diapos (livrable 3) et de rédiger le verbatim (livrable 4). S'appuie sur les fondations sourcées du dépôt.

## 1. La thèse (une phrase)

**Le « PQC », ce n'est pas du quantique : c'est de l'ingénierie de cybersécurité bien comprise, déjà en cours, et nous la maîtrisons.**

Tout le récit sert cette thèse. Si une diapo ne la renforce pas, elle sort.

## 2. Le what matters (ce que l'audience doit retenir)

Trois idées, dans cet ordre de priorité.

1. **Démystifier** : la menace quantique sur la cryptographie est réelle mais **gérable** ; remplacer un algorithme cassé est le **quotidien** de la cybersécurité, pas une apocalypse.
2. **Responsabiliser** : il faut agir **maintenant** à cause du « Harvest Now, Decrypt Later », parce que la **durée de vie des données** crée une exposition présente même si l'ordinateur quantique est futur.
3. **Rassurer et crédibiliser** : les outils existent (standards, crypto-agilité), le **Canada est un leader** du domaine, et nous (noumanity) savons exactement quoi faire.

Effet visé sur l'audience prioritaire : « ces gens-là maîtrisent le sujet de bout en bout, calmement ; ce sont les bonnes personnes à appeler ».

## 3. Le récit en sept actes

### Acte 1 : le renversement (accroche)

On ouvre comme une conférence quantique intimidante : faux plan affichant « démonstration du théorème de Shor », « implémentation Qiskit », « exécution sur l'ordinateur quantique d'IBM à Bromont ». Puis la chute : **non, c'est une blague ; on utilise le mot quantique, mais il n'y a rien de quantique dans ce sujet.** On barre le faux plan et on révèle un vrai plan, volontairement **ordinaire** pour une présentation de cybersécurité : menaces, risques, composants impactés, mitigation, roadmap PQC des distros, CBOM. Fonction : désamorcer l'intimidation, créer la complicité, planter la thèse dès la première minute.

### Acte 2 : la menace, sans drame

Il y a une course pour casser les algorithmes cryptographiques standards. **Ce n'est pas la première fois.** MD5 et SHA-1 sont tombés (collisions), DES a été abandonné pour AES, RC4 a été déprécié dans TLS. À chaque fois, on a **remplacé** l'algorithme par un plus robuste : c'est le **métier**. La menace quantique précise : l'algorithme de Shor **casse** la cryptographie asymétrique (RSA, courbes elliptiques) ; l'algorithme de Grover **affaiblit seulement** le symétrique (AES, hachage), parade simple en doublant les tailles de clés (cf. [FND-010](../fondations/FND-010-risque-quantique-notion-et-prise-en-charge.md), [FND-001](../fondations/FND-001-recherche-preliminaire-pqc-distributions-linux.md)). Nuance honnête : le **classique progresse aussi** (des méthodes classiques, réseaux tensoriels et propagation de croyance, ont récemment rivalisé avec une revendication de suprématie quantique). Message : **on gère, pas besoin de paniquer.**

### Acte 3 : pourquoi c'est quand même sérieux

Le moment du « Q-Day » est **incertain** (estimations d'experts : 28 à 49 pour cent de probabilité d'un ordinateur quantique pertinent d'ici dix ans, cf. FND-010). Mais le **pire cas** serait catastrophique pour l'économie mondiale, et surtout il y a le **HNDL** : un adversaire **capte aujourd'hui** des données chiffrées pour les déchiffrer plus tard. Donc la **durée de vie de confidentialité des données** rend le risque **présent**. L'outil de décision est l'**inégalité de Mosca** : si la durée de vie des données plus le temps de migration dépasse le temps avant le Q-Day, on est déjà en retard. Clin d'oeil : Michele Mosca est **canadien** (Institut for Quantum Computing, Waterloo). Cadrage assumé : on se limite aux outils de cryptographie ; la classification des données relève d'une approche cyber plus large.

### Acte 4 : des enjeux déjà bien pris en charge

Deux preuves que le monde s'organise. **Normalisation** : le NIST a publié en 2024 les premiers standards PQC (FIPS 203 ML-KEM, FIPS 204 ML-DSA, FIPS 205 SLH-DSA) ; les équivalents européens (BSI, ANSSI, ETSI) suivent. **Vocabulaire du milieu** : Q-Day, crypto-agilité (la capacité à changer d'algorithme vite), inventaire cryptographique. Message : ce n'est pas un far west ; c'est un chantier cadré.

### Acte 5 : la fierté canadienne (et québécoise)

Le Canada est un **leader** du quantique. Le triangle **Québec - Sherbrooke - Montréal** : l'Institut quantique de l'Université de Sherbrooke et la zone d'innovation **Distriq**, un ordinateur quantique **IBM à Bromont**, et une **Stratégie quantique nationale** dont la feuille de route inclut explicitement la communication quantique et la **cryptographie post-quantique**. Et le cadre de risque qu'on vient d'utiliser (Mosca) vient d'ici. Fonction : fierté locale pour la communauté, signal de sérieux pour les décideurs.

### Acte 6 : Linux, le concret

Où vit la cryptographie dans une distribution, et à quoi elle sert. Les **composants** : OpenSSL, GnuTLS, OpenSSH, le noyau. La leçon des fondations : le PQC **descend de l'amont** (OpenSSL 3.5 et OpenSSH 10, sortis en 2025) vers les distributions, à une vitesse fixée par leur modèle de publication. **RHEL mène** (il signe déjà ses paquets avec une signature post-quantique hybride) ; les rolling suivent tôt ; Ubuntu et Debian au rythme de leurs stables (cf. [FND-009](../fondations/FND-009-pqc-par-categorie-dimages.md), [FND-011](../fondations/FND-011-pqc-soixante-images-par-categorie.md)). Fonction : contenu technique crédible qui capte la communauté Linux.

### Acte 7 : passer à l'acte, et l'appel

On ne migre pas ce qu'on ne connaît pas : la première étape concrète est l'**inventaire cryptographique** (CBOM), démontrable avec des scanners (cf. [FND-006](../fondations/FND-006-outils-cbom-scan-panorama-comparaison.md)). La vraie capacité à bâtir n'est pas « installer du PQC » une fois, c'est la **crypto-agilité**. Chute et appel : le PQC est une **migration d'ingénierie maîtrisable** ; nous sommes les experts PQC au Québec ; parlons-nous.

## 4. Le motif récurrent

Un fil rouge tient les sept actes : **démystifier, responsabiliser, rassurer**. On enlève la peur (acte 1 et 2), on installe l'urgence juste (acte 3), puis on montre que tout est sous contrôle et que la compétence existe ici (actes 4 à 7). Le ton constant : **calme, compétent, un brin malicieux**. C'est ce ton, plus que n'importe quel fait isolé, qui produit la perception « référence PQC ».

## 5. Ce que le récit écarte volontairement

Pour tenir dix diapos et garder le fil, on **n'expose pas** : la démonstration du théorème de Shor, le détail mathématique des réseaux euclidiens, un panorama des soixante images (il reste dans FND-011), la classification des données, la cryptographie quantique (QKD) qui n'est pas le sujet. Ces éléments restent disponibles pour le matériel de suivi.
