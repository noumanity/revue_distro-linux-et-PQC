# Analyse PQC par catégorie : dix images Linux présélectionnées

> Statut : essai de fondation (tâche 3 du ticket 007). S'appuie sur [FND-001](FND-001-recherche-preliminaire-pqc-distributions-linux.md) (PQC et distributions), [FND-007](FND-007-familles-linux.md) (familles), [FND-008](FND-008-usages-de-linux.md) (usages) et [FND-006](FND-006-outils-cbom-scan-panorama-comparaison.md) (CBOM).
> Date : 2026-06-15.
> Objectif : arrêter une présélection de dix images représentatives, réparties sur six catégories d'usage, puis analyser l'état de la cryptographie post-quantique (PQC) catégorie par catégorie : qui mène, qui suit, et pourquoi.
> Note de rigueur : on distingue (a) les faits sourcés sur les briques en amont et les distributions documentées (RHEL, SUSE, Ubuntu, Debian), et (b) les déductions sur les images moins documentées (Android, OpenWrt, Wolfi, NixOS, Talos), tirées des bibliothèques cryptographiques qu'elles embarquent et signalées comme à confirmer. États vérifiés à juin 2026, à revalider (le domaine bouge vite).
> Périmètre : l'état PQC des images sélectionnées. La mécanique fine des algorithmes est dans FND-001 ; l'outillage de mesure (CBOM) dans FND-006.

## 1. Avertissement méthodologique

La maturité PQC d'une distribution se mesure surtout à la version des briques cryptographiques qu'elle embarque (OpenSSL, OpenSSH, GnuTLS, NSS, la pile Go) et à son modèle de publication. On évalue donc chaque image sur ces briques, en sourçant ce qui est documenté et en déduisant prudemment le reste. L'essai est exhaustif sur l'axe des composants (ADR-003 §D7) et organisé par catégorie comme demandé.

## 2. Cadrage : la présélection de dix images

### 2.1 Les six catégories et les dix images retenues

| Catégorie | Images retenues (analysées en détail) |
|---|---|
| 1. Entreprises et HPC | RHEL, SLES (SUSE), Ubuntu |
| 2. Communautaires et indépendantes | Debian, AlmaLinux, Arch Linux |
| 3. Spécialisées images (conteneur) | Alpine |
| 4. Mobile | Android |
| 5. IoT | OpenWrt |
| 6. Spécialités notables | Wolfi |

Total : dix images. Conformément à la demande de s'en tenir à dix, certaines candidates listées au ticket sont traitées en complément bref plutôt qu'en détail (section 10.2) : Rocky Linux (posture PQC quasi identique à AlmaLinux car toutes deux suivent RHEL), NixOS et Talos Linux.

### 2.2 Justification des choix

- Catégorie 1 : RHEL, SLES et Ubuntu sont les trois piliers entreprise (voir FND-008), et leurs éditeurs publient des stratégies PQC explicites, donc fortement documentés.
- Catégorie 2 : Debian (socle communautaire amont), AlmaLinux (compatible RHEL, représentatif des clones), Arch (rolling, donc révélateur de l'arrivée précoce du PQC).
- Catégorie 3 : Alpine, image de base de conteneur la plus répandue, centrale pour la démo CBOM.
- Catégorie 4 : Android, système mobile dominant (FND-008).
- Catégorie 5 : OpenWrt, cas d'IoT contraint et concret (routeurs), où TLS et SSH comptent.
- Catégorie 6 : Wolfi, undistro orientée sécurité et chaîne d'approvisionnement, la plus pertinente pour le PQC en conteneur.

### 2.3 Thèse

Le PQC n'est pas adopté distribution par distribution de façon indépendante : il descend des briques en amont (surtout OpenSSL 3.5 et OpenSSH 10.0, sortis tous deux en 2025) vers les distributions, à une vitesse fixée par leur modèle de publication. Conséquence : les rolling (Arch, Wolfi, Tumbleweed) et les éditeurs proactifs (Red Hat en tête) sont en avance ; les fixes à support long arrivent plus tard mais de façon plus intégrée ; le mobile et l'IoT suivent des chaînes propres.

## 3. Les briques en amont qui déterminent tout

Avant d'analyser les images, il faut situer les briques dont elles héritent.

- OpenSSL 3.5.0 (avril 2025) : ajoute nativement ML-KEM, ML-DSA et SLH-DSA, et active par défaut le groupe hybride X25519MLKEM768 pour l'échange de clés TLS [1][2]. Avant la 3.5, le PQC passait par le fournisseur externe oqsprovider (liboqs).
- OpenSSH : propose un échange de clés post-quantique par défaut depuis la 9.0 (2022, via sntrup761x25519) ; la 9.9 ajoute mlkem768x25519-sha256, que la 10.0 (avril 2025) fait passer par défaut ; la 10.1 avertit même quand une connexion n'est pas résistante au quantique [3][4].
- Autres piles : GnuTLS, Mozilla NSS et le runtime Go implémentent l'hybride x25519mlkem768 [5][7]. Le noyau Linux fait l'objet de travaux dédiés (présentés notamment à DebConf 25) [6].
- Standards : ML-KEM (FIPS 203), ML-DSA (FIPS 204) et SLH-DSA (FIPS 205) ont été publiés par le NIST en août 2024 (voir FND-001).

## 4. Grille d'analyse PQC

On évalue chaque image sur cinq dimensions.

- Échange de clés hybride en TLS (par exemple X25519MLKEM768) : présent ou non par défaut.
- SSH post-quantique : version d'OpenSSH et échange de clés PQC par défaut.
- Signatures et signature des paquets en PQC : la distribution signe-t-elle ses paquets avec un algorithme post-quantique (jalon avancé).
- Politiques cryptographiques : existe-t-il un mécanisme système pour activer le PQC (par exemple crypto-policies).
- Délai d'arrivée : fonction du modèle de publication (rolling, fixe, stream).

## 5. Catégorie 1 : entreprises et HPC

### 5.1 RHEL (Red Hat)

RHEL est le meneur. RHEL 10 (mai 2025) livre l'échange de clés post-quantique dans trois bibliothèques majeures (OpenSSL, GnuTLS, NSS), utilisable en TLS 1.3 [8][9]. Côté politiques : RHEL 10.0 exige d'installer crypto-policies-pq-preview et d'activer le module TEST-PQ, tandis que RHEL 10.1 et au-delà activent le PQC par défaut dans tous les niveaux de politique [9]. Surtout, Red Hat a créé une clé de signature hybride ML-DSA-87 plus Ed448 et signe désormais ses paquets RPM avec elle, ce qui en fait la première et pour l'instant seule grande distribution Linux à franchir ce jalon [8]. Importance stratégique maximale (FND-008) et leadership PQC assumé.

### 5.2 SLES (SUSE)

SUSE intègre les standards PQC du NIST dans OpenSSL, Libgcrypt, Mozilla NSS et Go ; avant OpenSSL 3.5, le PQC passait par le fournisseur liboqs [5][10]. SLES 16 est présentée comme la version phare avec PQC [11]. Réserve documentée fin 2025 : la version d'OpenSSH avec PQC (10.0) n'était pas encore disponible dans les produits SUSE [5]. SUSE a publié une stratégie PQC explicite fin 2025 [5]. Position : suiveur rapide et structuré, fort dans l'industrie et chez SAP.

### 5.3 Ubuntu (Canonical)

Le PQC d'Ubuntu suit la version d'OpenSSL embarquée. Ubuntu 24.04 LTS utilise OpenSSL 3.0.13, sans PQC natif (possible via le fournisseur OQS) ; la version 26.04 dispose du PQC complet dans OpenSSL (donc OpenSSL 3.5) [5][12]. Conséquence : pour Ubuntu, le PQC natif arrive avec le cycle 26.04 (avril 2026), avec une solution de contournement par OQS sur la 24.04. Position : suiveur aligné sur OpenSSL, très présent dans le cloud.

### 5.4 Note HPC

Le supercalcul (100 pour cent sous Linux, FND-008) repose largement sur des bases RHEL et SUSE, et hérite donc de leur posture PQC. L'enjeu PQC y est réel pour les communications et l'authentification, moins pour le calcul lui-même.

## 6. Catégorie 2 : communautaires et indépendantes

### 6.1 Debian

Debian 12 (bookworm) n'a pas de PQC ; le support est attendu avec Debian 13 (trixie), qui embarque une version récente d'OpenSSL [5]. La communauté Debian travaille aussi sur la cryptographie du noyau pour l'ère post-quantique [6]. Position : socle communautaire amont, prudent, qui reçoit le PQC à la faveur d'une nouvelle stable.

### 6.2 AlmaLinux (et Rocky)

AlmaLinux suit RHEL et hérite donc des bibliothèques PQC de RHEL 10 (OpenSSL, GnuTLS, NSS). Nuance importante : la signature des paquets en PQC propre à Red Hat (clé ML-DSA-87 plus Ed448) appartient à Red Hat ; les clones signent avec leurs propres clés et n'héritent pas automatiquement de ce jalon. Rocky Linux est dans une position quasi identique (voir section 10.2). Position : suiveurs fidèles de RHEL pour les briques, sans le volet signature PQC de Red Hat.

### 6.3 Arch Linux

Arch, en rolling, reçoit OpenSSL 3.5 et OpenSSH 10 très tôt, donc l'échange de clés hybride en TLS et le SSH post-quantique sont disponibles rapidement (déduction tirée du modèle de publication, à confirmer sur une version donnée). Position : en avance par construction, mais sans garanties d'entreprise ni signature PQC des paquets.

## 7. Catégorie 3 : spécialisées images (conteneur)

### 7.1 Alpine

Alpine embarque OpenSSL et le met à jour rapidement ; ses versions récentes basées sur OpenSSL 3.5 disposent donc de l'échange de clés hybride (à confirmer sur une version précise). Sa surface cryptographique est minime (peu de paquets), ce qui simplifie l'inventaire mais signifie aussi que la cryptographie présente dépend surtout de l'application embarquée, pas de l'image de base. Pour la démo CBOM (FND-006), Alpine est le cas type : on y verra surtout des certificats, la configuration TLS et la présence d'OpenSSL, plus que l'usage d'algorithmes dans des binaires applicatifs. Importance stratégique élevée (image de base la plus répandue).

## 8. Catégorie 4 : mobile

### 8.1 Android

Android repose sur BoringSSL (la bibliothèque cryptographique de Google) et non sur OpenSSL. Google a déployé l'échange de clés hybride X25519MLKEM768 dans Chrome et dans BoringSSL, donc le navigateur et certaines applications bénéficient du PQC en transit (déduction à confirmer pour les versions système d'Android). La chaîne Android est propre à Google et découplée du calendrier OpenSSL et OpenSSH. Position : le transit web mobile est parmi les premiers à passer au PQC hybride, mais l'espace système Android suit une trajectoire propre, à documenter.

## 9. Catégorie 5 : IoT

### 9.1 OpenWrt

OpenWrt (routeurs et équipements) utilise selon les compilations OpenSSL, wolfSSL ou mbedTLS, et tourne sur du matériel contraint. La disponibilité du PQC y dépend donc de la bibliothèque TLS choisie et de sa version, et le coût en mémoire et en CPU des algorithmes post-quantiques est une contrainte réelle sur petits appareils (déduction, à confirmer). Position : l'IoT contraint est en retard et hétérogène ; c'est un point de vigilance stratégique (longévité des appareils, mises à jour difficiles).

## 10. Catégorie 6 : spécialités notables

### 10.1 Wolfi (Chainguard)

Wolfi est une undistro rolling, orientée sécurité et chaîne d'approvisionnement, qui produit des images minimales accompagnées d'un SBOM. En rolling, elle reçoit OpenSSL 3.5 rapidement, donc l'échange de clés hybride en TLS (déduction, à confirmer). Son intérêt PQC tient autant à la fraîcheur qu'à la traçabilité (SBOM et bientôt CBOM), ce qui en fait un très bon candidat de démonstration. Position : visionnaire pour la sécurité des conteneurs.

### 10.2 Candidats complémentaires (traités brièvement pour rester à dix)

- Rocky Linux : posture PQC quasi identique à AlmaLinux (suit RHEL 10), avec sa propre clé de signature.
- NixOS : rolling et déclarative ; reçoit OpenSSL 3.5 rapidement ; son atout propre est la reproductibilité, utile pour auditer la cryptographie d'un système entier (à confirmer).
- Talos Linux : système minimal pour Kubernetes, largement en Go ; hérite donc du PQC du runtime Go (hybride x25519mlkem768) pour ses communications (à confirmer).

## 11. Tableau de synthèse PQC par image

| Image | TLS hybride (X25519MLKEM768) | SSH post-quantique | Signature de paquets PQC | Politique crypto PQC | Délai (modèle de publication) |
|---|---|---|---|---|---|
| RHEL | oui (RHEL 10) | en cours d'intégration | oui (ML-DSA-87 plus Ed448) | oui (défaut dès 10.1) | fixe, mais éditeur proactif |
| SLES | oui | pas encore (fin 2025) | non documenté | en cours | fixe, suiveur rapide |
| Ubuntu | oui à partir de 26.04 (OQS avant) | suit OpenSSH | non documenté | non | fixe, aligné OpenSSL |
| Debian | attendu (trixie) | suit OpenSSH | non | non | fixe, prudent |
| AlmaLinux | oui (suit RHEL) | suit RHEL | propre clé, sans le jalon Red Hat | suit RHEL | fixe, suiveur de RHEL |
| Arch | oui (tôt) | oui (tôt) | non | non | rolling, en avance |
| Alpine | oui sur versions récentes | suit OpenSSH | non | non | rapide |
| Android | oui (Chrome et BoringSSL) | sans objet | sans objet | sans objet | chaîne Google propre |
| OpenWrt | dépend de la pile TLS | dépend de la version | non | non | hétérogène, contraint |
| Wolfi | oui (rolling) | suit OpenSSH | image signée et SBOM | non | rolling, en avance |

Les cases non documentées ou déduites sont à confirmer (note de rigueur).

## 12. Analyse transverse

- Qui mène : Red Hat (RHEL), seul à signer ses paquets en PQC et à activer le PQC par défaut dans ses politiques [8][9]. C'est le repère de maturité.
- Qui suit vite : les rolling (Arch, Wolfi, et Tumbleweed côté SUSE) par fraîcheur, et SUSE par stratégie.
- Qui suit à son rythme : Ubuntu (avec le cycle 26.04) et Debian (avec trixie), tributaires d'OpenSSL.
- Chaînes à part : Android (BoringSSL et Go) et l'IoT (OpenWrt, piles TLS variées et matériel contraint).
- Le facteur décisif reste l'amont : OpenSSL 3.5 et OpenSSH 10.0 expliquent l'essentiel des différences ; la valeur ajoutée propre d'une distribution se voit surtout dans les politiques système et la signature des paquets.

## 13. Pertinence pour la démo CBOM

Pour chaque image, un CBOM (FND-006) devrait révéler : la version d'OpenSSL ou de la pile TLS (donc la capacité PQC), la présence de certificats et de clés, et la configuration TLS et SSH. Attendus concrets : sur RHEL 10.1, un CBOM riche avec PQC activé et des paquets signés en PQC ; sur Alpine, un CBOM minimal centré sur OpenSSL et les certificats ; sur Ubuntu 24.04, l'absence de PQC natif (sauf OQS) ; sur Wolfi, un CBOM accompagné d'un SBOM. Ces contrastes font de bons cas de démonstration.

## 14. Lexique

- PQC : cryptographie post-quantique.
- ML-KEM, ML-DSA, SLH-DSA : algorithmes standardisés par le NIST (FIPS 203, 204, 205).
- Échange de clés hybride : combinaison d'un algorithme classique et d'un algorithme post-quantique (par exemple X25519MLKEM768).
- crypto-policies : mécanisme de politique cryptographique système (famille RHEL).
- oqsprovider et liboqs : fournisseur et bibliothèque Open Quantum Safe ajoutant le PQC à OpenSSL avant la 3.5.
- undistro : image de base minimale pensée pour les conteneurs (par exemple Wolfi).

## 15. Synthèse

Sur dix images réparties en six catégories, le PQC se diffuse depuis l'amont (OpenSSL 3.5 et OpenSSH 10.0, sortis en 2025) vers les distributions, à une vitesse fixée par leur modèle de publication. RHEL mène nettement (échange de clés PQC dans OpenSSL, GnuTLS et NSS, PQC par défaut dès la 10.1, et signature des paquets en hybride ML-DSA-87 plus Ed448, une première). SUSE suit de façon structurée, Ubuntu et Debian au rythme de leurs stables (26.04 et trixie), AlmaLinux hérite de RHEL sans le volet signature, Arch et Wolfi sont en avance par leur modèle rolling, Alpine offre une surface minimale idéale pour la démo, Android avance via BoringSSL pour le transit web, et l'IoT (OpenWrt) reste hétérogène et contraint. Pour la démo CBOM, ces images offrent une gamme de contrastes utiles.

## 16. Limites

Les états par image moins documentée (Android, OpenWrt, Wolfi, NixOS, Talos) sont des déductions à confirmer sur des versions précises. La présélection de dix images écarte volontairement des candidates (Rocky, NixOS, Talos traités en bref) ; on peut les réintégrer. Les capacités PQC évoluent vite et dépendent de la version exacte installée. L'analyse reste documentaire ; un scan réel (CBOM) la validera, ce qui relève du ticket 006.

## 17. Sources

1. OpenSSL 3.5.0 publiée avec le PQC (ML-KEM, ML-DSA, SLH-DSA ; X25519MLKEM768 par défaut). https://cybersecuritynews.com/openssl-3-5-0-released/
2. Help Net Security, OpenSSL prepares for a quantum future with 3.5.0. https://www.helpnetsecurity.com/2025/04/09/openssl-3-5-0-released/
3. Quantum Computing Report, OpenSSH 10.0 Introduces Default Post-Quantum Key Exchange (mlkem768x25519-sha256). https://quantumcomputingreport.com/openssh-10-0-introduces-default-post-quantum-key-exchange-algorithm/
4. OpenSSH, page officielle sur le post-quantique (historique depuis 9.0, avertissement en 10.1). https://www.openssh.org/pq.html
5. SUSE, State of and strategy for Post Quantum Cryptography at the end of 2025 (OpenSSL, Libgcrypt, NSS, Go ; OpenSSH 10 pas encore ; mention d'Ubuntu et Debian). https://www.suse.com/c/suse-state-of-and-strategy-for-post-quantum-cryptography-at-the-end-of-2025/
6. DebConf 25, Rethinking Cryptography in the Linux Kernel, Preparing for the PQC Era. https://debconf25.debconf.org/talks/211-rethinking-cryptography-in-the-linux-kernel-preparing-for-the-post-quantum-pqc-era/
7. A Survey of Post-Quantum Cryptography Support in Cryptographic Libraries (arXiv). https://arxiv.org/pdf/2508.16078
8. Red Hat, Post-quantum cryptography in Red Hat Enterprise Linux 10 (OpenSSL, GnuTLS, NSS ; signature RPM hybride ML-DSA-87 plus Ed448, première distribution). https://www.redhat.com/en/blog/post-quantum-cryptography-red-hat-enterprise-linux-10
9. Red Hat, What's new in post-quantum cryptography in RHEL 10.1 (PQC par défaut dans toutes les politiques ; TEST-PQ en 10.0). https://www.redhat.com/en/blog/whats-new-post-quantum-cryptography-rhel-101
10. Cryptomathic, OpenSSL 3.5 Post-Quantum Lab, ML-KEM et ML-DSA sur RHEL 9.6. https://www.cryptomathic.com/blog/quantum-ready-cryptography-with-openssl-3.5-on-rhel-9.6
11. heise online, SLES 16, SUSE's Flagship Linux with AI and Post-Quantum Crypto. https://www.heise.de/en/news/SLES-16-SUSE-s-Flagship-Linux-with-AI-and-Post-Quantum-Crypto-10981423.html
12. Ubuntu Community Hub, 24.04 users, get full PQC support in OpenSSL via oqsprovider (et PQC natif dans les versions ultérieures). https://discourse.ubuntu.com/t/how-to-24-04-users-get-full-post-quantum-cryptography-support-in-openssl-via-oqsprovider/82362

> À revalider à l'approche de la présentation : versions exactes embarquées par chaque image, état d'Android (BoringSSL), d'OpenWrt, de Wolfi, de NixOS et de Talos, et progrès du PQC dans le noyau Linux. Un scan CBOM réel (ticket 006) confirmera l'analyse documentaire.
