# Tâche 4 : élargir l'analyse à dix images par catégorie

> **Objet / Résumé** : la tâche 4 corrige une lecture de la tâche 3 et porte l'analyse de dix images au total à **dix images par catégorie** (soit soixante images). Le livrable d'analyse élargi est l'essai de fondation [FND-011](../../fondations/FND-011-pqc-soixante-images-par-categorie.md). Cet artefact (a) explique pourquoi FND-009 n'analyse que dix images, (b) acte la décision d'élargissement et la sélection, (c) justifie le choix de numérotation FND-011.

## 1. Pourquoi FND-009 n'analyse que dix images

La tâche 3 du ticket demandait : « pour ces 6 catégories, sélectionner 10 images et faire un Essai de Fondation à propos de PQC analyser par catégorie ». Cette formulation a été lue comme **dix images au total**, réparties pour couvrir les six catégories, et non comme dix images **dans chacune** des six catégories. FND-009 a donc retenu dix images représentatives (RHEL, SLES, Ubuntu, Debian, AlmaLinux, Arch, Alpine, Android, OpenWrt, Wolfi) et les a analysées catégorie par catégorie, en traitant quelques candidates supplémentaires (Rocky, NixOS, Talos) en complément bref pour tenir la cible de dix.

La tâche 4 lève l'ambiguïté : l'intention était bien **dix par catégorie**, donc **soixante images** au total, afin d'opérer ensuite un choix à partir d'un échantillon plus large. FND-009 n'est pas erroné, il est **trop étroit** au regard de cette intention ; il reste valable comme analyse resserrée des dix images phares.

## 2. Décision d'élargissement

- On conserve **FND-009** tel quel (analyse des dix images phares, utile comme version courte).
- On produit un **nouvel essai élargi**, FND-011, qui couvre **dix images dans chacune des six catégories**.
- L'analyse PQC réutilise le cadre établi par FND-009 : la posture PQC d'une image se déduit surtout de ses **briques cryptographiques amont** (OpenSSL, OpenSSH, GnuTLS, NSS, BoringSSL, pile Go, mbedTLS, wolfSSL) et de son **modèle de publication** (rolling, fixe, dérivé). Cela permet de couvrir soixante images sans soixante enquêtes séparées, en signalant les déductions à confirmer (note de rigueur).

## 3. Numérotation : pourquoi FND-011 et non FND-010

Le ticket (tâche 4) écrit « adapter FND-010 pour avoir 10 images dans chaque catégorie ». Or, entre la rédaction du ticket et l'exécution de cette tâche, le numéro **FND-010 a été attribué** à l'essai sur le risque quantique (tâche 1 du ticket `TKT-008-risque-quantique`). Conformément à la règle de numérotation séquentielle par ordre de création (ADR-003 §D6, un numéro trace la genèse et ne se réattribue pas), l'essai d'images élargi prend donc le **numéro suivant disponible, FND-011**. La référence « FND-010 » du `ticket.md` est de ce fait obsolète ; elle n'est pas corrigée ici car l'agent ne modifie jamais un `ticket.md` (Constitution C1). Décision validée avec l'humain avant rédaction.

## 4. Sélection des soixante images (dix par catégorie)

| Catégorie | Dix images retenues |
|---|---|
| 1. Entreprises et HPC | RHEL, SLES, Ubuntu Server/Pro, Oracle Linux, Amazon Linux 2023, Rocky Linux, AlmaLinux, CentOS Stream, Azure Linux (CBL-Mariner), openSUSE Leap |
| 2. Communautaires et indépendantes | Debian, Fedora, openSUSE Tumbleweed, Arch Linux, Linux Mint, Manjaro, Gentoo, Void Linux, Slackware, Devuan |
| 3. Spécialisées images (conteneur) | Alpine, Wolfi, Chainguard Images, Google Distroless, Debian-slim, Ubuntu minimal, Red Hat UBI micro, BusyBox, Photon OS, image `scratch` (binaire statique) |
| 4. Mobile | Android (AOSP), GrapheneOS, LineageOS, /e/OS, CalyxOS, postmarketOS, Ubuntu Touch, Sailfish OS, Mobian, KaiOS |
| 5. IoT et embarqué | OpenWrt, Yocto/Poky, Buildroot, Raspberry Pi OS, Ubuntu Core, BalenaOS, Tizen, Automotive Grade Linux, Torizon, Wind River Linux |
| 6. Spécialités notables | NixOS, Talos Linux, Flatcar Container Linux, Bottlerocket, Fedora CoreOS, Qubes OS, Tails, Kali Linux, GNU Guix System, Fedora Silverblue/Atomic |

Critères de sélection : couvrir les meneurs et les suiveurs de chaque segment, varier les **piles cryptographiques** (glibc plus OpenSSL, musl plus OpenSSL, BoringSSL plus Go, mbedTLS et wolfSSL pour le contraint) et les **modèles de publication**, et inclure des dérivés qui héritent d'un amont connu (clones RHEL, dérivés Debian, dérivés Fedora, dérivés AOSP). Les chevauchements entre catégories (un clone RHEL est aussi communautaire ; un OS hôte de conteneurs est aussi une spécialité) sont assumés et chaque image est rangée dans sa catégorie de meilleur ajustement.

## 5. Suite

À partir de ces soixante images, une tâche ultérieure opérera la sélection finale des images à mettre en avant dans la présentation et, le cas échéant, à scanner réellement en CBOM (ticket 006).

## Definition of Done

- [x] Explication de pourquoi FND-009 n'analyse que dix images (lecture « dix au total » vs « dix par catégorie »).
- [x] Décision d'élargissement actée et cadre d'analyse réutilisé (briques amont plus modèle de publication).
- [x] Sélection des soixante images (dix par catégorie) arrêtée et justifiée.
- [x] Analyse PQC élargie produite dans [FND-011](../../fondations/FND-011-pqc-soixante-images-par-categorie.md).
- [x] Choix de numérotation FND-011 expliqué (collision FND-010, ADR-003 §D6, C1).
