# Le « risque quantique » et les distributions Linux — recherche préliminaire

> **Statut** : essai de fondation (tâches 5 et 6 du ticket `000`).
> **Date** : juin 2026.
> **Révision (tâche 6)** : couverture élargie — ajout de Rocky Linux et de la famille des
> clones RHEL, panorama des **20 distributions les plus utilisées** et des **10 images de
> conteneurs les plus utilisées** (voir §3.0 et §3.6).
> **Objectif** : établir une base factuelle rigoureuse sur (1) la menace quantique,
> (2) les briques cryptographiques qui la concernent, (3) l'état d'intégration de la
> cryptographie post-quantique (PQC) dans les grandes distributions Linux et les
> distributions spécialisées pour conteneurs.
>
> ⚠️ **Note de rigueur** : ce document doit servir de socle « irréprochable » pour la
> présentation. Chaque affirmation factuelle importante est rattachée à une source
> (voir la section *Sources*). Les dates et numéros de version sont vérifiés à juin 2026
> et devront être revalidés à l'approche de l'événement (l'écosystème bouge vite).

---

## 1. Cadrage : qu'est-ce que le « risque quantique », exactement ?

### 1.1 Ce qui est menacé (et ce qui ne l'est pas)

Le « risque quantique » n'est pas « la fin de toute la cryptographie ». Il faut
distinguer deux familles :

- **Cryptographie asymétrique** (RSA, Diffie-Hellman, courbes elliptiques ECDH/ECDSA) :
  **cassée** par un ordinateur quantique suffisamment puissant, via l'**algorithme de
  Shor** (factorisation et logarithme discret en temps polynomial). C'est le cœur du
  problème : échange de clés TLS, signatures de certificats, signatures de paquets,
  clés SSH, etc.
- **Cryptographie symétrique** (AES) et **fonctions de hachage** (SHA-2/SHA-3) :
  seulement **affaiblies**. L'**algorithme de Grover** n'offre qu'une accélération
  quadratique ⇒ il « divise par deux » la sécurité effective. La parade est simple :
  doubler la taille des clés. **AES-256 et SHA-384/512 restent considérés sûrs.**

**Conséquence pratique** : la migration post-quantique concerne essentiellement deux
primitives asymétriques — l'**échange de clés** (remplacé par un *KEM*, mécanisme
d'encapsulation de clé) et les **signatures numériques**.

### 1.2 « Harvest now, decrypt later » : pourquoi c'est déjà un enjeu

Même si aucun ordinateur quantique pertinent (CRQC, *Cryptographically Relevant Quantum
Computer*) n'existe aujourd'hui, le risque est **présent** : un adversaire peut
**capter et stocker** aujourd'hui du trafic chiffré pour le **déchiffrer plus tard**,
une fois le CRQC disponible (« *Harvest Now, Decrypt Later* », HNDL). Toute donnée à
**longue durée de vie de confidentialité** (secrets d'État, dossiers médicaux, propriété
intellectuelle) est donc exposée *dès maintenant*. C'est ce qui justifie de prioriser
l'**échange de clés** (confidentialité) avant les signatures (authenticité, qui n'a de
valeur qu'au moment présent).

### 1.3 Échéancier et pression réglementaire

- La plupart des projections situent l'arrivée d'un CRQC dans **les années 2030** (avec
  une forte incertitude). Une étude Google Quantum AI (2025) a *abaissé* l'estimation :
  casser RSA-2048 pourrait nécessiter **moins de 1 million de qubits bruités**.
- **NSA — CNSA 2.0** (jalons indicatifs) : PQC exigée pour les nouvelles acquisitions de
  systèmes de sécurité nationale **à partir de 2027** ; RSA-2048 et ECC P-256
  **dépréciés d'ici 2030** ; algorithmes vulnérables **éliminés d'ici 2035**.

Le message à retenir : **ce n'est pas une panique, c'est un calendrier.** Le travail de
modernisation doit commencer maintenant pour être terminé avant la fin de la décennie.

---

## 2. Les standards et les briques logicielles communes

Toutes les distributions Linux partagent les mêmes briques cryptographiques de base.
Comprendre l'état de ces briques, c'est comprendre 80 % de l'état des distributions.

### 2.1 Les standards NIST (août 2024)

Le 13 août 2024, le NIST a publié les trois premiers standards finalisés :

| Standard | Algorithme | Origine | Usage |
|---|---|---|---|
| **FIPS 203** | **ML-KEM** | CRYSTALS-Kyber | Encapsulation de clé (échange de clés) |
| **FIPS 204** | **ML-DSA** | CRYSTALS-Dilithium | Signature numérique (défaut recommandé) |
| **FIPS 205** | **SLH-DSA** | SPHINCS+ | Signature à base de hachage (hypothèse de sécurité distincte, plan B) |

Un quatrième, **FN-DSA** (Falcon, futur FIPS 206), est attendu. ML-KEM se décline en
512/768/1024 (niveaux 1/3/5) ; ML-KEM-768 est le choix courant.

### 2.2 L'approche « hybride » (clé pour comprendre les déploiements)

Plutôt que de remplacer brutalement le classique par du PQC (encore jeune), l'industrie
déploie des schémas **hybrides** : on combine un algorithme classique éprouvé et un
algorithme post-quantique dans le **même handshake**. Si l'un des deux tombe, l'autre
protège encore. Exemple emblématique : **`X25519MLKEM768`** (TLS) et
**`mlkem768x25519-sha256`** (SSH).

### 2.3 État des briques (juin 2026)

- **OpenSSL 3.5.0** (8 avril 2025, *LTS* jusqu'en 2030) : support **natif** de ML-KEM,
  ML-DSA et SLH-DSA. Par défaut, le partage de clé TLS propose **`X25519MLKEM768`**.
  C'est l'événement charnière : avant, il fallait le greffon tiers `oqs-provider` ;
  désormais c'est intégré. **La présence d'OpenSSL 3.5 dans une distribution est le
  meilleur indicateur de sa capacité PQC.**
- **OpenSSH** : échange de clés post-quantique **par défaut depuis la 9.0** (avril 2022,
  via `sntrup761x25519`). La **9.9** (sept. 2024) a ajouté `mlkem768x25519-sha256` ; la
  **10.0** (avril 2025) en a fait le **défaut** ; la **10.1** **avertit** désormais quand
  un échange non post-quantique est utilisé. SSH est **en avance** sur le reste.
- **GnuTLS** et **NSS** : échange de clés PQC livré notamment dans RHEL 10.
- **GnuPG 2.5.19** (avril 2026) : ajoute Kyber / ML-KEM (chiffrement). Le standard
  **OpenPGP PQC** (composite ML-KEM + ML-DSA, plus SLH-DSA) est attendu pour le 1ᵉʳ
  semestre 2026 ; **Sequoia-PGP** suit le même chemin.

---

## 3. Panorama des distributions : usage, spécialisation et feuille de route PQC

### 3.0 Vue d'ensemble — les 20 distributions Linux les plus utilisées

> **Méthodologie / honnêteté intellectuelle** : il n'existe **pas** de classement unique
> et incontestable de « popularité ». Le tableau ci-dessous est une synthèse curatée
> combinant : part de marché *entreprise* (RHEL ≈ 43 %, Ubuntu ≈ 34 %, SUSE ≈ 11 %),
> usage *cloud* (Ubuntu > 60 % des instances Linux en cloud public), et popularité
> *poste de travail* (DistroWatch, enquêtes développeurs). À traiter comme un ordre de
> grandeur, pas comme un palmarès exact.

**Idée-clé** : la plupart des distributions sont des **dérivées**. Leur statut PQC est
donc **hérité de leur amont**. Les 20 distributions se ramènent à ~6 familles, et c'est
au niveau de la **famille** que se décide l'essentiel.

| # | Distribution | Famille / amont | Usage principal | Statut PQC (juin 2026) |
|---|---|---|---|---|
| 1 | **Ubuntu** | Debian | Cloud, serveur, poste | SSH PQC **par défaut** (26.04 LTS), OpenSSL 3.5 |
| 2 | **Debian** | *racine* | Serveur universel, base de dérivées | Primitives présentes (trixie + OpenSSL 3.5), pas d'orchestration |
| 3 | **RHEL** | *racine RH* | Entreprise | **Référence** : KEM + signatures RPM + SSH par défaut (10.2) |
| 4 | **CentOS Stream** | amont RHEL | Dév entreprise, amont de RHEL | Reçoit la PQC RHEL **en avance** |
| 5 | **Rocky Linux** | clone RHEL | Entreprise gratuit | ≡ RHEL 10.2 (PQC détaillée), sans validation FIPS propre |
| 6 | **AlmaLinux** | clone RHEL | Entreprise gratuit | ≡ RHEL (même code crypto) |
| 7 | **Fedora** | amont RHEL | Innovation, poste | OpenSSL 3.5 natif (F43), politique `TEST-PQ` |
| 8 | **openSUSE** (Leap/Tumbleweed) | SUSE | Communauté | Hybride **ML-KEM-768 + X25519** |
| 9 | **SLES** | SUSE | Entreprise, SAP, edge | SLES 16 « **construit avec la PQC** » |
| 10 | **Oracle Linux** | clone RHEL | Entreprise, Oracle Cloud | OpenSSL 3.5, PQC livrée (9.7 / 10.1) |
| 11 | **Amazon Linux 2023** | dérivé Fedora | AWS | **Sous-politique PQ** (ML-KEM + ML-DSA) |
| 12 | **Azure Linux** (CBL-Mariner) | Fedora (v4.0) | Azure, conteneurs, edge | Suit Fedora ; pile SymCrypt-OpenSSL |
| 13 | **Arch Linux** | *racine* | Rolling, public technique | Primitives **très tôt** (OpenSSL 3.5 / OpenSSH 10), config manuelle |
| 14 | **Alpine Linux** | *racine* (musl) | Conteneurs, embarqué | 3.22 **active la PQC** (OpenSSL 3.5) |
| 15 | **Linux Mint** | Ubuntu/Debian | Poste grand public | **Hérite** d'Ubuntu/Debian |
| 16 | **Pop!\_OS** | Ubuntu | Poste, dév/IA | Hérite d'Ubuntu |
| 17 | **Manjaro** | Arch | Poste | Hérite d'Arch (primitives présentes) |
| 18 | **Kali Linux** | Debian | Sécurité offensive | Hérite de Debian |
| 19 | **Raspberry Pi OS** | Debian | Edge, IoT, éducation (ARM) | Hérite de Debian |
| 20 | **Gentoo** | *racine* (source) | Technique, performance | Compile OpenSSL 3.5 → primitives disponibles |

*Autres notables hors top 20* : MX Linux, Zorin, elementary (famille Debian/Ubuntu) ;
EndeavourOS, Garuda (famille Arch) ; Slackware, Void, NixOS, Clear Linux (indépendantes).
Toutes suivent la même logique d'héritage ou d'accès direct aux primitives via
OpenSSL/OpenSSH.

**Lecture du tableau** : la **famille RHEL** (lignes 3-7, 10, et influence sur 11-12) et
la **famille Debian** (lignes 1-2, 15-16, 18-19) couvrent à elles seules la grande
majorité des déploiements — et ce sont précisément les deux familles les plus avancées
ou les mieux outillées sur la PQC.

### 3.1 Red Hat — Fedora / RHEL  → *le plus systématique*

- **Usage / spécialisation** : référence de l'entreprise (RHEL, support long), avec
  **Fedora** comme amont d'innovation et **CentOS Stream** entre les deux.
- **Atout structurel** : le mécanisme **`crypto-policies`** configure *toutes* les
  bibliothèques crypto du système d'un seul endroit — un levier unique pour activer la
  PQC de façon cohérente (politique `TEST-PQ` sur Fedora).
- **Feuille de route** :
  - *Recherche* annoncée dès 2024 (Red Hat Research / Fedora).
  - **Fedora 42** : PQC via `oqs-provider` + politique `TEST-PQ` ; **Fedora 43** : passe à
    OpenSSL 3.5 natif (greffon tiers devenu inutile).
  - **RHEL 10** (mai 2025) : échange de clés PQC dans **OpenSSL, GnuTLS et NSS** ;
    OpenSSH 9.9.
  - **RHEL 10.1** : nouveaux algorithmes **par défaut** en TLS ; **signatures PQC pour les
    paquets RPM** (aperçu technologique, clés hybrides **ML-DSA-87 + Ed448** via
    Sequoia-PGP).
  - **RHEL 10.2** (mai 2026) : échange de clés **SSH post-quantique activé par défaut**,
    y compris en **mode FIPS**.
- **Verdict** : couverture la plus large (KEM + signatures + paquets + défauts +
  FIPS) et la plus orientée production.

### 3.1bis La famille RHEL — CentOS Stream, Rocky, AlmaLinux, Oracle Linux  → *l'effet d'entraînement*

C'est l'enseignement majeur de la révision (tâche 6) : la force de Red Hat **se propage à
tout son écosystème**. Les clones reconstruisent les paquets de RHEL ⇒ ils héritent du
**même code cryptographique**.

- **CentOS Stream** : *amont* de RHEL → reçoit les nouveautés PQC **avant** RHEL.
- **Rocky Linux** : **Rocky 10.2** (GA le 29 mai 2026) illustre parfaitement l'héritage —
  échange hybride ML-KEM en **mode FIPS d'OpenSSH** (`mlkem768nistp256-sha256`,
  `mlkem1024nistp384-sha384`), méthodes hybrides **PQ/T** dans `libssh`, **certificats TLS
  à clés ML-DSA** (ML-DSA-44/65/87) côté Directory Server, signatures composites
  post-quantiques via `podman-sequoia`, et politique `FUTURE` **n'autorisant plus que** les
  échanges hybrides ML-KEM.
- **AlmaLinux** : même logique, **même code crypto** que RHEL/Rocky.
- **Oracle Linux** : OpenSSL 3.5 avec PQC livré dans **9.7 et 10.1** ; Oracle contribue même
  en amont à OpenSSL (et alimente sa pile « Jipher »).
- ⚠️ **Nuance importante (à dire honnêtement)** : les clones ont le **code** identique mais
  **pas la validation FIPS** indépendante. « *La crypto est fonctionnellement identique, mais
  la paperasse n'est pas là.* » Pour un contexte réglementé, cela compte.

**À retenir** : choisir un clone RHEL, c'est obtenir la feuille de route PQC de Red Hat
**gratuitement**, au prix d'un léger décalage temporel et de l'absence de certification propre.

### 3.1ter Les Linux des nuages — Amazon Linux & Azure Linux  → *la PQC pousse par le cloud*

- **Amazon Linux 2023** (dérivé de Fedora) : introduit une **sous-politique PQ** activant
  l'échange hybride **ML-KEM** et les signatures **ML-DSA** par-dessus les politiques
  `DEFAULT`/`FUTURE`/`FIPS`. AWS pousse aussi la PQC dans ses propres services (KMS, ACM…).
- **Azure Linux** (ex-CBL-Mariner) : **officiellement basé sur Fedora depuis la v4.0** →
  suit la trajectoire PQC de Fedora ; pile cryptographique autour de **SymCrypt-OpenSSL**
  (le moteur crypto de Microsoft, lui-même doté de PQC). Usage : services internes Azure,
  AKS, edge.

### 3.2 SUSE — SLES / openSUSE  → *intégré nativement, proche derrière*

- **Usage / spécialisation** : entreprise (SLES), SAP, edge ; **openSUSE Leap**
  (stable) et **Tumbleweed** (rolling) côté communauté.
- **Feuille de route** :
  - **SLES 16.0** (GA le 4 novembre 2025) : **construit avec la PQC**, OpenSSL 3.5
    (ML-KEM, ML-DSA), explicitement positionné contre le HNDL.
  - **openSUSE Leap et Tumbleweed** : cryptographie hybride post-quantique
    (**ML-KEM-768 + X25519**).
  - Stratégie PQC publiée (« SUSE state of and strategy for PQC », fin 2025).

### 3.3 Debian  → *les primitives sont là, l'orchestration reste conservatrice*

- **Usage / spécialisation** : socle universel, stabilité, base de très nombreuses
  distributions dérivées (dont Ubuntu).
- **Feuille de route** :
  - **Debian 13 « trixie »** (août 2025) embarque **OpenSSL 3.5** ⇒ la PQC en TLS est
    **disponible**.
  - Debian n'a **pas** d'équivalent à `crypto-policies` : l'activation dépend des
    versions de paquets et de la configuration applicative. Approche prudente, fidèle à
    sa culture ; la prochaine *stable* (« forky ») arrivera plus tard.

### 3.4 Canonical — Ubuntu  → *se consolide avec la 26.04 LTS*

- **Usage / spécialisation** : la plus grand public côté serveur et poste, forte
  présence cloud et télécom (5G).
- **Feuille de route** :
  - **24.04 LTS** : PQC **partielle**, principalement via `oqs-provider` (procédure
    documentée par la communauté).
  - **26.04 LTS** (avril 2026) : **OpenSSL 3.5** et échange de clés **SSH hybride
    post-quantique par défaut** (`mlkem768x25519-sha256`, hérité d'OpenSSH 10) ; durcissement
    général (TPM 2.0, etc.). Communications dédiées sur le télécom quantum-safe.

### 3.5 Arch Linux (et autres *rolling*)  → *accès précoce aux primitives*

- **Usage / spécialisation** : *rolling release*, public technique, fraîcheur maximale.
- **Constat PQC** : par construction, Arch (comme **openSUSE Tumbleweed**) reçoit
  **OpenSSL 3.5 / OpenSSH 10 très tôt** ⇒ les primitives PQC sont disponibles vite. En
  revanche, **pas d'orchestration « politique » d'entreprise** ni de mode FIPS : c'est à
  l'utilisateur de configurer. Idéal pour expérimenter, moins pour la conformité.

### 3.6 Alpine et le monde des conteneurs  → *le volet « images »*

Les distributions taillées pour les **images de conteneurs** méritent un volet à part :
minimalistes, omniprésentes, et au cœur de la **sécurité de la chaîne
d'approvisionnement**.

- **Alpine Linux** (musl, busybox, `apk`) : base de très nombreuses images. **Alpine 3.22**
  active la PQC immédiatement (OpenSSL 3.5).
- **Wolfi / Chainguard** : distribution *sans noyau* pensée **pour les conteneurs** et la
  **supply chain** (paquets granulaires, images *zéro-CVE*, `apk`). PQC activée dans les
  conteneurs ; **Chainguard FIPS Provider** pour OpenSSL 3.6 (FIPS 203/204/205) soumis en
  octobre 2025, validation attendue ~Q4 2026. C'est un acteur **qui se distingue** sur ce
  créneau.
- **distroless (Google)**, **RHEL UBI micro**, **Ubuntu Chiseled** : surface minimale ; la
  capacité PQC dépend des bibliothèques embarquées (souvent celles de la distro mère) et
  de la chaîne de build.

#### Les 10 images de conteneurs les plus utilisées

> **Précision méthodologique** : les images les plus *tirées* (« pulled ») de Docker Hub
> sont souvent des images **applicatives** (`nginx`, `redis`, `postgres`, `node`,
> `python`…). Mais elles sont **construites sur** un petit nombre d'images **de base**
> (l'OS du conteneur). C'est ce socle qui détermine la capacité PQC ; le tableau ci-dessous
> liste donc les **images de base** dominantes. Pour une image applicative, le statut PQC =
> celui de sa base **+** la bibliothèque TLS propre à l'application.

| # | Image de base | Famille | Rôle | Statut PQC (juin 2026) |
|---|---|---|---|---|
| 1 | **Alpine** | indépendante (musl) | Base minimaliste dominante (~5 Mo) | 3.22 → PQC via OpenSSL 3.5 |
| 2 | **Ubuntu** | Debian | Base généraliste, bonne compat. | OpenSSL 3.5 (24.04+/26.04) |
| 3 | **Debian** (+ `slim`) | *racine* | Base généraliste de référence | trixie → OpenSSL 3.5 |
| 4 | **BusyBox** | indépendante | Ultra-minimal (~2-5 Mo) | Pas de pile TLS par défaut → PQC via la couche applicative |
| 5 | **distroless** (Google) | Debian | Runtime minimal sans shell | Hérite des libs Debian / de la chaîne de build |
| 6 | **Red Hat UBI** (`ubi9`, `ubi-micro`) | RHEL | Base entreprise redistribuable | Suit RHEL (OpenSSL 3.5, `crypto-policies`) |
| 7 | **Amazon Linux** | dérivé Fedora | Base AWS | Sous-politique PQ (ML-KEM + ML-DSA) |
| 8 | **Wolfi / Chainguard** | indépendante (`apk`) | Supply chain, images *zéro-CVE* | PQC activée + **provider FIPS** OpenSSL 3.6 (~Q4 2026) |
| 9 | **Azure Linux** (distroless) | Fedora | Base Microsoft / AKS | Suit Fedora ; SymCrypt-OpenSSL |
| 10 | **Photon OS** (VMware) | indépendante | Conteneurs / edge VMware | OpenSSL ; à valider précisément |

**Constat** : le créneau conteneurs **converge vers les mêmes primitives** (OpenSSL 3.5),
mais y ajoute une exigence propre — la **chaîne d'approvisionnement** (signatures d'images,
SBOM). C'est là que **Chainguard/Wolfi** se distingue, en couplant PQC *et* signature
Sigstore/ML-DSA (voir §4). Tendance 2025-2026 : les **« hardened images »** (Docker
Hardened Images, basées Debian/Alpine ; Chainguard) deviennent gratuites et embarquent la
PQC par défaut.

---

## 4. Au-delà de TLS : signatures et chaîne d'approvisionnement

L'échange de clés (KEM) avance vite ; les **signatures** sont le second front, plus
lourd (les signatures ML-DSA pèsent des **kilo-octets** contre des dizaines/centaines
d'octets pour ECC/RSA — impact sur les paquets, certificats, métadonnées).

- **Paquets** : RHEL 10.1 signe des **RPM** en hybride ML-DSA-87 + Ed448 (aperçu). Côté
  Debian/`apt` et `dpkg`, la transition dépend d'OpenPGP PQC (GnuPG 2.5 / Sequoia).
- **Chaîne d'approvisionnement / images** : **Sigstore** a intégré **ML-DSA** (FIPS 204) ;
  **cosign** signe images et artefacts. C'est le pont entre « distributions » et
  « conteneurs ».

---

## 5. Synthèse — réponses aux questions du ticket

> **Est-ce que toutes les distributions ont intégré la modernisation crypto ?**

**Pour les primitives : oui, largement.** Comme toutes s'appuient sur OpenSSL 3.5 /
OpenSSH 10, **toute distribution récente dispose au minimum de l'échange de clés
post-quantique** (souvent par défaut côté SSH). La PQC « de base » est donc devenue un
acquis de l'écosystème en 2025-2026, pas une exclusivité.

**Pour la migration complète : non, c'est en cours partout.** Les écarts se jouent sur :
1. **par défaut vs optionnel** (SSH ✅ presque partout ; TLS ✅ chez les leaders) ;
2. **orchestration système** (`crypto-policies` chez Red Hat ; rien d'équivalent chez Debian) ;
3. **signatures et paquets** (à peine commencé : aperçus RPM, OpenPGP PQC en cours) ;
4. **validation FIPS** (en cours, ex. Chainguard ~Q4 2026).

> **Lesquelles sont les plus avancées ? Y en a-t-il qui se distinguent ?**

| Distribution | Maturité PQC | Ce qui la distingue |
|---|---|---|
| **RHEL / Fedora (Red Hat)** | ★★★★★ | Couverture la plus complète : KEM par défaut, `crypto-policies`, signatures RPM, SSH PQC par défaut (RHEL 10.2, FIPS inclus). Le plus **systématique**. |
| **Clones RHEL — Rocky / AlmaLinux / Oracle** | ★★★★☆ | **Héritent du code crypto de RHEL** (Rocky 10.2 : ML-KEM en FIPS, ML-DSA TLS, signatures composites). Bémol : pas de validation FIPS propre. |
| **SLES / openSUSE (SUSE)** | ★★★★☆ | SLES 16 « construit avec la PQC » ; hybride ML-KEM-768+X25519 jusque dans Leap/Tumbleweed ; stratégie publiée. |
| **Ubuntu (Canonical)** | ★★★★☆ | SSH PQC **par défaut** dans la **26.04 LTS** ; forte traction cloud/télécom. |
| **Linux des nuages — Amazon Linux / Azure Linux** | ★★★★☆ | Sous-politique PQ (AWS) ; Azure Linux 4.0 sur base Fedora (SymCrypt). La PQC poussée **par le cloud**. |
| **Debian** | ★★★☆☆ | Primitives présentes (trixie + OpenSSL 3.5), mais **pas d'orchestration** ni de défauts agressifs : prudence assumée. |
| **Arch / Tumbleweed (rolling)** | ★★★☆☆ | **Accès précoce** aux primitives, mais configuration manuelle, pas de politique d'entreprise. |
| **Dérivées poste (Mint, Pop!\_OS, Manjaro, Kali…)** | ★★★☆☆ | **Statut hérité** de l'amont (Debian/Ubuntu/Arch) — pas de feuille de route PQC propre. |
| **Chainguard / Wolfi (conteneurs)** | ★★★★☆ | Se distingue sur la **supply chain** : PQC + provider FIPS + signatures (Sigstore/ML-DSA). |

**À retenir pour la présentation** :
- **Red Hat est la référence** à citer pour montrer que « les éditeurs prennent le sujet
  au sérieux » (démarche complète et en production).
- **Le point rassurant** : la brique fondamentale (échange de clés PQC) est **déjà là, par
  défaut, dans ce que vous utilisez** — souvent sans même le savoir (SSH !).
- **Le point honnête** : la migration des **signatures** et des **paquets** ne fait que
  commencer ; c'est là que se situe le vrai chantier des prochaines années.

---

## 6. Pistes de démonstration (pour le créneau de 30 min)

- **TLS hybride** : `openssl s_client` (OpenSSL 3.5) négociant `X25519MLKEM768` vers un
  serveur compatible ; montrer le groupe négocié.
- **SSH post-quantique** : `ssh -Q kex` puis connexion en `mlkem768x25519-sha256` ; montrer
  qu'OpenSSH 10.1 **avertit** sinon.
- **Contraste de tailles** : comparer une signature ECDSA vs ML-DSA pour illustrer
  concrètement le « coût » des signatures PQC.

---

## 7. Sources

Standards & menace :
- NIST, *FIPS 203/204/205 finalisés* (août 2024) — https://www.nist.gov/news-events/news/2024/08/nist-releases-first-3-finalized-post-quantum-encryption-standards
- Federal Register, annonce officielle FIPS 203/204/205 — https://www.federalregister.gov/documents/2024/08/14/2024-17956/
- « Harvest now, decrypt later » — https://en.wikipedia.org/wiki/Harvest_now,_decrypt_later
- NSA CNSA 2.0 — https://www.entrust.com/resources/learn/what-is-cnsa-2-0
- Google Quantum AI, abaissement de l'estimation RSA-2048 — https://thequantuminsider.com/2025/05/24/google-researcher-lowers-quantum-bar-to-crack-rsa-encryption/

Briques :
- OpenSSL 3.5.0 (PQC natif) — https://www.helpnetsecurity.com/2025/04/09/openssl-3-5-0-released/
- OpenSSH : Post-Quantum Cryptography — https://www.openssh.org/pq.html
- OpenSSH 10.0 (défaut PQC) — https://www.phoronix.com/news/OpenSSH-10.0-Released
- GnuPG 2.5.19 (Kyber/ML-KEM) — https://lists.gnupg.org/pipermail/gnupg-announce/2026q2/000504.html
- OpenPGP PQC (IETF draft) — https://datatracker.ietf.org/doc/html/draft-ietf-openpgp-pqc-14

Distributions :
- RHEL 10 et la PQC — https://www.redhat.com/en/blog/post-quantum-cryptography-red-hat-enterprise-linux-10
- Nouveautés PQC dans RHEL 10.1 — https://www.redhat.com/en/blog/whats-new-post-quantum-cryptography-rhel-101
- RHEL 10.2 (Help Net Security, mai 2026) — https://www.helpnetsecurity.com/2026/05/07/red-hat-enterprise-linux-10-2-and-9-8/
- Signature de RPM en cryptographie quantique-résistante — https://developers.redhat.com/articles/2025/10/07/signing-rpm-packages-using-quantum-resistant-cryptography
- Fedora & crypto-policies (Red Hat Research) — https://research.redhat.com/blog/2024/07/05/fedora-linux-transition-for-quantum-resistant-cryptography/
- Fedora pq-container (QUBIP) — https://github.com/QUBIP/pq-container
- SLES 16 (heise) — https://www.heise.de/en/news/SLES-16-SUSE-s-Flagship-Linux-with-AI-and-Post-Quantum-Crypto-10981423.html
- SUSE, stratégie PQC fin 2025 — https://www.suse.com/c/suse-state-of-and-strategy-for-post-quantum-cryptography-at-the-end-of-2025/
- openSUSE Leap/Tumbleweed PQC hybride — https://9to5linux.com/opensuse-lands-post-quantum-hybrid-cryptography-in-leap-and-tumbleweed
- Debian trixie / OpenSSL 3.5 — https://packages.debian.org/stable/openssl
- Ubuntu 26.04, SSH PQC par défaut — https://discourse.ubuntu.com/t/post-quantum-support-in-the-upcoming-26-04-lts/76840
- Ubuntu, télécom quantum-safe — https://ubuntu.com/blog/building-quantum-safe-telecom-infrastructure-for-5g-and-beyond
- Rocky Linux 10.2 (PQC) — https://9to5linux.com/rocky-linux-10-2-released-with-post-quantum-cryptography-improvements
- Rocky vs AlmaLinux vs RHEL 10 — https://computingforgeeks.com/rocky-almalinux-rhel-comparison/
- Oracle Linux 9.7 (PQC) — https://alternativeto.net/news/2025/12/oracle-linux-9-7-released-with-post-quantum-cryptography-and-updated-toolchain
- Oracle, préparation à la PQC — https://blogs.oracle.com/security/post-quantum-cryptography
- Amazon Linux 2023, activer la PQC — https://docs.aws.amazon.com/linux/al2023/ug/crypto-policies-pq.html
- Azure Linux (Wikipedia / base Fedora v4.0) — https://en.wikipedia.org/wiki/Azure_Linux

Parts de marché / usage (méthodologie) :
- Parts de marché des distributions (2026) — https://fosspost.org/most-popular-linux-distros/
- Parts de marché serveurs Linux (2026) — https://fosspost.org/linux-server-market-share-statistics/

Conteneurs & supply chain :
- Chainguard Containers + PQC — https://www.chainguard.dev/unchained/chainguard-containers-enabled-with-pqc-support
- Wolfi (Chainguard) — https://www.chainguard.dev/unchained/reimagining-the-linux-distro-with-wolfi
- Docker Hardened Images (Debian/Alpine, gratuites) — https://www.infoq.com/news/2025/12/docker-hardened-images/
- Sigstore & PQC (2025) — https://blog.sigstore.dev/post-quantum-2025/
