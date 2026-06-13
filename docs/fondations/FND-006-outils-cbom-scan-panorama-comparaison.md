# Outils de génération de CBOM : panorama, open source contre commercial, et comparaison

> Statut : essai de fondation (tâche 1 du ticket 006, préparation de la démo).
> Date : 2026-06-13.
> Objectif : répondre aux questions 1 à 3 du ticket 006. Quels outils produisent un CBOM (Cryptography Bill of Materials) ? Lesquels sont open source, lesquels sont commerciaux ? En quoi diffèrent-ils (fonctionnalité, fiabilité, vitalité du développement, maturité, support) ? L'usage visé est le scan d'images Linux (ISO) et d'images de conteneur.
> Note de rigueur : chaque affirmation factuelle est rattachée à une source (section 14). L'écosystème CBOM est récent et bouge vite (le standard est passé de la version 1.6 à 1.7 en un an) ; les états sont vérifiés à juin 2026 et devront être revalidés à l'approche de la présentation.
> Périmètre : questions 1 à 3 seulement. Le choix d'un outil (question 4), l'usage pas à pas (question 5), la lecture d'un CBOM réel (questions 6 et 7) relèvent des tâches suivantes du ticket 006.

## 1. Avertissement méthodologique

Le domaine est jeune et dominé par quelques acteurs, dont un projet de référence (CBOMkit) récemment passé sous gouvernance de la Linux Foundation. On distingue soigneusement ce qui est mature de ce qui est émergent, et on signale une nuance technique décisive pour la démo : scanner une image binaire (ISO, conteneur) n'a pas la même fiabilité que scanner du code source. L'essai est volontairement exhaustif sur l'axe des composants (ADR-003 §D7).

## 2. Cadrage, périmètre et définitions

### 2.1 Définitions de travail

- CBOM (Cryptography Bill of Materials) : inventaire lisible par machine des actifs cryptographiques d'un système (algorithmes, protocoles, clés, certificats), qui répond à la question « quelle cryptographie utilise-t-on, où, et est-elle résistante au quantique ? ».
- CycloneDX : standard ouvert de l'OWASP pour les Bill of Materials. Le CBOM est une extension de CycloneDX dédiée aux actifs cryptographiques, conçue par IBM Research et intégrée à la version 1.6 du standard.
- SBOM (Software Bill of Materials) : inventaire des composants logiciels. Le CBOM en est le pendant pour la cryptographie ; beaucoup d'outils de CBOM s'appuient sur la même chaîne que les SBOM.
- Cible de scan : la nature de ce qui est analysé (code source, image ou système de fichiers, binaire, trafic réseau, processus en exécution). C'est l'axe le plus important pour notre usage (sections 5 et 10).

### 2.2 Thèse

Il existe aujourd'hui un petit ensemble d'outils capables de produire un CBOM au format CycloneDX. Le paysage se sépare nettement en deux : d'un côté un noyau open source structuré autour de CBOMkit (et de la chaîne CycloneDX), de l'autre des plateformes commerciales d'inventaire cryptographique multimodales. Le critère décisif n'est pas open source contre commercial, mais la cible de scan : pour des images Linux et des conteneurs au repos, ce sont les scanners d'image et de système de fichiers qui comptent, et leur fiabilité est intrinsèquement plus basse que celle des scanners de code source.

## 3. Historique

La notion de CBOM est portée par IBM Research, qui la conçoit comme extension de CycloneDX pour décrire la cryptographie. CycloneDX v1.6, publiée en 2024, intègre officiellement le Cryptographic Bill of Materials ainsi que les attestations (CDXA) [1][2]. Le standard a continué d'évoluer, la version 1.7 étant publiée en octobre 2025 [6]. IBM a ensuite donné son outillage CBOM (la suite CBOMkit) à la Linux Foundation, où il est maintenu sous l'égide de la Post-Quantum Cryptography Alliance (PQCA) [4][5]. Le mouvement s'inscrit dans une dynamique réglementaire : aux États-Unis, des directives comme OMB M-23-02 demandent un inventaire cryptographique lisible par machine pour piloter la migration post-quantique [7].

## 4. Le standard CBOM (CycloneDX) en bref

Un CBOM CycloneDX décrit des composants de type cryptographic-asset : algorithmes (avec leurs propriétés, par exemple la primitive, la taille de clé, le niveau de sécurité quantique), protocoles, certificats, et matériel de clé. Il permet aussi d'exprimer des dépendances entre ces actifs (par exemple un protocole TLS qui dépend d'un algorithme d'échange de clés). C'est cette structure normalisée qui rend les CBOM comparables et exploitables par des outils d'analyse de posture (section 6) [1][2].

## 5. Taxonomie des approches de scan (l'axe décisif)

Les outils diffèrent d'abord par ce qu'ils analysent. Cette taxonomie commande la fiabilité et la pertinence pour notre usage.

| Approche | Ce qu'elle analyse | Fidélité sur l'usage réel d'un algorithme | Pertinence pour une ISO ou un conteneur au repos |
|---|---|---|---|
| Scan de code source | appels d'API cryptographiques dans le code | élevée (on voit l'algorithme appelé) | faible (le code source n'est pas livré dans une image) |
| Scan d'image ou de système de fichiers | certificats, clés, secrets, fichiers de configuration cryptographique, présence de bibliothèques | moyenne (on voit le matériel et les bibliothèques, pas toujours l'usage) | élevée (c'est exactement notre cas) |
| Corrélation via SBOM | inventaire de paquets et bibliothèques, dont les bibliothèques cryptographiques | faible à moyenne (on infère la crypto à partir des paquets) | élevée (s'applique aux images) |
| Analyse dynamique ou runtime | appels réels aux bibliothèques crypto d'un processus en exécution | très élevée (on voit ce qui est réellement utilisé) | faible (il faut exécuter l'image, pas seulement la scanner) |
| Analyse réseau passive | protocoles et algorithmes en transit | élevée pour le transit | nulle pour une image au repos |
| Agent hôte (endpoint) | système de fichiers, registre, mémoire d'une machine | moyenne à élevée | indirecte (vise des hôtes, pas des images) |

Conclusion pour la démo : pour une ISO ou un conteneur au repos, les approches utiles sont le scan d'image et de système de fichiers, et la corrélation via SBOM. Les approches runtime et réseau, plus fidèles, ne s'appliquent pas à une image statique.

## 6. Panorama des outils (question 1)

### 6.1 Open source

- CBOMkit (PQCA, Linux Foundation, anciennement IBM) : la suite de référence [3][4][5]. Ses composants :
  - cbomkit-theia : outil en Go qui détecte les actifs cryptographiques dans les images de conteneur (Docker ou OCI) et les répertoires locaux, en inspectant le système de fichiers (certificats, clés, secrets, fichiers de configuration crypto). C'est le composant directement pertinent pour la démo [3][4].
  - cbomkit-hyperion (plugin Sonar Cryptography) : plugin SonarQube qui détecte la cryptographie dans le code source (Java, Python) et génère un CBOM [1][4].
  - cbomkit-coeus : service web de visualisation des CBOM, avec statistiques sur la cryptographie utilisée [4].
  - cbomkit-themis : évaluation de politiques sur un CBOM, avec une vérification quantum-safe intégrée [4].
  - cbomkit-action : action GitHub pour générer un CBOM en intégration continue [1].
- cdxgen (OWASP CycloneDX) : générateur de BOM depuis du code source et des images de conteneur. Il prend en charge une partie du CBOM (keystores et certificats Java, inventaire d'algorithmes au niveau source pour JavaScript et TypeScript) via l'option d'inclusion de la cryptographie [1].
- Outillage CycloneDX (plugin Maven, CLI) : mis à jour pour porter les champs cryptographiques de la version 1.6 [1].
- cryptoscan (CSNP, QRAMM Toolkit) : scanner de découverte cryptographique qui recense les algorithmes d'une base de code et évalue le risque quantique [recherche, registre b à valider].
- Syft (Anchore) et Trivy (Aqua) : générateurs de SBOM de référence, capables de scanner des images et des systèmes de fichiers. La détection cryptographique dédiée et la production de CBOM y sont émergentes en 2025 et 2026, pas encore matures [8].

### 6.2 Commercial

- SandboxAQ AQtive Guard et Security Suite (spin-off d'Alphabet, a acquis Cryptosense) : plateforme d'inventaire cryptographique multimodale combinant un analyseur réseau passif (trafic), un analyseur applicatif qui s'accroche aux processus en exécution, et un analyseur de système de fichiers qui scanne les fichiers et binaires au repos [9][10].
- InfoSec Global AgileSec Analytics (acquis par Keyfactor en 2025) : outil par agent, centré sur l'hôte, qui déploie des capteurs légers sur les endpoints (ou réutilise des agents existants comme Tanium ou CrowdStrike) pour scanner systèmes de fichiers, registres et mémoire, identifier les bibliothèques cryptographiques et leurs versions, et inspecter configurations et appels d'API [9][11].
- Keyfactor Cryptographic Posture Management : offre de gestion de posture cryptographique qui consolide découverte, inventaire et application de politiques (FIPS-140, PCI-DSS, politiques internes) [11].
- Autres acteurs cités par les panoramas de vendeurs : Venafi (CyberArk), Entrust, Qusecure, PQShield, ainsi que des cabinets de conseil. Ils relèvent davantage de la gestion de cycle de vie des clés et certificats ou du conseil que de la génération de CBOM au sens strict [9].

### 6.3 Réponse à la question 2 (open source contre commercial)

La frontière est nette. Le CBOM open source est presque entièrement porté par CBOMkit et la chaîne CycloneDX, complétés par les générateurs de SBOM (Syft, Trivy, cdxgen) dont la brique cryptographique mûrit. Le commercial est dominé par des plateformes d'inventaire cryptographique multimodales (SandboxAQ, InfoSec Global et Keyfactor) qui visent l'entreprise et combinent plusieurs cibles de scan, au prix d'un coût de licence et souvent d'agents à déployer.

## 7. Comparaison (question 3)

### 7.1 Tableau de synthèse

| Outil | Licence | Cible(s) de scan principale(s) | Sortie CBOM CycloneDX | Maturité | Vitalité | Support |
|---|---|---|---|---|---|---|
| cbomkit-theia | open source | image de conteneur, système de fichiers | oui | en croissance | élevée (Linux Foundation, PQCA) | communautaire |
| cbomkit-hyperion | open source | code source (Java, Python) | oui | en croissance | élevée | communautaire |
| cdxgen | open source | code source, image de conteneur | partiel | mature pour le SBOM, partiel pour le CBOM | élevée | communautaire |
| Syft | open source | image, système de fichiers | crypto émergente | mature (SBOM) | très élevée | communautaire et commercial (Anchore) |
| Trivy | open source | image, système de fichiers, dépôt | crypto émergente | mature (SBOM) | très élevée | communautaire et commercial (Aqua) |
| SandboxAQ AQtive Guard | commercial | réseau, runtime, système de fichiers | oui (plateforme) | mature | soutenue (financement important) | entreprise |
| InfoSec Global, Keyfactor | commercial | hôte (agent), système de fichiers, mémoire | oui (plateforme) | mature | soutenue | entreprise |

### 7.2 Lecture des critères

- Fonctionnalité : les plateformes commerciales couvrent plusieurs cibles de scan (réseau, runtime, fichiers) et ajoutent l'application de politiques et la gestion de posture. L'open source couvre surtout une cible par outil, mais CBOMkit ajoute visualisation (coeus) et politiques quantum-safe (themis).
- Fiabilité : elle dépend surtout de la cible de scan (section 5), pas du statut open source ou commercial. L'analyse de code source et l'analyse runtime sont les plus fidèles ; le scan d'image au repos voit le matériel cryptographique et les bibliothèques mais pas toujours l'usage effectif des algorithmes dans les binaires.
- Vitalité du développement : très élevée pour Syft et Trivy (large communauté SBOM), élevée et institutionnellement soutenue pour CBOMkit (Linux Foundation, PQCA), soutenue pour les plateformes commerciales (financement et acquisitions récentes).
- Maturité : les générateurs de SBOM (Syft, Trivy, cdxgen) sont matures sur le SBOM mais émergents sur la cryptographie ; CBOMkit est le plus avancé spécifiquement sur le CBOM côté open source ; les plateformes commerciales sont matures sur l'inventaire d'entreprise.
- Support : communautaire pour l'open source (avec offres commerciales pour Anchore et Aqua), support entreprise contractuel pour les plateformes commerciales.

## 8. Analyse critique

- Le grand écart source contre binaire : la majorité des outils les plus fidèles visent le code source, alors que notre démo vise des images. Sur une image, on détecte des certificats, des clés, des fichiers de configuration et la présence de bibliothèques, mais l'usage réel d'un algorithme dans un binaire compilé reste difficile à établir. Il faut présenter cette limite honnêtement.
- Faux positifs et faux négatifs : la présence d'une bibliothèque cryptographique n'implique pas qu'un algorithme donné soit utilisé, et l'absence de détection n'implique pas l'absence de cryptographie. Un CBOM d'image est un point de départ, pas une vérité complète.
- Standard mouvant : le passage de CycloneDX 1.6 à 1.7 en un an signifie que les sorties et les champs évoluent ; il faut épingler une version pour la démo.
- Détection post-quantique encore jeune : l'étiquetage quantum-safe existe (par exemple themis dans CBOMkit), mais la détection explicite du caractère résistant au quantique dans Syft ou Trivy est émergente.
- Concentration du marché : côté commercial, les acquisitions récentes (Cryptosense par SandboxAQ, InfoSec Global par Keyfactor) concentrent l'offre, ce qui pèse sur le coût et le verrouillage.

## 9. Tendances 2024 à 2026

- Standardisation et institutionnalisation : intégration du CBOM dans CycloneDX, puis donation de CBOMkit à la Linux Foundation et à la PQCA, signe d'une convergence vers un socle commun et ouvert [4][5].
- Pression réglementaire : les exigences d'inventaire cryptographique lisible par machine poussent l'adoption [7].
- Convergence SBOM et CBOM : les générateurs de SBOM ajoutent progressivement la cryptographie, ce qui rapprochera les deux mondes [8].
- Montée de la gestion de posture cryptographique (CPM) côté commercial, au-delà du simple inventaire [11].

## 10. Pertinence pour la démo (images Linux et conteneurs)

Sans préempter la question 4 (le choix), la taxonomie de la section 5 oriente déjà vers les scanners d'image et de système de fichiers. Côté open source, cbomkit-theia est l'outil le plus directement aligné sur l'usage (images de conteneur et répertoires, sortie CBOM CycloneDX), et peut être complété par un générateur de SBOM (Syft ou Trivy) pour l'inventaire des bibliothèques. Une démonstration honnête montrera à la fois ce que ces outils détectent (certificats, clés, bibliothèques, configurations) et leurs limites (l'usage d'algorithmes dans les binaires). Les choix précis, l'usage pas à pas et la lecture du CBOM produit feront l'objet des tâches suivantes.

## 11. Lexique

- CBOM : Cryptography Bill of Materials, inventaire des actifs cryptographiques.
- SBOM : Software Bill of Materials, inventaire des composants logiciels.
- CycloneDX : standard ouvert de l'OWASP pour les BOM, incluant le CBOM depuis la version 1.6.
- Actif cryptographique : algorithme, protocole, certificat ou clé.
- PQCA : Post-Quantum Cryptography Alliance, projet de la Linux Foundation hébergeant CBOMkit.
- Cible de scan : nature de ce qui est analysé (source, image, binaire, réseau, runtime, hôte).
- Quantum-safe : résistant à un adversaire disposant d'un ordinateur quantique.
- CPM : Cryptographic Posture Management, gestion de la posture cryptographique.

## 12. Synthèse

Le CBOM est un inventaire normalisé de la cryptographie, standardisé par CycloneDX (depuis la version 1.6) et soutenu par un noyau open source de référence, CBOMkit, désormais sous gouvernance de la Linux Foundation. Le paysage se partage entre cet open source (CBOMkit, plus la chaîne CycloneDX et les générateurs de SBOM Syft, Trivy et cdxgen) et des plateformes commerciales multimodales (SandboxAQ, InfoSec Global et Keyfactor). Le vrai discriminant n'est pas la licence mais la cible de scan : pour des images Linux et des conteneurs au repos, ce sont les scanners d'image et de système de fichiers qui comptent, cbomkit-theia étant le candidat open source naturel, avec la limite assumée qu'un scan d'image révèle le matériel et les bibliothèques cryptographiques plus que l'usage réel des algorithmes.

## 13. Limites

Le panorama est représentatif, non exhaustif : d'autres outils existent et le domaine évolue vite. Certaines affirmations sur les outils émergents (détection crypto dans Syft et Trivy, cryptoscan) sont à revérifier au moment de la démo. La comparaison de fiabilité est qualitative ; une mesure rigoureuse demanderait un banc d'essai sur des images réelles (ce qui relève des tâches suivantes). Les états de version (CycloneDX 1.7, fonctionnalités des outils) sont datés de juin 2026 et à revalider.

## 14. Sources

1. CycloneDX, CycloneDX v1.6 Released (CBOM conçu par IBM Research, intégré au standard). https://cyclonedx.org/news/cyclonedx-v1.6-released/
2. OWASP, CycloneDX, The Missing Standard For Describing Cryptography in Software (CBOM). https://owasp.org/blog/2023/10/03/CycloneDX-Cryptography-CBOM
3. PQCA, dépôt cbomkit-theia (détection d'actifs cryptographiques dans les images de conteneur et répertoires). https://github.com/PQCA/cbomkit-theia
4. IBM Research, Managing cryptography with CBOMkit (composants hyperion, theia, coeus, themis). https://research.ibm.com/blog/quantum-safe-cbomkit
5. IBM Research, IBM is donating its CBOM toolset to the Linux Foundation. https://research.ibm.com/blog/cryptographic-cbom-linux-foundation
6. Synthèse sur le CBOM et l'état du standard (CycloneDX 1.7, octobre 2025). https://postquantum.com/post-quantum/cryptographic-bill-of-materials-cbom/
7. Inventaire cryptographique et exigences réglementaires (OMB M-23-02). https://postquantum.com/post-quantum/cryptographic-inventory-vendors/
8. Comparatifs d'outils SBOM (Syft, Trivy, cdxgen ; détection crypto émergente). https://sbomify.com/2026/01/26/sbom-generation-tools-comparison/
9. Encryption Consulting, Top Cryptographic Inventory Vendors and Methodologies. https://www.encryptionconsulting.com/cryptographic-inventory-vendors/
10. SandboxAQ, Security Suite et AQtive Guard (analyseurs réseau, applicatif, système de fichiers). https://www.sandboxaq.com/solutions/aqtive-guard
11. InfoSec Global et Keyfactor, Cryptographic Posture Management (AgileSec Analytics). https://www.infosecglobal.com/solutions/enterprise

> À revalider à l'approche de la présentation : version de CycloneDX, fonctionnalités exactes de cbomkit-theia, Syft et Trivy, et l'état des offres commerciales (acquisitions, renommages). L'écosystème CBOM est en évolution rapide.
