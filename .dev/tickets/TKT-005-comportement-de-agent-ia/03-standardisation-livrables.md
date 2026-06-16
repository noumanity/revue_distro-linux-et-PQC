# Tâche 3 — Standardiser les livrables

> **Objet** : l'agent produit plusieurs **types de livrables** (ADR, essais de fondations, …),
> chacun avec ses *inputs/primitives*, son *processus de travail*, ses *critères de qualité/
> métriques* et sa *structure*. On (1) **liste et caractérise** ces livrables, (2) ajoute une
> **vue d'ensemble dans ADR-003**, (3) crée un **skill par livrable** dans `.dev/skills/`, et
> (4) pose le principe **« identifier le livrable d'abord »**.

## 1. Livrables identifiés dans le projet

| Livrable | Où il apparaît déjà | Skill créé |
|---|---|---|
| **Artefact de travail de tâche** | tous les `tickets/…/<XY>-<SLUG>.md` | [`artefact-de-travail`](../../skills/skl-001-artefact-de-travail/SKILL.md) |
| **ADR** | `ADR-001`, `ADR-002`, `ADR-003` | [`adr`](../../skills/skl-002-adr/SKILL.md) |
| **Essai de fondations** | `FND-001-recherche-preliminaire-pqc-distributions-linux.md` | [`essai-de-fondations`](../../skills/skl-003-essai-de-fondations/SKILL.md) |

> *Type émergent non encore « skillé »* : le **guide d'usage** (cf. ticket 004,
> `04-guide-usage-branding.md`). Le catalogue d'ADR-003 §D5 est **extensible** : on l'ajoutera
> avec son skill quand il se confirmera comme récurrent.

## 2. Caractérisation (les 4 axes)

La caractérisation **détaillée** vit dans chaque `SKILL.md` (source de vérité). Synthèse :

| Axe | Artefact de travail | ADR | Essai de fondations |
|---|---|---|---|
| **Inputs / primitives** | énoncé de tâche + DoD, prompts, artefacts/ADR antérieurs, code | artefacts ayant mené à la décision, contraintes/principes, options | question + périmètre, sources primaires, exigences de rigueur |
| **Processus** | identifier livrable → contexte → exécuter → documenter → lier → journaliser | identifier la décision → options → trancher+justifier → conséquences → statut | cadrer → recherche exhaustive → synthèse → sourcer → dater |
| **Qualité / métriques** | répond à la DoD, auto-portant, traçable, liens valides, nommage `<XY>-` | 1 décision datée, contexte+options+justif, conséquences, `accepted` ⇒ 0 point ouvert | chaque fait sourcé, exhaustif, daté/revalidable, neutre |
| **Nature / structure** | `<XY>-<SLUG>.md` dans le ticket ; H1 + résumé + DoD | `ADR-NNN-<slug>.md` ; entête + Contexte/Décision/Conséquences/Réf. | `fondations/<slug>.md` ; entête rigueur + sections numérotées + Sources |

## 3. Réalisations

1. **Skills créés** dans `.dev/skills/` — un dossier par livrable, chacun avec un `SKILL.md`
   (frontmatter `name`/`description` compatible avec la convention de skills, donc promouvable
   vers `.claude/skills/` plus tard) :
   - `artefact-de-travail/SKILL.md`
   - `adr/SKILL.md`
   - `essai-de-fondations/SKILL.md`
2. **ADR-003 enrichi** :
   - nouveau **§D5 — Catalogue des livrables** (tableau + renvois aux skills, extensible) ;
   - nouveau principe **« Livrable d'abord »** (§3) ;
   - skills et cet artefact ajoutés aux **Références** (§5).
3. **Principe d'évaluation** posé : *toute évaluation d'une tâche commence par l'identification
   du livrable à produire* — c'est lui qui dicte processus et critères.

## Definition of Done

- [x] Livrables du projet listés et caractérisés (succinctement dans ADR-003, en détail dans les skills).
- [x] Un skill par livrable dans `.dev/skills/`.
- [x] Principe « identifier le livrable d'abord » documenté dans ADR-003.
