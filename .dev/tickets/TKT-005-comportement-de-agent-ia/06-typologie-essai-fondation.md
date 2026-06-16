# Tâche 6 — Typologie des composants d'un essai de fondation (FND)

> **Objet** : les mêmes sections reviennent d'un essai de fondation à l'autre. On **analyse le
> corpus existant** (ce projet + autres repos), on **dégage une typologie** des parties, et on
> la **documente dans ADR-003** (§D7) pour cesser de redécrire la structure à chaque demande.

## 1. Corpus analysé (10 essais)

`$HOME/git/**/fondation(s)/*.md` :

- **Ce projet** (`.dev/fondations/`) : `FND-001-recherche-preliminaire-pqc…`,
  `FND-002-pratiques-design-web…quantomic`, `FND-003-mathematique-du-web`.
- **`noumanity-dev-talents/jvtrudel-cv/fondations/`** : `recherche-phase-a-metriques`,
  `revue-litterature-conception-cv-cible`, `revue-litterature-postes-senior-ti-leadership`,
  `revue-litterature-profil-candidat-atypique`, `securite-applicative-essai`,
  `securite-applicative-outils`, `yaml-arbre-graphe-et-cue-dissertation`.

> ⚠️ `FND-003-mathematique-du-web` est un **dump brut** de conversation (aucun titre H2, pas de
> cadre) : **non conforme**. Il illustre justement le besoin — la typologie sert de gabarit
> pour amener ce type de note au standard. Il est **exclu** des fréquences ci-dessous (9 essais
> structurés).

## 2. Constat : un **cadre stable** + un **corps variable**

L'analyse des titres fait apparaître **deux familles** de composants.

### 2.1 Composants de **cadre** (quasi universels — l'ossature)

| Composant | Présence (/9) | Rôle |
|---|---|---|
| **En-tête de genre** (titre « — recherche / revue / essai / dissertation » + statut, date, objectif) | 9/9 | Annonce le type et le périmètre. |
| **Avertissement méthodologique** (qualité des sources, rigueur) | 9/9 | Pose le niveau de fiabilité ; *« note de rigueur »* dans les FND. |
| **Cadrage / Thèse** (question, périmètre, définitions) | 9/9 | Délimite le sujet, définit les termes, énonce la thèse. |
| **Synthèse** (ce qu'il faut retenir) | 8/9 | Condense les conclusions. |
| **Limites** (et péremption / « à revalider ») | 9/9 | Dit ce que l'essai **ne** couvre pas et sa durée de validité. |
| **Bibliographie / Sources** | 9/9 | **Obligatoire** : chaque fait important est sourcé. |

→ Ce cadre est **toujours le même** : c'est précisément ce qu'on n'a plus à redécrire.

### 2.2 Composants de **corps** (un « menu » choisi selon le sujet)

| Composant | Exemples dans le corpus |
|---|---|
| **Historique / évolution** | FND-002 §2 (cascade→tokens) |
| **Revue de littérature / état de l'art** | les 3 `revue-litterature-*` (cv) |
| **Panorama / cartographie / inventaire (taxonomie)** | FND-001 §3 (distros), `securite-outils` (familles), `metriques` (cartographie) |
| **Analyse critique / réserves** | FND-002 §7 (Atomic Design), `yaml` §6 (réserves) |
| **Outils & instrumentation** | FND-002 §5, `securite` §5, `securite-outils` (tout) |
| **Tendances actuelles** | FND-002 §6 |
| **Comparaison / synthèse comparative** | `yaml` §9 |
| **Application au projet / réponses aux questions du ticket / recommandations** | FND-001 §5, FND-002 §9, `yaml` §10, `securite` §9 |
| **Lexique / glossaire** | `securite` §8 |

→ Le corps **varie** : on **compose** l'essai en piochant les composants pertinents.

## 3. Typologie proposée (le gabarit FND)

```
[CADRE — toujours présent]
  1. En-tête de genre (titre + statut/date/objectif)
  2. Avertissement méthodologique (rigueur, qualité des sources)
  3. Cadrage / Thèse (question, périmètre, définitions)
  …                                  ← 4. CORPS (composé depuis le menu §2.2)
  n-2. Synthèse
  n-1. Limites (+ péremption / à revalider)
  n.   Bibliographie / Sources        (obligatoire)

[CORPS — menu, à choisir/ordonner selon le sujet]
  • Historique • Revue de littérature • Panorama/taxonomie • Analyse critique
  • Outils & instrumentation • Tendances actuelles • Comparaison
  • Application/réponses au ticket/recommandations • (Lexique)
```

**Lecture** : le **cadre** (3 sections d'ouverture + 3 de clôture) est **invariant** ; seul le
**corps** se compose. Cela répond au constat de la tâche : on ne décrit plus que **ce qui est
propre au sujet**.

## 4. Documentation produite

- **ADR-003 §D7** : typologie (cadre + menu) en vue d'ensemble.
- **Skill [`skl-003-essai-de-fondations`](../../skills/skl-003-essai-de-fondations/SKILL.md)** :
  section « structure » enrichie avec le gabarit détaillé (cohérent avec D5 : *succinct dans
  l'ADR, détaillé dans le skill*).

## Definition of Done

- [x] Corpus de fondations analysé (ce projet + `jvtrudel-cv`).
- [x] Composants typiques identifiés (cadre quasi universel + menu de corps).
- [x] Typologie documentée dans ADR-003 (§D7) et détaillée dans le skill FND.
