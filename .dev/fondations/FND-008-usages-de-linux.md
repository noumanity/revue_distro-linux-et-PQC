# Les usages de Linux : qui l'utilise, pourquoi, quelles distributions, et quelle importance stratégique

> Statut : essai de fondation (tâche 2 du ticket 007). Complément de [FND-007](FND-007-familles-linux.md) (les familles) et de [FND-001](FND-001-recherche-preliminaire-pqc-distributions-linux.md) (angle PQC).
> Date : 2026-06-15.
> Objectif : répondre de façon exhaustive à la question « qui utilise Linux et pourquoi ? », segment par segment (bureau, serveur, IoT, mobile, entreprise, cloud sur metal, VM et conteneur, et autres usages). Pour chaque segment : quelles distributions et pourquoi, une estimation des parts de marché (au minimum dominantes contre marginales), une évaluation de l'importance stratégique du secteur et de la position des distributions, et des cadres d'analyse à deux axes de type Magic Quadrant.
> Note de rigueur : les parts de marché de Linux sont notoirement imprécises (méthodes et sources divergent). Les chiffres sont donnés comme ordres de grandeur, datés et sourcés (section 17), à prendre avec prudence. États vérifiés à juin 2026 et à revalider.
> Périmètre : les usages et les positions de marché. L'analyse de l'intégration PQC par segment relève de FND-001 et des tickets dédiés ; elle n'est qu'esquissée ici (section 13).

## 1. Avertissement méthodologique

Aucune source unique ne mesure fidèlement les parts de marché de Linux. Le bureau est mesuré par échantillonnage de navigateurs (StatCounter), le web par sondage de serveurs, le cloud par fournisseur, le mobile par ventes et trafic. Ces méthodes ne sont pas comparables entre elles. On retient donc des ordres de grandeur convergents et on signale les écarts. Les estimations par distribution sont encore plus fragiles que les estimations globales. L'essai est exhaustif sur l'axe des composants (ADR-003 §D7).

## 2. Cadrage, périmètre et définitions

### 2.1 Segments retenus

Bureau (poste de travail), serveur (dont web), cloud (metal, VM, conteneur), entreprise, IoT et embarqué, mobile (téléphones), et autres usages (supercalcul, scientifique, réseau et appliances, sécurité, automobile).

### 2.2 Trois questions par segment

Pour chaque segment, on traite : qui et pourquoi (les utilisateurs et leurs motivations), quelles distributions et pourquoi (dominantes contre marginales, avec une estimation de part), et l'importance stratégique (du secteur et de la position des distributions).

### 2.3 Thèse

Linux est marginal sur un seul segment grand public (le bureau) et dominant ou hégémonique partout ailleurs (serveur, cloud, mobile via Android, embarqué, supercalcul). La distribution dominante change radicalement selon le segment : Ubuntu et Mint au bureau, RHEL en entreprise, Ubuntu et Amazon Linux dans le cloud, Android sur mobile, Alpine dans les conteneurs, Yocto dans l'embarqué. L'importance stratégique d'un segment ne se mesure pas à son nombre d'unités (le supercalcul est crucial et minuscule en unités) mais à son rôle d'infrastructure.

## 3. Pourquoi Linux : les raisons transverses

Avant le détail par segment, les motivations communes : le coût et le logiciel libre (pas de licence par siège), le contrôle et la personnalisation (code ouvert, modularité), la sécurité et la transparence (audit possible, modèle de permissions), la performance et la légèreté (du conteneur de 5 Mo au supercalculateur), la stabilité et la longévité (support long en entreprise), l'écosystème et l'automatisation (outils, scripts, conteneurs), et l'absence de verrouillage propriétaire. Le poids de chaque motivation varie selon le segment.

## 4. Segment bureau (poste de travail)

- Qui et pourquoi : développeurs, administrateurs, passionnés, secteur public soucieux de souveraineté, et de plus en plus joueurs (grâce à Steam et au Steam Deck). Motivations : contrôle, coût, vie privée, performance, et rejet des systèmes propriétaires.
- Distributions et parts : Ubuntu domine parmi les distributions de bureau (de l'ordre de 33,9 pour cent des installations Linux) [1][5], suivie de Linux Mint, Fedora, et des familles Arch (Arch, Manjaro, EndeavourOS) et Debian. SteamOS (Steam Deck, base Arch) a introduit des millions de joueurs à Linux ; sur Steam, la part Linux est de l'ordre de 3,2 pour cent [1].
- Part globale du segment : Linux atteint environ 4,7 pour cent du bureau mondial en 2025, et a dépassé 5 pour cent aux États-Unis pour la première fois en juin 2025 [1].
- Importance stratégique : faible en volume, mais forte en influence (les développeurs et décideurs techniques y sont) et en souveraineté (administrations). C'est le segment où Linux est marginal.
- Positions : Ubuntu et Mint en leaders grand public ; Fedora en visionnaire (innovation, en amont de RHEL) ; Arch et dérivés en acteurs de niche pour utilisateurs avancés ; SteamOS en challenger porté par le jeu.

## 5. Segment serveur (et web)

- Qui et pourquoi : hébergeurs, éditeurs de services en ligne, entreprises. Motivations : stabilité, coût, performance, automatisation, et écosystème serveur (Nginx, Apache, bases de données, conteneurs).
- Parts : Linux fait tourner de l'ordre de 60 pour cent des sites web mondiaux et environ 96 pour cent du premier million de serveurs web, et contrôle près de 45 pour cent du marché des systèmes serveur [2]. Côté logiciel serveur, Nginx (environ 38,6 pour cent) et Apache (environ 35,5 pour cent) dominent [2].
- Distributions : Ubuntu Server, Debian, RHEL et ses compatibles (Rocky, AlmaLinux), SLES. Debian et Ubuntu dominent l'hébergement web ; RHEL et SLES dominent l'entreprise (section 7).
- Importance stratégique : très élevée. C'est l'infrastructure d'Internet.
- Positions : Ubuntu et Debian en leaders du web ; RHEL et SLES en leaders entreprise ; Rocky et AlmaLinux en challengers (remplacer CentOS).

## 6. Segment cloud (metal, VM, conteneur)

- Qui et pourquoi : à peu près toutes les organisations modernes. Motivations : élasticité, coût à l'usage, automatisation, et images préintégrées.
- Parts : Linux équipe environ 90 pour cent de l'infrastructure de cloud public [2]. Par fournisseur, la part de VM Linux est de l'ordre de 83,5 pour cent sur AWS, 61,8 pour cent sur Azure et 91,6 pour cent sur Google Cloud [2]. Plus de 60 pour cent des instances Linux de cloud public tournent sous Ubuntu [2].
- Distributions par sous-segment :
  - Metal (bare metal) : RHEL, SLES, Ubuntu, et distributions immuables d'hôtes (Flatcar, Bottlerocket) pour les clusters de conteneurs.
  - VM : Ubuntu (leader), Amazon Linux (optimisée AWS), RHEL, Debian, SLES.
  - Conteneur (image de base) : Alpine (minime, de l'ordre de 5 Mo), Debian et Ubuntu (compatibilité), Red Hat UBI, distroless (Google) et Wolfi (Chainguard) pour la sécurité et la chaîne d'approvisionnement [3] (voir FND-006 et FND-007).
- Importance stratégique : maximale. Le cloud est le centre de gravité actuel de l'informatique, et il est presque entièrement Linux.
- Positions : Ubuntu en leader des VM ; Amazon Linux en challenger captif d'AWS ; Alpine en leader des images de conteneur ; distroless et Wolfi en visionnaires (sécurité et SBOM) ; Flatcar, Bottlerocket et Talos en leaders des hôtes de conteneurs (chacun sur son terrain).

## 7. Segment entreprise

- Qui et pourquoi : grandes organisations, secteurs régulés (banque, santé, télécom), SAP. Motivations : support contractuel, certifications, support long (dix ans), conformité, et responsabilité d'un éditeur.
- Parts : RHEL détient la plus grande part du segment serveur d'entreprise, de l'ordre de 43,1 pour cent en 2025 [2]. SLES est fort dans l'industrie et chez les clients SAP. Oracle Linux et Ubuntu Pro complètent l'offre.
- Distributions : RHEL (leader), SLES, Ubuntu Pro, Oracle Linux, et les compatibles RHEL (Rocky, AlmaLinux) pour réduire les coûts.
- Importance stratégique : très élevée en valeur (revenus, contrats critiques), modérée en volume d'unités.
- Positions : RHEL en leader incontesté ; SLES en challenger spécialisé (SAP, industrie) ; Ubuntu Pro en visionnaire (modèle hybride communauté et entreprise) ; Rocky et AlmaLinux en acteurs de niche montants (compatibilité à bas coût).

## 8. Segment IoT et embarqué

- Qui et pourquoi : fabricants d'appareils, industriels, télécoms, fournisseurs d'équipements réseau. Motivations : flexibilité, coût du silicium (dont RISC-V), maîtrise de la pile, et sécurité par conception.
- Outils et distributions : ici, on ne déploie pas une distribution généraliste mais on en construit une sur mesure. Le Yocto Project est le standard de fait pour fabriquer une distribution embarquée [4][6] ; Buildroot est l'alternative légère ; OpenWrt domine les routeurs ; Android est répandu sur les appareils grand public. Automotive Grade Linux (Linux Foundation, avec Toyota, Mazda, Renesas) cible le véhicule défini par logiciel [4].
- Parts : très fragmenté et mal mesuré ; Linux (sous une forme ou une autre) domine l'embarqué connecté.
- Importance stratégique : élevée et croissante (edge, IoT, RISC-V), mais diffuse.
- Positions : Yocto en leader des chaînes de fabrication ; OpenWrt en leader des routeurs ; AGL en visionnaire de l'automobile ; Buildroot en acteur de niche (projets simples).

## 9. Segment mobile (téléphones)

- Qui et pourquoi : le grand public mondial, via Android. Motivations (côté fabricants) : système gratuit, personnalisable, écosystème d'applications.
- Parts : Android, fondé sur le noyau Linux, détient de l'ordre de 71 pour cent du marché mondial des systèmes mobiles, contre environ 28 pour cent pour iOS, avec de fortes variations régionales (Asie 80 à 95 pour cent, Amérique du Nord plutôt favorable à iOS) [7].
- Linux mobile non Android : postmarketOS (base Alpine, plus de 200 appareils), Ubuntu Touch, KDE Plasma Mobile. Ce sont des projets de niche, à part de marché négligeable, mais stratégiques pour la souveraineté et la longévité des appareils [8].
- Importance stratégique : maximale en volume (Android est le système le plus déployé au monde), mais Android s'éloigne de l'esprit GNU/Linux (espace utilisateur et gouvernance propres à Google).
- Positions : Android en hégémon ; postmarketOS en visionnaire de niche (redonner vie aux appareils) ; Ubuntu Touch et Plasma Mobile en acteurs de niche.

## 10. Autres usages

- Supercalcul (HPC) : 100 pour cent des 500 plus puissants supercalculateurs tournent sous Linux, pour la huitième année consécutive [9]. Distributions souvent à base RHEL ou SUSE, plus des piles spécialisées. Importance stratégique maximale, volume d'unités minuscule.
- Scientifique et recherche : Linux domine les laboratoires et le calcul. Historiquement Scientific Linux (à base RHEL), aujourd'hui RHEL, Rocky, AlmaLinux, Debian.
- Réseau et appliances : pare-feu et routeurs (OpenWrt, VyOS, pfSense sur base BSD pour comparaison), équipements télécom.
- Sécurité et investigation : Kali Linux et Parrot OS (base Debian), Tails (anonymat).
- Automobile et transport : Automotive Grade Linux, systèmes embarqués sur mesure.

## 11. Tableau de synthèse : parts et importance stratégique

| Segment | Part de Linux (ordre de grandeur) | Distributions dominantes | Distributions marginales mais notables | Importance stratégique |
|---|---|---|---|---|
| Bureau | environ 5 pour cent | Ubuntu, Mint | Fedora, Arch, SteamOS | faible en volume, forte en influence |
| Serveur et web | environ 60 pour cent des sites, 96 pour cent du top 1M | Debian, Ubuntu, RHEL | SLES, Rocky, AlmaLinux | très élevée (infrastructure du web) |
| Cloud (VM) | environ 90 pour cent du cloud public | Ubuntu, Amazon Linux, RHEL | Debian, SLES | maximale |
| Cloud (conteneur) | quasi total | Alpine, Debian, Ubuntu, UBI | distroless, Wolfi | maximale |
| Entreprise | (sur Linux) RHEL environ 43 pour cent | RHEL, SLES | Ubuntu Pro, Oracle, Rocky, Alma | très élevée en valeur |
| IoT et embarqué | dominant, fragmenté | Yocto, OpenWrt, Android | Buildroot, AGL | élevée et croissante |
| Mobile | Android environ 71 pour cent | Android | postmarketOS, Ubuntu Touch | maximale en volume |
| Supercalcul | 100 pour cent | base RHEL et SUSE | piles spécialisées | maximale, volume minuscule |

## 12. Cadres d'analyse de type Magic Quadrant

Le Magic Quadrant de Gartner croise deux axes (classiquement la capacité d'exécution en ordonnée et la complétude de la vision en abscisse) pour produire quatre quadrants : leaders, challengers, visionnaires, acteurs de niche. On propose des doublets d'axes adaptés à Linux, puis on en illustre deux.

### 12.1 Doublets d'axes proposés (un par usage)

- Général (tous segments) : abscisse, adoption et part de marché ; ordonnée, momentum stratégique (croissance et soutien).
- Bureau : abscisse, facilité d'usage pour le grand public ; ordonnée, contrôle et fraîcheur pour l'utilisateur avancé.
- Serveur et entreprise : abscisse, maturité du support et de l'écosystème ; ordonnée, ouverture et coût (du libre gratuit au propriétaire payant).
- Cloud (VM) : abscisse, intégration native chez les fournisseurs ; ordonnée, neutralité et portabilité multi-cloud.
- Cloud (conteneur) : abscisse, minimalisme et surface réduite ; ordonnée, compatibilité et richesse de l'écosystème.
- IoT et embarqué : abscisse, flexibilité et personnalisation ; ordonnée, effort d'intégration et de maintenance (inversé, plus bas est mieux).
- Mobile : abscisse, ouverture et contrôle par l'utilisateur ; ordonnée, maturité fonctionnelle et écosystème d'applications.

### 12.2 Quadrant illustré : serveur et entreprise (abscisse, maturité de l'écosystème ; ordonnée, ouverture et coût)

| | Vision faible (écosystème moins mûr) | Vision forte (écosystème mûr) |
|---|---|---|
| Exécution forte (très ouvert, faible coût) | Debian (acteur de niche solide, communautaire) | Ubuntu (leader, ouvert et soutenu) |
| Exécution moindre (plus fermé ou payant) | Oracle Linux (challenger captif) | RHEL et SLES (leaders entreprise, payants) |

Lecture : Ubuntu occupe le coin idéal (mûr et ouvert) ; RHEL et SLES dominent par la maturité et le support au prix de la fermeture commerciale ; Debian est un acteur de niche très solide ; Rocky et AlmaLinux se placeraient près de RHEL en exécution mais plus haut en ouverture.

### 12.3 Quadrant illustré : cloud conteneur (abscisse, compatibilité et écosystème ; ordonnée, minimalisme et surface réduite)

| | Compatibilité faible | Compatibilité forte |
|---|---|---|
| Très minimal | distroless, Wolfi (visionnaires sécurité) | Alpine (leader, minime et répandu) |
| Moins minimal | images spécialisées | Debian et Ubuntu, UBI (leaders compatibilité) |

Lecture : Alpine est le leader (minime et largement compatible) ; distroless et Wolfi sont des visionnaires (sécurité et SBOM, au prix d'une compatibilité plus exigeante) ; Debian, Ubuntu et UBI privilégient la compatibilité à la taille.

## 13. Pertinence pour la suite (vers le PQC)

L'importance stratégique d'un segment oriente l'urgence du PQC. Le serveur, le cloud et l'entreprise (où Linux est dominant et où vivent TLS, SSH et les certificats) sont les segments les plus exposés au risque quantique et donc prioritaires. Le mobile (Android) et l'embarqué ont des cycles et des chaînes spécifiques. La position d'une distribution (leader entreprise comme RHEL, ou image de base comme Alpine) détermine où l'inventaire cryptographique (CBOM, voir FND-006) aura le plus d'effet de levier.

## 14. Lexique

- Part de marché : proportion d'usage, mesurée différemment selon le segment.
- Bare metal : serveur physique sans couche de virtualisation.
- VM : machine virtuelle.
- Image de base : point de départ d'une image de conteneur.
- HPC : calcul haute performance (supercalcul).
- Magic Quadrant : cadre d'analyse à deux axes de Gartner (leaders, challengers, visionnaires, acteurs de niche).
- AGL : Automotive Grade Linux.

## 15. Synthèse

Linux est marginal sur le bureau (environ 5 pour cent) et dominant ou hégémonique partout ailleurs : environ 60 pour cent du web, environ 90 pour cent du cloud public, 100 pour cent des supercalculateurs, et environ 71 pour cent du mobile via Android. La distribution gagnante change selon le segment : Ubuntu et Mint au bureau, Debian, Ubuntu, RHEL et SLES au serveur et en entreprise, Ubuntu et Amazon Linux en VM cloud, Alpine dans les conteneurs, Android sur mobile, Yocto et OpenWrt dans l'embarqué. L'importance stratégique tient au rôle d'infrastructure plus qu'au volume d'unités. Les cadres à deux axes proposés (par exemple maturité contre ouverture pour l'entreprise, minimalisme contre compatibilité pour les conteneurs) aident à situer chaque distribution. Pour le PQC, ce sont le serveur, le cloud et l'entreprise qui concentrent l'urgence.

## 16. Limites

Les parts de marché sont des ordres de grandeur issus de méthodes non comparables, et les estimations par distribution sont fragiles. Le placement dans les quadrants est qualitatif et discutable. Le panorama des usages est représentatif, non exhaustif (d'autres niches existent). Android est compté comme Linux par le noyau, ce qui est défendable mais discutable du point de vue GNU/Linux. États datés de juin 2026 et à revalider.

## 17. Sources

1. itsfoss, Linux Market Share (bureau environ 4,7 pour cent, États-Unis au-dessus de 5 pour cent en 2025 ; Ubuntu environ 33,9 pour cent ; Steam environ 3,2 pour cent). https://itsfoss.com/linux-market-share/
2. fosspost et commandlinux, Linux Server Market Share Statistics (web environ 60 pour cent, top 1M environ 96 pour cent, serveur environ 45 pour cent, cloud environ 90 pour cent ; AWS, Azure, Google Cloud ; RHEL environ 43 pour cent ; Ubuntu et le cloud public). https://fosspost.org/linux-server-market-share-statistics/
3. Comparatifs d'images de base de conteneurs (Alpine, BusyBox, UBI, distroless). https://pythonspeed.com/articles/base-image-python-docker-images/
4. PRNewswire, Automotive Grade Linux et la plateforme SoDeV (Linux Foundation ; Yocto comme standard de fabrication). https://www.prnewswire.com/news-releases/automotive-grade-linux-launches-open-source-sodev-reference-platform-to-accelerate-software-defined-vehicles-302634201.html
5. commandlinux, Most Popular Linux Distributions Market Share. https://commandlinux.com/statistics/most-popular-linux-distributions-market-share/
6. Yocto Project (standard de fait pour l'embarqué). https://www.yoctoproject.org/
7. Statista, Mobile OS market share worldwide (Android environ 71 pour cent, iOS environ 28 pour cent). https://www.statista.com/statistics/272698/global-market-share-held-by-mobile-operating-systems-since-2009/
8. postmarketOS (Linux mobile de niche, base Alpine, plus de 200 appareils). https://postmarketos.org/
9. TOP500, liste de novembre 2025 (100 pour cent des supercalculateurs sous Linux). https://www.top500.org/lists/top500/2025/11/

> À revalider à l'approche de la présentation : tous les chiffres de parts de marché (sources et méthodes divergent), et les positions des distributions par segment. Cet essai prépare la priorisation PQC par segment (FND-001 et tickets dédiés).
