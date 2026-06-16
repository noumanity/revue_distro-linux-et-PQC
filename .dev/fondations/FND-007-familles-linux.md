# Les grandes familles Linux : généalogie, gouvernance, modèles de publication et spécialités

> Statut : essai de fondation (tâche 1 du ticket 007). Complément de [FND-001](FND-001-recherche-preliminaire-pqc-distributions-linux.md), qui traitait les distributions sous l'angle de la cryptographie post-quantique ; le présent essai dresse le portrait des familles elles-mêmes (filiation, gouvernance, publication, usages).
> Date : 2026-06-15.
> Objectif : fournir un portrait exhaustif et digestible des grandes familles de distributions Linux, de leur généalogie, de leurs modèles de développement et de feuille de route, et de leurs spécialités. Ce socle prépare l'analyse de l'intégration du PQC distribution par distribution.
> Note de rigueur : chaque affirmation factuelle importante est rattachée à une source (section 17). La généalogie Linux est stable, mais la gouvernance bouge (crise des sources RHEL en 2023, openSUSE Leap 16 en 2025) ; les états sont datés de juin 2026 et à revalider.
> Périmètre : les familles, leur structure, leur gouvernance, leurs modèles de publication, et un focus sur les distributions de conteneurs et immuables (pertinentes pour la démo du projet). Hors périmètre : l'analyse détaillée du PQC par distribution (voir FND-001 et les tickets dédiés).

## 1. Avertissement méthodologique

Le sujet est vaste et les classifications se recoupent (une distribution appartient à une famille par filiation, mais peut adopter un modèle de publication partagé par d'autres familles). On sépare donc volontairement trois axes : la filiation, le modèle de gouvernance et le modèle de publication. L'essai est exhaustif sur l'axe des composants (ADR-003 §D7). Les chiffres de popularité sont indicatifs et évoluent.

## 2. Cadrage, périmètre et définitions

### 2.1 Définitions de travail

- Distribution : un assemblage cohérent du noyau Linux, d'un espace utilisateur (souvent GNU), d'un gestionnaire de paquets et d'outils, livré comme un système installable.
- Famille : un ensemble de distributions partageant une filiation commune (code, format de paquet, outils), généralement issues d'une distribution mère.
- Upstream et downstream : l'upstream est la source en amont (par exemple Fedora est en amont de RHEL) ; le downstream consomme et adapte (par exemple Ubuntu est en aval de Debian).
- Format de paquet : la technologie d'empaquetage et de gestion des dépendances (deb, rpm, etc.), bon marqueur de famille.
- Modèle de publication : la cadence et la nature des versions (fixe, rolling, stream, immuable).
- Modèle de gouvernance : qui décide (communauté, entreprise, fondation).

### 2.2 Thèse

Trois familles structurent l'écosystème par filiation : Debian, Red Hat et SUSE. Autour gravitent des indépendantes influentes (Arch, Gentoo, Slackware, Alpine, NixOS, Void). Mais la filiation ne suffit pas à comprendre une distribution : il faut croiser trois axes (filiation, gouvernance, publication), car ce sont la gouvernance et la feuille de route qui déterminent la vitesse et la fiabilité d'adoption d'une nouveauté comme le PQC.

## 3. Historique et généalogie

Les premières distributions apparaissent en 1992 et 1993 (par exemple SLS, puis Slackware). Slackware, créée par Patrick Volkerding en 1993, est la plus ancienne distribution encore active, et plusieurs distributions en descendent, dont les premières versions de SUSE [1][2]. Debian naît aussi en 1993 (Ian Murdock), avec une visée communautaire forte. Red Hat Linux et SUSE apparaissent vers 1994. Suivent Gentoo et Arch Linux autour de 2000 à 2002, puis Ubuntu en 2004 (sur base Debian). La décennie 2010 voit l'essor des distributions pensées pour les conteneurs (CoreOS, Alpine popularisée par Docker) et des distributions immuables. Les bouleversements récents tiennent surtout à la gouvernance : pivot de CentOS vers CentOS Stream (2020 et 2021), restriction des sources RHEL (2023), et refonte de la gamme SUSE et openSUSE (Leap 16 en 2025) [3][4].

## 4. Critères de classification

On classe une distribution selon quatre axes complémentaires.

- Filiation et format de paquet : Debian et dérivés (deb, apt) ; Red Hat et dérivés (rpm, dnf) ; SUSE (rpm, zypper) ; Arch (pacman) ; Gentoo (Portage, source) ; Alpine (apk) ; NixOS (nix) ; Void (xbps).
- Modèle de publication : fixe ou par points, rolling, stream, semi-rolling, immuable ou atomique.
- Modèle de gouvernance : communautaire, soutenu par une entreprise avec communauté, purement entreprise, ou gouverné par une fondation.
- Cible d'usage : bureau, serveur, entreprise, conteneur, embarqué, sécurité, scientifique.

## 5. Panorama des familles

### 5.1 Famille Debian

- Debian : distribution communautaire de référence, gouvernée par le Projet Debian (contrat social, principes du logiciel libre selon Debian, chef de projet élu). Trois branches : stable (publication par points, environ tous les deux ans), testing, et unstable (nom de code sid). Réputée pour sa rigueur et son immense dépôt. Format deb, outils apt et dpkg.
- Ubuntu : éditée par Canonical, en aval de Debian. Publications tous les six mois, version LTS tous les deux ans (avril des années paires) avec support long (cinq ans, jusqu'à dix avec les offres étendues). Socle d'innombrables dérivés.
- Dérivés notables : Linux Mint, Pop!_OS, elementary OS, Zorin OS, KDE neon (sur Ubuntu) ; Kali Linux et Parrot OS (sécurité, sur Debian) ; Raspberry Pi OS, Proxmox VE, Tails (sur Debian).

### 5.2 Famille Red Hat

- Fedora : distribution communautaire soutenue par Red Hat, en amont de RHEL ; innovante, publications tous les six mois environ. Décline des éditions Workstation, Server, IoT, et des variantes atomiques (Silverblue, Kinoite, voir section 8).
- RHEL (Red Hat Enterprise Linux) : produit entreprise de Red Hat (IBM), payant, support long (dix ans), cible serveur et entreprise. Format rpm, outils dnf.
- CentOS Stream : depuis le pivot de 2020 et 2021, CentOS n'est plus un clone aval de RHEL mais une préversion continue de la prochaine version mineure de RHEL ; c'est désormais le dépôt source public de référence pour RHEL [3][4].
- Clones et compatibles : après la restriction des sources RHEL en 2023 (section 10), Rocky Linux vise la compatibilité bug pour bug par des moyens d'acquisition de sources détournés, tandis qu'AlmaLinux est passée à une compatibilité ABI (compatible binaire, sans viser le bug pour bug) en se construisant sur CentOS Stream [3][4][5]. Oracle Linux et Amazon Linux complètent la famille côté fournisseurs cloud.

### 5.3 Famille SUSE

- SLES (SUSE Linux Enterprise Server) : produit entreprise de SUSE, support long, cible serveur et entreprise (très présent dans SAP). Format rpm, outils zypper et YaST.
- openSUSE Leap : version communautaire alignée sur le source et le binaire de SLES, migratable vers SLES. Leap 16 est sortie le 1er octobre 2025, avec un nouveau cycle de vie (publications mineures annuelles attendues jusque vers 2031) et l'installateur Agama [6].
- openSUSE Tumbleweed : rolling release testée par l'outil openQA. Slowroll est une variante semi-rolling, entre Leap et Tumbleweed [6].

### 5.4 Arch Linux

Distribution indépendante, rolling release, philosophie minimaliste et orientée utilisateur avancé (faire soi-même). Gestionnaire pacman, dépôt communautaire AUR. Dérivés grand public : Manjaro, EndeavourOS, Garuda, CachyOS. SteamOS récent (Valve) s'appuie sur Arch.

### 5.5 Gentoo

Distribution source : les paquets sont compilés localement via Portage (commande emerge), avec des drapeaux USE pour activer ou désactiver des fonctionnalités. Rolling, hautement personnalisable, exigeante. Influente sur ChromeOS (qui a des racines Gentoo) et Flatcar et CoreOS (héritage Gentoo).

### 5.6 Slackware

La plus ancienne distribution active (1993). Gestion de paquets minimaliste (archives tgz et txz, sans résolution automatique des dépendances), philosophie de simplicité à la BSD et grande stabilité, public expert et conservateur [1][2].

### 5.7 Indépendantes notables

- Alpine Linux : très légère, fondée sur la bibliothèque C musl et BusyBox plutôt que sur la glibc et GNU coreutils, orientée sécurité et taille minimale. Devenue ubiquitaire comme image de base de conteneurs (section 8). Gestionnaire apk.
- Void Linux : indépendante, système d'init runit, gestionnaire xbps, disponible en musl ou glibc, rolling.
- NixOS : distribution déclarative et reproductible bâtie sur le gestionnaire Nix ; configuration du système entière décrite dans des fichiers, mises à jour atomiques et retours arrière (section 8).
- Autres : Solus, Clear Linux (Intel, optimisations performance), Mageia et OpenMandriva (héritage Mandrake et Mandriva), PCLinuxOS.

### 5.8 Android et l'embarqué

Android, fondé sur le noyau Linux mais avec un espace utilisateur non GNU, est de loin le système Linux le plus déployé au monde. L'embarqué s'appuie souvent sur des constructeurs comme Yocto Project et Buildroot, qui produisent des distributions sur mesure. On les mentionne pour la complétude, même s'ils sortent du cadre des distributions GNU/Linux classiques.

## 6. Taxonomie transverse : les modèles de publication

- Fixe ou par points : versions figées publiées à intervalles, corrigées ensuite (Debian stable, RHEL, Ubuntu, SLES, openSUSE Leap). Prévisible, adapté à l'entreprise.
- Rolling : flux continu de mises à jour, pas de version figée (Arch, Gentoo, openSUSE Tumbleweed, Void). Fraîcheur maximale, surface de changement permanente.
- Stream : préversion continue d'une future version d'entreprise (CentOS Stream pour RHEL). Hybride entre rolling et fixe [3].
- Semi-rolling : compromis avec des mises à jour testées plus fréquentes que le fixe mais plus prudentes que le rolling (openSUSE Slowroll) [6].
- Immuable ou atomique : système en lecture seule mis à jour par images atomiques avec retour arrière (section 8).

## 7. Taxonomie transverse : les modèles de gouvernance

- Communautaire : gouverné par une communauté et ses processus (Debian, Arch, Gentoo, Slackware, openSUSE côté communauté). Indépendance, parfois lenteur de décision.
- Soutenu par une entreprise avec communauté : une entreprise finance et oriente, une communauté contribue (Fedora avec Red Hat, openSUSE avec SUSE, Ubuntu avec Canonical).
- Entreprise : produit contrôlé par un éditeur, support contractuel (RHEL, SLES, Bottlerocket d'AWS).
- Fondation : gouvernance par une fondation à but non lucratif garantissant qu'aucune entreprise unique ne contrôle la feuille de route (AlmaLinux OS Foundation, Rocky Enterprise Software Foundation, Flatcar sous la CNCF) [5].

## 8. Distributions spécialisées conteneurs et immuables

Cette catégorie est essentielle pour le projet (la démo vise des images de conteneur). Traits communs : racine immuable ou quasi immuable, mises à jour atomiques avec retour arrière, conception orientée conteneur, empreinte minimale donc moins de CVE [7][8].

- Alpine Linux : image de base de conteneurs la plus répandue, grâce à sa taille minime (musl et BusyBox). Attention, musl peut poser des écarts de compatibilité avec des logiciels prévus pour la glibc.
- Distroless (Google) : non pas une distribution mais des images de base minimales sans gestionnaire de paquets ni shell, pour ne contenir que l'application et ses dépendances.
- Wolfi (Chainguard) : une undistro pensée pour la chaîne d'approvisionnement et des images minimales avec SBOM, orientée sécurité.
- Flatcar Container Linux : immuable, issue du fork de CoreOS Container Linux après le rachat de CoreOS par Red Hat en 2018, aujourd'hui projet de la CNCF, donc neutre vis-à-vis des fournisseurs [7].
- AWS Bottlerocket : système hôte minimal d'AWS, livré en images machine intégrées à EKS et ECS [7].
- Talos Linux : système minimal géré entièrement par API (sans shell ni accès interactif), dédié à Kubernetes [7].
- Fedora CoreOS : issue de la fusion de CoreOS et de Fedora Atomic Host, immuable et orientée conteneur [7].
- Variantes immuables de bureau et serveur : Fedora Silverblue et Kinoite (rpm-ostree), openSUSE MicroOS, Aeon et Kalpa, NixOS, Vanilla OS. Elles appliquent l'atomicité au poste de travail.

## 9. Comment fonctionnent le développement et la feuille de route

- Le principe upstream-first : la plupart des distributions intègrent les changements faits en amont (noyau, bibliothèques, projets comme OpenSSL et GnuTLS) plutôt que de les inventer. La vitesse d'adoption d'une nouveauté (par exemple un algorithme PQC) dépend donc d'abord de l'upstream, puis du cycle de la distribution.
- Le pipeline d'entreprise : Fedora sert de laboratoire en amont de RHEL ; openSUSE Leap partage son socle avec SLES. Les nouveautés mûrissent dans la version communautaire avant d'atteindre l'entreprise.
- Les processus de gel et de publication : Debian applique des gels successifs (freeze) avant une stable ; le rolling (Tumbleweed) s'appuie sur des tests automatisés continus (openQA) ; le stream (CentOS Stream) sert de fenêtre sur la prochaine RHEL.
- La feuille de route : chez les communautaires, elle émerge de processus ouverts (propositions, votes) ; chez les éditeurs, elle est pilotée par les besoins clients et les engagements de support à long terme.

## 10. Étude de cas de gouvernance : la crise des sources RHEL (2023)

Le 21 juin 2023, Red Hat a cessé de publier les sources de RHEL sur git.centos.org et a fait de CentOS Stream le seul dépôt public de sources liées à RHEL, les sources complètes de RHEL n'étant plus accessibles qu'aux abonnés [3][4]. Conséquences : les clones bug pour bug (Rocky, AlmaLinux, Oracle) ont dû s'adapter. AlmaLinux a choisi la compatibilité ABI en se construisant sur CentOS Stream et des sources amont (à partir de la 9.3) ; Rocky a maintenu la compatibilité bug pour bug par des moyens d'acquisition détournés [3][4][5]. Cet épisode illustre trois choses utiles au projet : la gouvernance et la licence pèsent autant que la technique ; les fondations (AlmaLinux, Rocky) servent de garde-fou ; et la frontière entre clone exact et compatible binaire a un impact concret sur ce que l'on peut affirmer d'une distribution.

## 11. Analyse critique et tensions

- Communauté contre entreprise : les distributions d'entreprise offrent support et stabilité au prix du contrôle et du coût ; les communautaires offrent indépendance au prix d'une soutenabilité parfois fragile.
- Compatibilité et fragmentation : la richesse des familles est une force (choix) et une faiblesse (fragmentation des formats, des cycles, des outils), ce qui complique un sujet transverse comme l'inventaire cryptographique.
- musl contre glibc : le choix d'Alpine optimise la taille mais introduit des écarts de compatibilité à connaître.
- Soutenabilité : beaucoup de petites distributions reposent sur quelques mainteneurs ; la pérennité est un risque réel.
- Rolling contre fixe pour la sécurité : le rolling apporte vite les correctifs mais expose à des régressions ; le fixe est prévisible mais peut retarder l'arrivée d'une nouveauté.

## 12. Tableau de synthèse

| Famille ou distribution | Base ou filiation | Paquet et outil | Publication | Gouvernance | Usage typique |
|---|---|---|---|---|---|
| Debian | indépendante (mère) | deb, apt | fixe par points | communautaire | serveur, polyvalent |
| Ubuntu | Debian | deb, apt | fixe, LTS bisannuelle | entreprise avec communauté | bureau, serveur, cloud |
| Fedora | indépendante (amont RHEL) | rpm, dnf | fixe, six mois | communautaire avec Red Hat | innovation, bureau |
| RHEL | Fedora | rpm, dnf | fixe, support long | entreprise | entreprise, serveur |
| CentOS Stream | RHEL (amont) | rpm, dnf | stream | entreprise avec communauté | préversion de RHEL |
| Rocky, AlmaLinux | RHEL (compatibles) | rpm, dnf | fixe, support long | fondation | serveur, remplaçant de CentOS |
| openSUSE Leap | SLES | rpm, zypper | fixe, annuelle | communautaire avec SUSE | serveur, bureau |
| openSUSE Tumbleweed | indépendante SUSE | rpm, zypper | rolling | communautaire avec SUSE | poste à jour, développeurs |
| SLES | SUSE | rpm, zypper | fixe, support long | entreprise | entreprise, SAP |
| Arch | indépendante | pacman, AUR | rolling | communautaire | utilisateurs avancés |
| Gentoo | indépendante | Portage, source | rolling | communautaire | personnalisation, expert |
| Slackware | indépendante (mère) | tgz, manuel | fixe, lent | communautaire (un mainteneur) | expert, conservateur |
| Alpine | indépendante (musl) | apk | rolling et stable | communautaire | conteneurs, embarqué |
| NixOS | indépendante | nix | rolling et fixe | communautaire | reproductibilité, atomique |
| Flatcar, Bottlerocket, Talos, Fedora CoreOS | héritages divers | images atomiques | immuable | CNCF, AWS, entreprise, communauté | hôtes de conteneurs |

## 13. Pertinence pour la suite (vers le PQC)

Trois enseignements pour l'analyse de l'intégration du PQC, à approfondir avec FND-001 et les tickets dédiés.

- L'axe upstream-first explique pourquoi la vitesse d'adoption du PQC dépend d'abord des bibliothèques en amont (OpenSSL, GnuTLS, OpenSSH, le noyau), puis du modèle de publication de la distribution.
- Le modèle de publication conditionne le délai : une rolling (Arch, Tumbleweed) reçoit le PQC plus tôt qu'une fixe à support long (RHEL, SLES, Debian stable), qui le reçoit plus tard mais de façon plus stable.
- Les distributions de conteneurs et minimales (Alpine, distroless, Wolfi) ont une surface cryptographique réduite et spécifique, ce qui change la manière de produire et de lire un CBOM (voir FND-006 et le ticket 006).

## 14. Lexique

- Distribution : assemblage installable de noyau, espace utilisateur, paquets et outils.
- Famille : ensemble de distributions de filiation commune.
- Upstream et downstream : amont et aval dans la chaîne de dépendance.
- Rolling release : publication continue sans version figée.
- Stream : préversion continue d'une future version d'entreprise.
- Distribution immuable ou atomique : système en lecture seule mis à jour par images, avec retour arrière.
- musl et glibc : deux implémentations de la bibliothèque C standard.
- LTS : support à long terme (Long Term Support).
- Compatibilité ABI : compatibilité binaire, sans viser l'identité bug pour bug.

## 15. Synthèse

L'écosystème Linux s'organise autour de trois familles par filiation (Debian, Red Hat, SUSE) et d'un cercle d'indépendantes influentes (Arch, Gentoo, Slackware, Alpine, NixOS, Void). Mais comprendre une distribution exige de croiser trois axes : la filiation et le format de paquet, le modèle de gouvernance (communautaire, entreprise, fondation) et le modèle de publication (fixe, rolling, stream, immuable). La catégorie des distributions de conteneurs et immuables (Alpine, distroless, Wolfi, Flatcar, Bottlerocket, Talos, Fedora CoreOS) est centrale pour ce projet. La crise des sources RHEL de 2023 rappelle que gouvernance et licence pèsent autant que la technique. Pour la suite, c'est la combinaison upstream-first plus modèle de publication qui déterminera la vitesse et la fiabilité d'adoption du PQC par chaque distribution.

## 16. Limites

Le panorama est représentatif, non exhaustif au sens absolu : il existe des centaines de distributions. Les modèles de publication et de gouvernance sont des idéaux types ; des cas hybrides existent. Les états récents (openSUSE Leap 16, suites de la crise RHEL) sont datés de juin 2026 et à revalider. L'angle PQC n'est qu'esquissé ici ; il relève de FND-001 et des tickets dédiés.

## 17. Sources

1. Slackware et l'histoire des distributions (la plus ancienne active, 1993 ; SUSE en descend), Wikipedia, article Slackware. https://en.wikipedia.org/wiki/Slackware
2. Famille et généalogie des distributions Linux (arbre des distributions), Wikipedia, article Linux distribution. https://en.wikipedia.org/wiki/Linux_distribution
3. Phoronix, Red Hat Now Limiting RHEL Sources To CentOS Stream (2023). https://www.phoronix.com/news/Red-Hat-CentOS-Stream-Sources
4. OpenLogic, RHEL Source Code Restriction, What It Means for Rocky Linux and AlmaLinux. https://www.openlogic.com/blog/rhel-source-code-access-changes
5. AlmaLinux 9.3, première version construite entièrement à partir des sources amont (CentOS Stream), communiqué. https://www.businesswire.com/news/home/20231113587124/en/AlmaLinux-Releases-9.3-and-Announces-AlmaLinux-Day-Tokyo
6. openSUSE News, Next Chapter Opens with Leap 16 Release (1er octobre 2025 ; cycle de vie, Tumbleweed, Slowroll, lien avec SLES). https://news.opensuse.org/2025/10/01/next-chapter-opens-with-leap-release/
7. Comparatif des distributions optimisées conteneurs (Flatcar, Bottlerocket, Talos, Fedora CoreOS). https://dev.to/matheus_releaserun/container-optimized-linux-distributions-compared-flatcar-bottlerocket-talos-and-fedora-coreos-4fj2
8. Justin Garrison, The State of Immutable Linux (traits des systèmes immuables). https://justingarrison.com/blog/state-of-immutable-linux/

> À revalider à l'approche de la présentation : suites de la crise RHEL, cycle de vie d'openSUSE Leap 16, état des projets de conteneurs (CNCF, AWS). Cet essai prépare l'analyse PQC par distribution (FND-001 et tickets dédiés).
