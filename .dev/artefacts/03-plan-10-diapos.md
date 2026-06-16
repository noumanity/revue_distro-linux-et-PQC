# Plan de présentation en dix diapos

> **Document de travail pour l'équipe de préparation (noumanity&co).** Plan détaillé diapo par diapo. Il met en oeuvre la tactique de communication du récit ([02](02-argumentaire-recit.md)) ; le verbatim est en [04](04-verbatim-par-diapo.md) ; le plan de communication en [01](01-plan-de-communication.md). Chaque diapo porte un objectif propre, un message pour les décideurs en cybersécurité, un message pour la communauté Linux, et une déclinaison du leitmotiv.

## Conventions

- **Comptage** : diapos 1 à 9 numérotées ; la conclusion et appel est une diapo `x` qui ne compte pas dans les dix.
- **Six catégories** (diapos 5, 6 et 8) : les six catégories canoniques du projet (entreprises et HPC, communautaires et indépendantes, conteneur, mobile, IoT et embarqué, spécialités notables ; cf. [FND-011](../fondations/FND-011-pqc-soixante-images-par-categorie.md)).
- **Leitmotiv** : la question « qu'arriverait-il si on n'agissait pas ? » est déclinée à chaque diapo où elle a du sens, suivie d'un « voici comment, c'est faisable », pour installer un appel à l'action implicite (cf. 02, section 2).

## Vue d'ensemble

| # | Titre | Message clé |
|---|---|---|
| 1 | Accroche : fausse conf quantique | « Rien de quantique ici » |
| 2 | Le vrai plan, volontairement ordinaire | C'est de la cybersécurité Linux |
| 3 | Repenser : le risque quantique, déclencheur | Le vrai sujet est la gestion de la crypto |
| 4 | C'est déjà pris en charge, et vous ? | Le monde et le Canada ont agi |
| 5 | Linux, infrastructure stratégique | À entretenir, donc à financer |
| 6 | Le flux upstream vers downstream | Peu de briques ; roadmap plus publication |
| 7 | Les briques de la crypto Linux | Où et depuis quelle version le PQC arrive |
| 8 | Carte de maturité PQC par catégorie | Qui mène, qui suit, pourquoi |
| 9 | Démo : vérifier le PQC soi-même | Une compétence à rapporter |
| x | Conclusion et appel | Valeur applicable ; parlons-nous |

## Détail des diapos

### Diapo 1 : l'accroche

- **Objectif** : désamorcer l'intimidation et créer la complicité dès la première minute.
- **Message décideurs** : ce sujet n'est pas réservé aux physiciens ; restez, ça vous concerne.
- **Message communauté** : on est entre nous ; ceci est une vraie présentation de cybersécurité.
- **Contenu** : faux plan intimidant (théorème de Shor, implémentation Qiskit, exécution sur l'ordinateur quantique d'IBM à Bromont), puis chute. Variation : les items se barrent un à un.

### Diapo 2 : le vrai plan, volontairement ordinaire

- **Objectif** : énoncer la thèse et le fil conducteur.
- **Message décideurs** : ce qui suit est un sujet de gestion, pas de laboratoire.
- **Message communauté** : le quantique n'est qu'une porte d'entrée ; le sujet est Linux.
- **Contenu** : « on dit quantique, mais il n'y a rien de quantique ici » ; le vrai plan, sobre à dessein.

### Diapo 3 : repenser la menace comme un risque

- **Objectif** : recadrer la menace quantique en problème de gestion du risque cryptographique.
- **Message décideurs** : prendre en charge le PQC est un impératif urgent de gestion du risque, qui impose de vérifier sa chaîne d'approvisionnement logiciel ; premier pas, vérifier.
- **Message communauté** : ce n'est pas de la physique ; c'est la solidité du socle crypto que vous opérez tous les jours.
- **Leitmotiv** : qu'arriverait-il si on n'agissait pas du tout ? (le HNDL rend l'exposition présente).
- **Contenu** : le risque quantique est un déclencheur ; l'enjeu réel est la gestion de la cryptographie. Malaise car il touche le socle. Double risque : négliger (déni, peur, non-priorité) ou se laisser paralyser par le battage. Danger immédiat : l'inaction. Source : [FND-010](../fondations/FND-010-risque-quantique-notion-et-prise-en-charge.md) et la section « penser la menace quantique » de [TKT-010](../tickets/TKT-010-redaction-des-slides+verbatim/ticket.md).

### Diapo 4 : c'est déjà pris en charge, et vous ?

- **Objectif** : prouver par l'exemple que l'enjeu est cadré, et renvoyer la responsabilité à l'auditeur.
- **Message décideurs** : cet enjeu est-il couvert par vos processus cyber, vos axes d'analyse, vos veilles stratégiques ?
- **Message communauté** : les standards existent et sont déjà dans vos outils ; ce n'est pas de la science-fiction.
- **Leitmotiv** : qu'arriverait-il si on était les seuls à ne pas agir ? Puis : voici comment les autres s'y prennent.
- **Contenu** :
  - [interaction] « Qu'arriverait-il si on n'agissait pas dès maintenant ? »
  - La communauté internationale a agi : standards NIST (FIPS 203 ML-KEM, 204 ML-DSA, 205 SLH-DSA, 2024), équivalents BSI, ANSSI, ETSI, déclaration du G7.
  - Les autorités canadiennes ont agi : feuille de route du Centre canadien pour la cybersécurité (ITSM.40.001, en vigueur le 23 juin 2025) avec obligations contraignantes pour les systèmes du gouvernement (migrer toute la cryptographie à clé publique) ; guide aux organisations (ITSAP.00.017).

### Diapo 5 : Linux, infrastructure stratégique

- **Objectif** : établir Linux comme infrastructure stratégique et montrer que le rôle de la crypto dépend de l'usage.
- **Message décideurs** : Linux est une infrastructure fondamentale et irremplaçable ; il faut l'entretenir, donc investir dans son entretien.
- **Message communauté** : vous devez comprendre où vit la crypto selon l'usage ; chaque catégorie a ses défis.
- **Leitmotiv** : qu'arriverait-il si on laissait ce socle stratégique sans entretien ?
- **Contenu** : les six catégories d'usage ; deux tableaux.

Tableau A (importance stratégique, d'après [FND-008](../fondations/FND-008-usages-de-linux.md)) :

| Catégorie | Distributions dominantes | Usage principal | Importance stratégique |
|---|---|---|---|
| Entreprises et HPC | RHEL, SLES, Ubuntu Pro ; HPC base RHEL, Rocky, SUSE | systèmes critiques régulés, supercalcul | très élevée (valeur, criticité) |
| Communautaires et indépendantes | Debian, Fedora, Arch, openSUSE | socle amont, bureau avancé, web | élevée (amont de l'écosystème) |
| Conteneur (images) | Alpine, Debian-slim, Ubuntu, UBI, Wolfi | base d'images cloud-native | maximale (centre de gravité actuel) |
| Mobile | Android (AOSP) | téléphones grand public | maximale en volume (environ 71 pour cent) |
| IoT et embarqué | Yocto, OpenWrt, Buildroot | appareils, routeurs, edge, auto | élevée et croissante, diffuse |
| Spécialités notables | Talos, Flatcar, Bottlerocket, NixOS, Fedora CoreOS | hôtes de conteneurs, immuables, sécurité | élevée (cloud-native moderne) |

Tableau B (usage et défis cryptographiques) :

| Catégorie | Usage crypto principal | Défis cryptographiques |
|---|---|---|
| Entreprises et HPC | TLS, SSH, signature de paquets, conformité | support long contre rythme de migration, certifications, politiques système |
| Communautaires et indépendantes | TLS, SSH, rôle d'amont | dépend du modèle de publication, peu de garanties entreprise |
| Conteneur (images) | TLS sortant, certificats, surface minimale | la crypto vient surtout de l'application ; inventaire ; éphémérité |
| Mobile | TLS (BoringSSL), keystore, signature d'app | chaîne propre Google ; plateforme en retard ; mises à jour OEM |
| IoT et embarqué | TLS (mbedTLS, wolfSSL), signature de micrologiciel | matériel contraint, coût du PQC, longévité, mises à jour difficiles |
| Spécialités notables | TLS via Go ou OpenSSL, communications de cluster | PQC via le runtime ; immuabilité ; traçabilité |

### Diapo 6 : le flux upstream vers downstream

- **Objectif** : montrer que la complexité apparente se ramène à peu de briques et à un flux lisible.
- **Message décideurs** : une journée de formation rend une équipe Linux capable de prendre en charge l'essentiel du risque opérationnel et de le remonter à l'équipe cyber.
- **Message communauté** : connaissez-vous la feuille de route PQC de vos distributions ? Le doublet feuille de route plus modèle de publication est-il cohérent avec vos besoins de protection des données ?
- **Leitmotiv** : qu'arriverait-il si vos équipes ignoraient la feuille de route PQC de vos distributions ? Puis : une journée de formation suffit.
- **Contenu** : un petit nombre de briques (tableau haut niveau) ; puis le flux de mise en production, déterminé par la feuille de route (choix de l'éditeur) et le modèle de publication.

Tableau 1 (les briques, vue haut niveau) :

| Brique | Rôle |
|---|---|
| OpenSSL, GnuTLS, NSS, BoringSSL | piles TLS (HTTPS et communications chiffrées) |
| OpenSSH | connexions à distance |
| pile Go | runtime des nombreux outils cloud-native |
| mbedTLS, wolfSSL | piles TLS de l'embarqué contraint |
| noyau Linux | cryptographie de certaines opérations système |

Tableau 2 (le flux par catégorie) :

| Catégorie | Distribution exemple | Modèle de publication | Feuille de route PQC |
|---|---|---|---|
| Entreprises et HPC | RHEL | fixe, support long, éditeur proactif | PQC par défaut dès 10.1, signature RPM en PQC |
| Entreprises et HPC | Ubuntu | fixe (LTS) | PQC natif avec 26.04 |
| Communautaires | Debian | fixe, prudent | PQC avec trixie |
| Communautaires | Arch | rolling | PQC tôt, au fil de l'amont |
| Conteneur | Alpine | rapide | suit OpenSSL |
| Mobile | Android | chaîne Google | transit web fait, plateforme à venir |
| IoT et embarqué | OpenWrt | fixe, contraint | selon la pile TLS retenue |
| Spécialités | Talos | rolling, écrit en Go | hérite du PQC de Go |

### Diapo 7 : les briques de la crypto Linux, en détail

- **Objectif** : donner à l'audience technique la grille précise de l'arrivée du PQC dans chaque brique.
- **Message décideurs** : le PQC n'est pas à inventer ; il est déjà livré dans les composants, il s'agit de l'activer et de le suivre.
- **Message communauté** : la posture d'une distribution se lit d'abord dans la version de ces briques qu'elle embarque.
- **Leitmotiv** : qu'arriverait-il si vous laissiez ces briques sur une version pré-PQC ? Puis : passer à OpenSSL 3.5 et OpenSSH 10, c'est l'essentiel du chemin.
- **Contenu** : pour chaque brique, la version qui introduit le PQC, ce qu'elle livre, et la suite de sa feuille de route.

| Brique (librairie) | Version de début PQC | Fonctionnalités PQC livrées | Prochain jalon PQC |
|---|---|---|---|
| OpenSSL | 3.5.0 (avril 2025) | ML-KEM, ML-DSA, SLH-DSA natifs ; X25519MLKEM768 par défaut en TLS | élargir les signatures, diffusion dans les distros |
| OpenSSH | 9.0 (2022), défaut en 10.0 | mlkem768x25519 par défaut (10.0) ; avertissement non quantique (10.1) | signatures PQC |
| GnuTLS | versions récentes | hybride x25519mlkem768 | maturation |
| Mozilla NSS | versions récentes | hybride x25519mlkem768 | maturation |
| pile Go | 1.24 (début 2025) | X25519MLKEM768 par défaut dans crypto/tls | signatures |
| BoringSSL | 2024 | ML-KEM (par défaut dans Chrome 131) | plateforme Android |
| wolfSSL | v7.0 | ML-KEM, ML-DSA, aligné CNSA 2.0, validé CAVP | élargissement embarqué |
| mbedTLS | LMS pour micrologiciel | ML-KEM annoncé, pas encore livré | ML-KEM |
| noyau Linux | travaux en cours | chantiers PQC (présentés à DebConf 25) | crypto noyau PQC |

### Diapo 8 : carte de maturité PQC par catégorie

- **Objectif** : offrir une synthèse mémorable de l'état du terrain par catégorie.
- **Message décideurs** : votre posture dépend des distributions que vous exploitez ; certaines mènent, d'autres traînent.
- **Message communauté** : situez vos distributions sur cette carte, et anticipez.
- **Leitmotiv** : qu'arriverait-il si vous misiez, sans le savoir, sur une distribution à la traîne ?
- **Contenu** : tableau de maturité (d'après FND-009 et FND-011).

| Catégorie | Distributions repères | Maturité PQC | Pourquoi |
|---|---|---|---|
| Entreprises et HPC | RHEL ; SLES, Azure Linux, dérivés Fedora ; Amazon Linux | meneur | RHEL signe en PQC et active par défaut ; Amazon Linux reste sur OpenSSL 3.2 |
| Communautaires | Fedora, Tumbleweed, Arch ; Debian stable ; Slackware | meneur (rolling) | la fraîcheur de l'amont fait tout |
| Conteneur | Wolfi, Chainguard ; Alpine ; BusyBox, scratch | moyen à élevé | fraîcheur plus signature ; certaines images sans crypto propre |
| Mobile | transit web ; plateforme AOSP | faible (plateforme) | chaîne Google ; pas de bascule plateforme documentée |
| IoT et embarqué | wolfSSL ; mbedTLS ; appareils anciens | faible et hétérogène | matériel contraint, mises à jour difficiles |
| Spécialités | Fedora CoreOS, NixOS, Talos | moyen à élevé | bases fraîches ou runtime Go |

### Diapo 9 : démo, vérifier le PQC soi-même

- **Objectif** : transformer la crédibilité en compétence transmise à l'audience.
- **Message décideurs** : nous livrons une valeur directement applicable chez vous pour améliorer votre prise en charge du PQC.
- **Message communauté** : vous saurez refaire cet inventaire vous-mêmes en rentrant.
- **Leitmotiv** : qu'arriverait-il si vous ne saviez même pas où se trouve votre cryptographie ? Puis : voici comment la vérifier, c'est à votre portée.
- **Contenu** : la démo fait l'objet d'une préparation à part (voir [TKT-006](../tickets/TKT-006-demo-presentation/ticket.md) et [FND-006](../fondations/FND-006-outils-cbom-scan-panorama-comparaison.md)). « diapo démo » sert de placeholder : inventaire cryptographique (CBOM) sur une ou deux images contrastées, et notion de crypto-agilité.

### Diapo x : conclusion et appel (hors des dix)

- **Objectif** : convertir la crédibilité accumulée en intention de contact.
- **Message décideurs** : pour vous c'est du travail, pour nous c'est le métier ; ce qu'on a montré est applicable chez vous.
- **Message communauté** : vous repartez avec une compétence concrète ; la capacité à bâtir est la crypto-agilité.
- **Leitmotiv** : rappel explicite que la même question a parcouru toute la présentation, et qu'à chaque fois il y avait un « voici comment ».
- **Contenu** : récapitulatif en trois mots (recadrer, responsabiliser, outiller) ; appel : « nous sommes les experts PQC au Québec ; parlons-nous ».
