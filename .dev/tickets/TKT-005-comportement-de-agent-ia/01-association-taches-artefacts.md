# Tâche 1 — Association entre les tâches et les artefacts de travail

> **Comportement attendu** : l'agent nomme désormais ses artefacts de travail
> `<XY>-<SLUG>.md`, où `<XY>` est le numéro de la tâche (sur **2 chiffres**, zéro à gauche)
> qui a produit l'artefact. Objectif : qu'un humain repère immédiatement *de quelle tâche*
> provient un document quand il fouille un dossier de ticket.

## Convention adoptée

- **Format** : `<XY>-<SLUG>.md`
  - `<XY>` = numéro de la tâche, **zéro-paddé sur 2 chiffres** (`01`, `02`, … `06`).
  - `<SLUG>` = slug court, en `kebab-case`, décrivant le livrable (inchangé par rapport à
    l'usage précédent).
- **Emplacement** : inchangé — toujours dans le répertoire du ticket
  (`.dev/tickets/XYZ-<slug>/`).
- **Cas particuliers** :
  - Un artefact créé en tâche `N` puis **mis à jour** en tâche `M` conserve le préfixe de la
    tâche **d'origine** (`N`) : le préfixe trace la *genèse*, pas la dernière retouche.
    (Ex. `01-premier-jet.md`, créé en tâche 1 du ticket 000, raffiné en tâche 2.)
  - La tâche `x` (cible de clôture) reste `x` ; si elle produit un artefact, le préfixe est
    `x-` (mais ses livrables sont le plus souvent persistés ailleurs : `adr/`, racine…).
  - Le `ticket.md` lui-même n'est **pas** un artefact de travail : il n'est pas préfixé.

## Renommages appliqués (rétroactif)

| Ticket | Avant | Après | Tâche |
|---|---|---|---|
| 000 | `premier-jet.md` | `01-premier-jet.md` | 1 |
| 002 | `proposition-structure.md` | `01-proposition-structure.md` | 1 |
| 003 | `revue-outils-latex.md` | `01-revue-outils-latex.md` | 1 |
| 003 | `analyse-lua.md` | `02-analyse-lua.md` | 2 |
| 003 | `precisions-et-validation.md` | `03-precisions-et-validation.md` | 3 |
| 003 | `reponse-q4-lua-et-rendu.md` | `04-reponse-q4-lua-et-rendu.md` | 4 |
| 003 | `fonctionnalites-additionnelles.md` | `05-fonctionnalites-additionnelles.md` | 5 |
| 003 | `branding-parametrable.md` | `06-branding-parametrable.md` | 6 |
| 004 | `selection-variantes-logo.md` | `02-selection-variantes-logo.md` | 2 |
| 004 | `stockage-svg-et-imagen.md` | `03-stockage-svg-et-imagen.md` | 3 |

## Références mises à jour

- `.dev/tickets/TKT-000-definition-de-la-porté/ticket.md` → lien vers `01-premier-jet.md`.
- `.dev/adr/ADR-001-stack-technologique.md` (§7 Références) → les 7 artefacts des tickets
  002 et 003 pointent vers leurs nouveaux noms préfixés.

## Definition of Done

- [x] Tous les artefacts de travail existants suivent `<XY>-<SLUG>.md`.
- [x] Toutes les références entrantes (liens Markdown / chemins cités) sont corrigées.
- [x] La convention est formalisée (voir tâche 2 → [ADR-003](../../adr/ADR-003-methodologie-tickets.md)).
