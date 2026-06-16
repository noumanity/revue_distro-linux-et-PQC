# Analyse PQC par catégorie : soixante images Linux (dix par catégorie) : recherche

> **Statut** : essai de fondation (tâche 4 du ticket `TKT-007-distrubutions-linux`). Élargit [FND-009](FND-009-pqc-par-categorie-dimages.md) (dix images au total) à dix images par catégorie. S'appuie sur [FND-001](FND-001-recherche-preliminaire-pqc-distributions-linux.md) (PQC et distributions), [FND-007](FND-007-familles-linux.md) (familles), [FND-008](FND-008-usages-de-linux.md) (usages) et [FND-006](FND-006-outils-cbom-scan-panorama-comparaison.md) (CBOM). Voir l'artefact de cadrage [04-images-par-categorie](../tickets/TKT-007-distrubutions-linux/04-images-par-categorie.md).
> **Date** : 2026-06-15 ; **Objectif** : analyser l'état de la cryptographie post-quantique (PQC) sur soixante images, dix dans chacune des six catégories d'usage, pour permettre ensuite une sélection finale à partir d'un échantillon large.
> **Note de rigueur** : la maturité PQC se déduit ici surtout (a) des **briques cryptographiques amont** embarquées et (b) du **modèle de publication**. Les faits sourcés concernent les briques et les distributions documentées (RHEL, SUSE, Ubuntu, Debian, Fedora, Amazon Linux, Azure Linux, Android, wolfSSL, mbedTLS). Les postures des images moins documentées sont des **déductions signalées « à confirmer »**, à valider par un scan CBOM réel (ticket 006) sur une version précise. États vérifiés à juin 2026, à revalider (le domaine bouge vite).
> **Périmètre** : l'état PQC des soixante images. La mécanique des algorithmes est dans FND-001 ; l'outillage de mesure dans FND-006 ; la sélection finale pour la présentation relève d'une tâche ultérieure.

## 1. Avertissement méthodologique

On ne peut pas auditer en profondeur soixante images dans un seul essai. La méthode retenue, héritée de FND-009 et validée par lui, exploite un fait structurant : **le PQC ne s'invente pas distribution par distribution, il descend des briques amont** (OpenSSL, OpenSSH, GnuTLS, NSS, BoringSSL, la pile Go, mbedTLS, wolfSSL) vers les images, à une vitesse fixée par leur modèle de publication. Connaître la pile cryptographique et le modèle de publication d'une image suffit donc à situer sa posture PQC avec une bonne fiabilité, à charge de confirmer la version exacte. C'est ce qui rend l'exercice à soixante images tractable. Chaque posture déduite est marquée « à confirmer ».

## 2. Cadrage : six catégories, soixante images

### 2.1 Relation avec FND-009

FND-009 analysait dix images au total (une sélection resserrée couvrant les six catégories). Le présent essai élargit à dix images **par** catégorie (soixante), pour offrir un échantillon de choix plus riche. Les dix images de FND-009 sont reprises ici dans leur catégorie respective, avec cinquante images supplémentaires. FND-009 reste valable comme version courte.

### 2.2 Thèse

Trois forces expliquent presque toute la variance observée. D'abord l'**amont** : OpenSSL 3.5.0 et OpenSSH 10.0 (tous deux 2025) apportent le PQC par défaut ; les piles BoringSSL plus Go l'apportent par une chaîne propre ; mbedTLS et wolfSSL le portent dans le monde contraint. Ensuite le **modèle de publication** : les rolling et les éditeurs proactifs sont en avance, les fixes à support long arrivent à la faveur d'une nouvelle stable. Enfin l'**ajout propre de l'éditeur** : politiques cryptographiques système et signature des paquets en PQC, jalon où Red Hat est seul en tête. Les dérivés (clones RHEL, dérivés Debian, dérivés Fedora, dérivés AOSP) héritent mécaniquement de leur amont.

## 3. Les briques amont qui déterminent tout

- **OpenSSL 3.5.0** (avril 2025) : ML-KEM, ML-DSA et SLH-DSA natifs ; groupe hybride **X25519MLKEM768** par défaut en TLS 1.3 [1][2]. Avant la 3.5, le PQC passait par le fournisseur externe oqsprovider (liboqs).
- **OpenSSH** : échange de clés post-quantique par défaut depuis la 9.0 (2022, sntrup761x25519) ; la 9.9 ajoute mlkem768x25519-sha256, la 10.0 (avril 2025) le met par défaut, la 10.1 avertit quand une connexion n'est pas résistante au quantique [3][4].
- **GnuTLS, Mozilla NSS, pile Go** : implémentent l'hybride x25519mlkem768 [5][7]. Le runtime **Go** active X25519MLKEM768 par défaut en TLS depuis Go 1.24 (début 2025), ce qui couvre d'office les nombreuses images écrites en Go (OS hôtes de conteneurs, Distroless statiques, Talos).
- **BoringSSL** (Google) : ML-KEM implémenté ; Chrome a activé X25519MLKEM768 par défaut depuis la version 131 (novembre 2024) [13]. C'est la pile d'Android et de ses dérivés.
- **wolfSSL** : ML-KEM et ML-DSA en production, utilisables en TLS 1.3, alignés CNSA 2.0 et validés CAVP par le NIST, pensés pour l'embarqué contraint [14]. **mbedTLS** : ML-KEM annoncé mais pas encore intégré à la date de référence ; supporte déjà LMS pour la signature de micrologiciel [15].
- **Réserve LibreSSL** : les images qui s'appuient sur LibreSSL plutôt qu'OpenSSL n'ont pas l'échange de clés PQC natif (à vérifier image par image).
- **Standards** : ML-KEM (FIPS 203), ML-DSA (FIPS 204), SLH-DSA (FIPS 205), publiés par le NIST en août 2024 (voir FND-001).

## 4. Grille d'analyse PQC

Chaque image est située sur cinq dimensions : échange de clés **hybride en TLS** (par exemple X25519MLKEM768) présent par défaut ou non ; **SSH post-quantique** (version d'OpenSSH) ; **signature des paquets en PQC** (jalon avancé) ; **politique cryptographique** système activant le PQC (par exemple crypto-policies) ; **délai d'arrivée** selon le modèle de publication.

## 5. Catégorie 1 : entreprises et HPC

| Image | Pile / amont | Modèle | Posture PQC (synthèse) |
|---|---|---|---|
| RHEL | OpenSSL, GnuTLS, NSS | fixe, éditeur proactif | Meneur : PQC dans trois piles, crypto-policies PQC par défaut dès 10.1, signature RPM hybride ML-DSA-87 plus Ed448 [8][9]. |
| SLES (SUSE) | OpenSSL, Libgcrypt, NSS, Go | fixe, suiveur rapide | PQC intégré ; SLES 16 phare ; OpenSSH 10 pas encore fin 2025 ; stratégie PQC publiée [5][11]. |
| Ubuntu Server/Pro | OpenSSL | fixe (LTS) | PQC natif avec 26.04 (OpenSSL 3.5) ; OQS sur 24.04 [5][12]. |
| Oracle Linux | OpenSSL, GnuTLS, NSS (suit RHEL) | fixe, clone RHEL | Hérite des briques PQC de RHEL 10 ; signe avec sa propre clé (pas le jalon RPM de Red Hat) (à confirmer). |
| Amazon Linux 2023 | OpenSSL 3.2.2 plus crypto-policies | fixe, dérivé Fedora | Active une sous-politique crypto-policies PQ (échange hybride ML-KEM, signatures ML-DSA) malgré OpenSSL 3.2.2 ; mécanisme exact à confirmer [16]. |
| Rocky Linux | suit RHEL | fixe, clone RHEL | Quasi identique à AlmaLinux ; briques PQC de RHEL 10, propre clé de signature. |
| AlmaLinux | suit RHEL | fixe, clone RHEL | Briques PQC de RHEL 10 sans le volet signature Red Hat (FND-009). |
| CentOS Stream | OpenSSL, GnuTLS, NSS | rolling amont de RHEL | Reçoit le PQC avant RHEL (préfiguration des versions RHEL) (à confirmer). |
| Azure Linux (CBL-Mariner) 4.0 | OpenSSL 3.5 plus SymCrypt | fixe, Microsoft | OpenSSL 3.5 (PQC natif) ; SymCrypt prépare la bascule PQC [17]. |
| openSUSE Leap | suit SLES | fixe, pont SUSE | Hérite de SLES ; PQC au rythme des bases SUSE (à confirmer). |

Le supercalcul (HPC, 100 pour cent Linux, FND-008) repose surtout sur des bases RHEL, Rocky et SLES, et hérite donc de leur posture ; l'enjeu PQC y porte sur les communications et l'authentification.

## 6. Catégorie 2 : communautaires et indépendantes

| Image | Pile / amont | Modèle | Posture PQC (synthèse) |
|---|---|---|---|
| Debian | OpenSSL | fixe, prudent | Pas de PQC en 12 (bookworm) ; attendu avec 13 (trixie) [5]. |
| Fedora | OpenSSL 3.5 | semi-rolling, labo de RHEL | PQC natif (42 et 43, X25519MLKEM768 par défaut) [18]. |
| openSUSE Tumbleweed | OpenSSL 3.5, OpenSSH 10 | rolling | PQC tôt par fraîcheur (à confirmer sur une version). |
| Arch Linux | OpenSSL 3.5, OpenSSH 10 | rolling | TLS hybride et SSH PQC tôt (FND-009). |
| Linux Mint | OpenSSL (suit Ubuntu) | fixe, dérivé Ubuntu | Suit Ubuntu ; PQC avec la base 26.04 (à confirmer). |
| Manjaro | OpenSSL (suit Arch, léger décalage) | rolling encadré | PQC tôt mais après Arch (à confirmer). |
| Gentoo | OpenSSL 3.5 (source) | source, à la carte | PQC disponible selon la version compilée et les USE flags (à confirmer). |
| Void Linux | OpenSSL ou LibreSSL | rolling | PQC si variante OpenSSL 3.5 ; la variante LibreSSL n'a pas le PQC natif (à confirmer). |
| Slackware | OpenSSL | conservateur | PQC tardif (cycle long) (à confirmer). |
| Devuan | OpenSSL (suit Debian) | fixe, dérivé Debian | Aligné sur Debian (trixie) (à confirmer). |

## 7. Catégorie 3 : spécialisées images (conteneur)

| Image | Pile / amont | Modèle | Posture PQC (synthèse) |
|---|---|---|---|
| Alpine | musl plus OpenSSL | rapide | TLS hybride sur versions basées OpenSSL 3.5 ; surface crypto minimale (FND-009). |
| Wolfi (Chainguard) | glibc plus OpenSSL | rolling | OpenSSL 3.5 tôt ; SBOM et signature Sigstore ; très bon cas de démo (FND-009)[19]. |
| Chainguard Images | basées Wolfi | rolling, durci | Héritent de Wolfi ; minimales, signées, near-zéro CVE [19]. |
| Google Distroless | minimal, souvent binaire Go | suit base Debian ou app | Pas de shell ; la crypto vient de l'app ; un binaire Go bénéficie du PQC de Go (à confirmer). |
| Debian-slim | OpenSSL (suit Debian) | fixe | Suit Debian (PQC avec trixie). |
| Ubuntu minimal | OpenSSL (suit Ubuntu) | fixe | Suit Ubuntu (PQC avec 26.04). |
| Red Hat UBI micro | suit RHEL | fixe | Hérite des briques PQC de RHEL 10 (à confirmer sur ubi-micro). |
| BusyBox | quasi pas de TLS propre | ultra-minimal | Crypto dépend entièrement de l'app ajoutée ; l'image en soi n'apporte pas de PQC. |
| Photon OS (VMware) | OpenSSL | fixe, cloud et conteneur | PQC selon la version d'OpenSSL embarquée (à confirmer). |
| Image `scratch` (binaire statique) | runtime du langage de l'app | sans base | Aucune crypto d'OS ; un binaire Go statique apporte le PQC de Go, un binaire C dépend de sa libssl liée (à confirmer). |

## 8. Catégorie 4 : mobile

| Image | Pile / amont | Modèle | Posture PQC (synthèse) |
|---|---|---|---|
| Android (AOSP) | BoringSSL, Conscrypt | chaîne Google | Chrome a le PQC (X25519MLKEM768) ; pas de bascule plateforme documentée dans Conscrypt et Keystore en mars 2026 [13][20]. |
| GrapheneOS | base AOSP durcie | suit AOSP | Suit BoringSSL système ; discussions sur les courbes PQ TLS système (à confirmer)[20]. |
| LineageOS | base AOSP | suit AOSP | Posture d'AOSP (à confirmer). |
| /e/OS | base LineageOS | dérivé | Hérite de LineageOS et donc d'AOSP (à confirmer). |
| CalyxOS | base AOSP | dérivé | Posture d'AOSP (à confirmer). |
| postmarketOS | base **Alpine** (musl plus OpenSSL) | rolling | Cas notable : pile Linux classique sur mobile, donc PQC via OpenSSL 3.5 d'Alpine (à confirmer). |
| Ubuntu Touch (UBports) | OpenSSL (base Ubuntu) | fixe | Suit la base Ubuntu (à confirmer). |
| Sailfish OS | OpenSSL | fixe | PQC selon la version d'OpenSSL (à confirmer). |
| Mobian | OpenSSL (base Debian) | fixe | Suit Debian (trixie) (à confirmer). |
| KaiOS | base Android et Gecko | dérivé | Pile mixte ; PQC dépend des composants (à confirmer). |

L'espace mobile a deux chaînes : la chaîne Google (BoringSSL, avance sur le transit web, retard sur la plateforme) et une chaîne « Linux classique » (postmarketOS, Mobian, Ubuntu Touch) qui hérite d'OpenSSL.

## 9. Catégorie 5 : IoT et embarqué

| Image | Pile / amont | Modèle | Posture PQC (synthèse) |
|---|---|---|---|
| OpenWrt | OpenSSL, wolfSSL ou mbedTLS selon build | fixe, contraint | PQC selon la pile TLS choisie et le coût mémoire et CPU (FND-009). |
| Yocto / Poky | configurable | build sur mesure | PQC possible via la couche meta-oqs (expérimental) ou wolfSSL [21]. |
| Buildroot | configurable | build sur mesure | PQC selon la pile TLS sélectionnée (OpenSSL, wolfSSL) (à confirmer). |
| Raspberry Pi OS | OpenSSL (base Debian) | fixe | Suit Debian (PQC avec trixie). |
| Ubuntu Core | OpenSSL, snaps (base Ubuntu) | fixe | Suit Ubuntu ; PQC avec la base 26.04 (à confirmer). |
| BalenaOS | Yocto, conteneurs | fixe | Selon la pile Yocto et les conteneurs déployés (à confirmer). |
| Tizen (Samsung) | OpenSSL | fixe | PQC selon la version d'OpenSSL (à confirmer). |
| Automotive Grade Linux | Yocto | fixe, automobile | Selon la pile Yocto ; cycle long (à confirmer). |
| Torizon (Toradex) | conteneurs sur base embarquée | fixe | Selon la base et les conteneurs (à confirmer). |
| Wind River Linux | Yocto commercial | fixe, durci | PQC selon configuration ; offre commerciale orientée sécurité (à confirmer). |

L'IoT contraint est le segment le plus en retard et hétérogène : longévité des appareils, mises à jour difficiles, coût des algorithmes PQC sur petit matériel. wolfSSL y est la voie la plus mûre (validé CNSA 2.0) ; mbedTLS n'a pas encore ML-KEM [14][15].

## 10. Catégorie 6 : spécialités notables

| Image | Pile / amont | Modèle | Posture PQC (synthèse) |
|---|---|---|---|
| NixOS | OpenSSL 3.5 | rolling, déclaratif | PQC tôt ; reproductibilité utile pour auditer la crypto d'un système (FND-009). |
| Talos Linux | très majoritairement Go | rolling, minimal K8s | Hérite du PQC de Go (X25519MLKEM768) pour ses communications (à confirmer). |
| Flatcar Container Linux | Go plus OpenSSL | rolling, hôte conteneur | PQC via Go et OpenSSL embarqué (à confirmer). |
| Bottlerocket (AWS) | Go plus OpenSSL | fixe, hôte conteneur | PQC via Go et la pile embarquée (à confirmer). |
| Fedora CoreOS | OpenSSL 3.5 (base Fedora) | rolling, hôte conteneur | Hérite du PQC natif de Fedora [18]. |
| Qubes OS | templates Fedora et Debian | fixe, isolation par VM | Posture des templates (Fedora en avance, Debian avec trixie) (à confirmer). |
| Tails | base Debian, Tor | fixe, anonymat | PQC via Debian (trixie) et l'évolution PQC de Tor (à confirmer). |
| Kali Linux | base Debian (testing) | rolling, pentest | Suit Debian testing, donc PQC relativement tôt (à confirmer). |
| GNU Guix System | OpenSSL | rolling, reproductible | PQC selon la version d'OpenSSL ; atout reproductibilité (à confirmer). |
| Fedora Silverblue/Atomic | OpenSSL 3.5 (base Fedora) | semi-rolling, immuable | Hérite du PQC natif de Fedora ; image immuable [18]. |

## 11. Synthèse transverse par catégorie

| Catégorie | Maturité PQC d'ensemble | Meneurs | À la traîne |
|---|---|---|---|
| 1. Entreprises et HPC | Élevée | RHEL (signature RPM PQC), Azure Linux et Fedora-dérivés (OpenSSL 3.5) | Amazon Linux 2023 (OpenSSL 3.2.2) |
| 2. Communautaires | Élevée pour les rolling | Fedora, Tumbleweed, Arch | Slackware, Debian stable actuelle |
| 3. Conteneur | Moyenne à élevée | Wolfi et Chainguard (fraîcheur plus signature), Alpine récent | BusyBox et `scratch` (pas de crypto d'OS) |
| 4. Mobile | Faible côté plateforme | Transit web via BoringSSL ; postmarketOS via OpenSSL | Plateforme AOSP (pas de bascule documentée) |
| 5. IoT et embarqué | Faible et hétérogène | wolfSSL (CNSA 2.0) | mbedTLS (pas encore ML-KEM), appareils anciens |
| 6. Spécialités | Moyenne à élevée | Fedora CoreOS, NixOS, images Go (Talos) | Dépend des templates et bases |

## 12. Analyse transverse

- **Qui mène** : Red Hat (RHEL), seul à signer ses paquets en PQC et à activer le PQC par défaut dans ses politiques [8][9]. Repère de maturité.
- **Qui suit vite** : les rolling et semi-rolling (Arch, Tumbleweed, Fedora, NixOS, Wolfi) par fraîcheur, et SUSE et Azure Linux par stratégie.
- **Qui suit à son rythme** : Ubuntu (26.04), Debian (trixie) et tous leurs nombreux dérivés (Mint, Devuan, Raspberry Pi OS, Mobian, Tails, Kali, Ubuntu Core, Ubuntu Touch).
- **Chaînes à part** : Android et dérivés (BoringSSL, avance web et retard plateforme), l'IoT contraint (wolfSSL et mbedTLS), et le monde Go (PQC par le runtime, indépendant d'OpenSSL).
- **Effet dérivé** : la majorité des soixante images n'ont pas de posture propre ; elles **héritent** d'un des cinq amonts (RHEL, Debian, Fedora, OpenSSL générique, BoringSSL plus Go). Identifier l'amont d'une image prédit l'essentiel de sa posture PQC.

## 13. Pertinence pour la démo CBOM

Un scan CBOM (FND-006) sur un échantillon contrasté illustrerait toute la gamme : RHEL 10.1 (CBOM riche, PQC activé, paquets signés en PQC), Fedora ou Azure Linux (OpenSSL 3.5 natif), Ubuntu 24.04 (absence de PQC natif sauf OQS), Alpine et Wolfi (CBOM minimal, Wolfi avec SBOM), un binaire Go statique ou Talos (PQC venant du runtime, pas d'OpenSSL visible), et un cas IoT (OpenWrt avec wolfSSL ou mbedTLS). Ces contrastes valideraient l'analyse documentaire et feraient de bons supports de présentation.

## 14. Synthèse

Sur soixante images réparties en six catégories, la diffusion du PQC obéit à trois forces : l'amont (OpenSSL 3.5, OpenSSH 10, BoringSSL, Go 1.24, wolfSSL), le modèle de publication, et l'ajout propre de l'éditeur (politiques système, signature des paquets). RHEL mène nettement ; les rolling et les dérivés Fedora suivent tôt ; Ubuntu, Debian et leurs très nombreux dérivés suivent au rythme de leurs stables ; le conteneur est mûr côté images fraîches et signées (Wolfi, Chainguard) ; le mobile avance sur le transit web mais pas sur la plateforme ; l'IoT contraint reste en retard, wolfSSL faisant exception. La leçon transverse : pour situer n'importe quelle image, il faut d'abord identifier son amont cryptographique, car la plupart des images héritent plus qu'elles n'innovent.

## 15. Limites et péremption

- **Déductions à confirmer** : la majorité des postures hors des distributions phares sont déduites des briques amont et du modèle de publication ; elles doivent être vérifiées sur une version précise, idéalement par un scan CBOM (ticket 006).
- **Chevauchements de catégories** assumés : certains clones (Rocky, Alma), dérivés (Fedora CoreOS, Silverblue) et OS hôtes (Flatcar, Bottlerocket) pourraient figurer dans plusieurs catégories ; chacun est rangé dans sa catégorie de meilleur ajustement.
- **Mécanismes à préciser** : le PQC d'Amazon Linux 2023 via crypto-policies malgré OpenSSL 3.2.2, l'état exact d'OpenSSH 10 chez SUSE, et la trajectoire plateforme d'Android (Conscrypt, Keystore) restent à documenter finement.
- **Péremption** : versions embarquées, calendrier des stables (Ubuntu 26.04, Debian trixie) et progrès de mbedTLS et du noyau Linux évoluent vite ; à revalider à l'approche de la présentation.
- **Non couvert** : le détail des coûts de performance des algorithmes PQC sur matériel contraint, et la sélection finale des images à présenter (tâche ultérieure).

## 16. Sources

1. OpenSSL 3.5.0 publiée avec le PQC (X25519MLKEM768 par défaut). https://cybersecuritynews.com/openssl-3-5-0-released/
2. Help Net Security, OpenSSL prepares for a quantum future with 3.5.0. https://www.helpnetsecurity.com/2025/04/09/openssl-3-5-0-released/
3. Quantum Computing Report, OpenSSH 10.0 Introduces Default Post-Quantum Key Exchange. https://quantumcomputingreport.com/openssh-10-0-introduces-default-post-quantum-key-exchange-algorithm/
4. OpenSSH, page officielle sur le post-quantique. https://www.openssh.org/pq.html
5. SUSE, State of and strategy for Post Quantum Cryptography at the end of 2025. https://www.suse.com/c/suse-state-of-and-strategy-for-post-quantum-cryptography-at-the-end-of-2025/
6. DebConf 25, Rethinking Cryptography in the Linux Kernel. https://debconf25.debconf.org/talks/211-rethinking-cryptography-in-the-linux-kernel-preparing-for-the-post-quantum-pqc-era/
7. A Survey of Post-Quantum Cryptography Support in Cryptographic Libraries (arXiv 2508.16078). https://arxiv.org/pdf/2508.16078
8. Red Hat, Post-quantum cryptography in Red Hat Enterprise Linux 10. https://www.redhat.com/en/blog/post-quantum-cryptography-red-hat-enterprise-linux-10
9. Red Hat, What's new in post-quantum cryptography in RHEL 10.1. https://www.redhat.com/en/blog/whats-new-post-quantum-cryptography-rhel-101
10. Cryptomathic, OpenSSL 3.5 Post-Quantum Lab (ML-KEM et ML-DSA sur RHEL 9.6). https://www.cryptomathic.com/blog/quantum-ready-cryptography-with-openssl-3.5-on-rhel-9.6
11. heise online, SLES 16, SUSE's Flagship Linux with AI and Post-Quantum Crypto. https://www.heise.de/en/news/SLES-16-SUSE-s-Flagship-Linux-with-AI-and-Post-Quantum-Crypto-10981423.html
12. Ubuntu Community Hub, 24.04 users get full PQC support in OpenSSL via oqsprovider. https://discourse.ubuntu.com/t/how-to-24-04-users-get-full-post-quantum-cryptography-support-in-openssl-via-oqsprovider/82362
13. ML-KEM dans BoringSSL et Chrome 131 (X25519MLKEM768 par défaut, novembre 2024). https://en.wikipedia.org/wiki/ML-KEM
14. wolfSSL, Support for the Official Post-Quantum Standards ML-KEM and ML-DSA (TLS 1.3, CNSA 2.0, CAVP). https://www.wolfssl.com/support-for-the-official-post-quantum-standards-ml-kem-and-ml-dsa/
15. Mbed TLS et la PQC (ML-KEM à venir, LMS pour la signature de micrologiciel) ; survey arXiv 2508.16078. https://arxiv.org/html/2508.16078v1
16. AWS, Enable Post-Quantum Cryptography (PQC) on AL2023 (sous-politique crypto-policies PQ). https://docs.aws.amazon.com/linux/al2023/ug/crypto-policies-pq.html
17. InfoWorld, Up and running with Azure Linux (OpenSSL 3.5 en 4.0, SymCrypt en 3.0). https://www.infoworld.com/article/4043164/up-and-running-with-azure-linux-3-0.html
18. OpenSSL 3.5 dans Fedora 42 et 43 (X25519MLKEM768 par défaut). https://cybersecuritynews.com/openssl-3-5-0-released/
19. Chainguard Academy, Wolfi FAQs (undistro, glibc, apk, SBOM et signature Sigstore). https://edu.chainguard.dev/open-source/wolfi/faq/
20. Android 17 Quantum-Safe Security: What's Protected and What's Not (pas de bascule plateforme en mars 2026). https://android.gadgethacks.com/news/android-17-quantum-safe-security-whats-protected-and-whats-not/
21. embetrix/meta-oqs, couche OpenEmbedded et Yocto pour la PQC embarquée (expérimental, liboqs). https://github.com/embetrix/meta-oqs

> À revalider à l'approche de la présentation : versions exactes embarquées par chaque image, mécanisme PQC d'Amazon Linux 2023, trajectoire plateforme d'Android, état de mbedTLS, et progrès du PQC dans le noyau Linux. Un scan CBOM réel (ticket 006) confirmera l'analyse documentaire.
