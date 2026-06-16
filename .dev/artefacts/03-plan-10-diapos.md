# Plan de présentation en dix diapos

> **Livrable 3/4 de la tâche 1 du ticket [TKT-001-plan](../tickets/TKT-001-plan/ticket.md).** Convergence de la structure longue du ticket en **dix diapos maximum**. Chaque diapo porte un **objectif**, un **message clé**, et sert l'audience (communauté Linux en surface, décideurs en filigrane). Le récit sous-jacent est le livrable 2 ([argumentaire](02-argumentaire-recit.md)) ; le verbatim est le livrable 4.

## Vue d'ensemble

| # | Titre | Message clé | Sert surtout |
|---|---|---|---|
| 1 | L'accroche : fausse conf quantique | « Rien de quantique ici » | Communauté (complicité) |
| 2 | Le vrai plan, volontairement ordinaire | C'est de la cybersécurité normale | Les deux |
| 3 | La menace, sans drame | Cassé (Shor) vs affaibli (Grover) ; déjà vu | Communauté |
| 4 | Pourquoi c'est quand même sérieux | HNDL plus durée de vie plus Mosca | Décideurs |
| 5 | Des enjeux déjà pris en charge | Standards plus crypto-agilité | Décideurs |
| 6 | Le leadership canadien | Triangle QC-Sherbrooke-MTL, Mosca | Les deux |
| 7 | Linux : où vit la crypto | OpenSSL, GnuTLS, OpenSSH, noyau | Communauté |
| 8 | Roadmap PQC des distros | L'amont mène, RHEL en tête | Communauté |
| 9 | Démo : inventaire et CBOM | On ne migre pas ce qu'on ignore | Les deux |
| 10 | Conclusion et appel | Migration maîtrisable ; parlons-nous | Décideurs |

## Détail des diapos

### Diapo 1 : l'accroche (fausse conf quantique)

- **Objectif** : désamorcer l'intimidation, créer la complicité, planter la thèse.
- **Contenu** : un faux plan intimidant (théorème de Shor, implémentation Qiskit, exécution sur l'ordinateur quantique IBM de Bromont), affiché comme si la présentation portait sur la physique quantique.
- **Effet de scène** : on laisse monter le malaise, puis chute. Variation possible : les items du faux plan se barrent un à un.

### Diapo 2 : le vrai plan, volontairement ordinaire

- **Objectif** : énoncer la thèse et le fil conducteur.
- **Message** : « On utilise le mot quantique, mais il n'y a rien de quantique ici. C'est une présentation de cybersécurité ordinaire. »
- **Contenu** : le vrai plan, plat à dessein : menaces, risques, composants impactés, mitigation, roadmap PQC de distros Linux, CBOM et scanners.

### Diapo 3 : la menace, sans drame

- **Objectif** : démystifier la menace.
- **Message** : remplacer un algorithme cassé est le quotidien de la cybersécurité.
- **Contenu** : Shor casse l'asymétrique (RSA, ECC) ; Grover affaiblit seulement le symétrique (AES, hachage), parade en doublant les clés. Précédents : MD5, SHA-1, DES, RC4. Nuance : le classique progresse aussi (réseaux tensoriels rivalisant avec une revendication de suprématie). Source : [FND-010](../fondations/FND-010-risque-quantique-notion-et-prise-en-charge.md), [FND-001](../fondations/FND-001-recherche-preliminaire-pqc-distributions-linux.md).

### Diapo 4 : pourquoi c'est quand même sérieux

- **Objectif** : installer l'urgence juste (sans catastrophisme).
- **Message** : le risque est présent aujourd'hui à cause du HNDL et de la durée de vie des données.
- **Contenu** : incertitude du Q-Day (28 à 49 pour cent d'ici dix ans) mais worst case majeur ; HNDL ; inégalité de Mosca (durée de vie plus migration vs Q-Day). Cadrage : on se limite aux outils de cryptographie. Source : FND-010.

### Diapo 5 : des enjeux déjà bien pris en charge

- **Objectif** : rassurer (le chantier est cadré).
- **Message** : standards publiés plus vocabulaire et pratiques établis.
- **Contenu** : NIST FIPS 203 (ML-KEM), 204 (ML-DSA), 205 (SLH-DSA), 2024 ; équivalents BSI, ANSSI, ETSI ; concepts clés Q-Day et crypto-agilité. Source : FND-010, FND-001.

### Diapo 6 : le leadership canadien

- **Objectif** : fierté locale et signal de sérieux.
- **Message** : le Canada (et le Québec) est un leader du quantique ; le cadre de risque vient d'ici.
- **Contenu** : triangle Québec - Sherbrooke - Montréal ; Institut quantique et zone Distriq à Sherbrooke ; IBM Quantum à Bromont ; Stratégie quantique nationale (volet communication quantique et PQC) ; Mosca à Waterloo.

### Diapo 7 : Linux, où vit la crypto et à quoi elle sert

- **Objectif** : ancrer dans le concret technique de l'audience directe.
- **Message** : la crypto est partout dans une distro, dans quelques composants clés.
- **Contenu** : OpenSSL, GnuTLS, OpenSSH, le noyau ; à quoi ils servent (TLS, SSH, signatures de paquets). Méthodologie de sélection des OS (cf. [FND-009](../fondations/FND-009-pqc-par-categorie-dimages.md), [FND-011](../fondations/FND-011-pqc-soixante-images-par-categorie.md)).

### Diapo 8 : la roadmap PQC des distributions

- **Objectif** : démontrer la maîtrise du paysage réel.
- **Message** : le PQC descend de l'amont vers les distros ; RHEL mène.
- **Contenu** : OpenSSL 3.5 et OpenSSH 10 (2025) comme moteurs ; RHEL signe ses paquets en PQC (premier) ; rolling en avance ; Ubuntu et Debian au rythme des stables. Source : FND-009, FND-011.

### Diapo 9 : démo, inventaire cryptographique et CBOM

- **Objectif** : rendre l'action tangible.
- **Message** : on ne migre pas ce qu'on ne connaît pas ; commencez par l'inventaire.
- **Contenu** : démonstration d'un scan CBOM sur une ou deux images contrastées (par exemple RHEL riche vs Alpine minimal) ; notion de crypto-agilité comme capacité cible. Source : [FND-006](../fondations/FND-006-outils-cbom-scan-panorama-comparaison.md), FND-011.

### Diapo 10 : conclusion et appel

- **Objectif** : convertir la crédibilité en contact.
- **Message** : le PQC est une migration d'ingénierie maîtrisable ; la capacité à bâtir est la crypto-agilité.
- **Contenu** : récapitulatif en une phrase (démystifier, responsabiliser, rassurer) ; appel à l'action : « nous sommes les experts du PQC au Québec, contactez-nous ».

## Notes de convergence (ce qui a été fusionné ou coupé)

- La longue section « Section Intro » du ticket (accroche plus faux plan plus variations) tient en **deux diapos** (1 et 2).
- Les sous-sections « Menace cryptographique », « Pourquoi c'est sérieux », « Des enjeux bien pris en charge », « Concepts clés » deviennent les diapos 3 à 5 (la diapo 5 fusionne normalisation et concepts clés).
- « Position canadienne » tient en **une diapo** (6).
- La « Section Linux OS » (objectif et méthodologie, où est la crypto, composants) tient en **deux diapos** (7 et 8).
- La démo devient une diapo (9). La conclusion et l'appel forment la diapo 10.
- **Coupés du plan principal** (restent en réserve dans les fondations) : démonstration de Shor, détail des algorithmes, panorama des soixante images, classification des données, cryptographie quantique (QKD).
