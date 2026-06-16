# Tâche 3 : présélection de dix images et analyse PQC par catégorie

Cette tâche arrête une présélection de dix images couvrant les six catégories du ticket, puis produit l'analyse PQC par catégorie. Le livrable d'analyse est l'essai de fondation [FND-009](../../fondations/FND-009-pqc-par-categorie-dimages.md).

## Les dix images retenues

| Catégorie | Images retenues |
|---|---|
| 1. Entreprises et HPC | RHEL, SLES (SUSE), Ubuntu |
| 2. Communautaires et indépendantes | Debian, AlmaLinux, Arch Linux |
| 3. Spécialisées images (conteneur) | Alpine |
| 4. Mobile | Android |
| 5. IoT | OpenWrt |
| 6. Spécialités notables | Wolfi |

## Décisions et écarts par rapport à la liste du ticket

- Pour tenir la cible de dix images, certaines candidates listées au ticket sont traitées en complément bref dans FND-009 (section 10.2) plutôt qu'en détail : Rocky Linux (posture PQC quasi identique à AlmaLinux car les deux suivent RHEL), NixOS et Talos Linux.
- Catégorie 5 (IoT), laissée vide au ticket : j'ai proposé OpenWrt, cas concret et contraint où TLS et SSH comptent (alternatives possibles : Yocto, Raspberry Pi OS).
- Catégorie 1, autre candidat évoqué au ticket : Amazon Linux et Oracle Linux sont des options cloud et entreprise ; non retenues pour rester à dix, mais ajoutables.

## Pourquoi ces choix

- Représentativité stratégique (voir FND-008) : on couvre les segments dominants (entreprise, cloud, conteneur, mobile) et un cas IoT.
- Contraste PQC : on mélange un meneur (RHEL), des suiveurs rapides (SUSE, Arch, Wolfi), des suiveurs au rythme de leur stable (Ubuntu, Debian), un héritier (AlmaLinux), une image minimale (Alpine), une chaîne propre (Android) et un cas contraint (OpenWrt).
- Pertinence pour la démo CBOM (FND-006) : Alpine et Wolfi sont des cas types d'image de conteneur.

## Definition of Done

- [x] Dix images présélectionnées et justifiées, couvrant les six catégories.
- [x] Écarts par rapport à la liste du ticket explicités (candidats complémentaires, proposition IoT).
- [x] Analyse PQC par catégorie produite dans FND-009.
