---
name: skl-001-artefact-de-travail
description: >-
  Produire un artefact de travail de tâche (`<XY>-<SLUG>.md`) dans le dossier d'un ticket.
  À utiliser dès qu'on exécute une tâche d'un ticket et qu'il faut documenter la réponse de
  l'agent (raisonnement, décisions, résultats) pour cette tâche précise.
---

# Skill — Artefact de travail de tâche

> Le livrable **par défaut** d'une tâche. Documente la **réponse de l'agent** à *une* tâche
> d'un ticket. C'est la matière première, datée et tracée, dont les ADR/essais extrairont
> ensuite ce qui mérite de survivre.

## Quand l'utiliser

À chaque tâche exécutée dans `.dev/tickets/TKT-<XYZ>-<slug>/`, **sauf** si le livrable explicite de
la tâche est un autre type (ADR, essai…). En cas de doute : commencer par **identifier le
livrable attendu** (voir ADR-003, principe « livrable d'abord »).

## 1. Inputs & primitives

- L'**énoncé de la tâche** et sa *Definition of Done* (dans `ticket.md`).
- Les **prompts** de la conversation pour cette tâche.
- Les **artefacts antérieurs** du même ticket et les **ADR / essais de fondations** pertinents.
- Le **code et les fichiers** du dépôt concernés.

## 2. Processus de travail

1. **Identifier le livrable** à produire (est-ce bien un artefact de travail ?).
2. Rassembler le **contexte** (inputs ci-dessus) ; lire avant d'écrire.
3. **Exécuter** la tâche (analyse, modifications, recherche…).
4. **Documenter** dans le fichier : objet, décisions prises, *pourquoi*, résultats, limites.
5. **Lier** les artefacts/ADR connexes (liens relatifs) ; mettre à jour les **références
   entrantes** si on renomme/déplace.
6. Mettre à jour le **journal** `ticket.md` (marquer la tâche, pointer vers l'artefact).

## 3. Critères de qualité & métriques

- ✅ **Répond exactement** à l'énoncé (DoD couverte, vérifiable).
- ✅ **Auto-portant** : compréhensible **sans** relire la conversation.
- ✅ **Traçable** : on sait *quoi* a été fait et *pourquoi*.
- ✅ **Liens valides** (aucune référence cassée).
- ✅ **Nommage** conforme `<XY>-<SLUG>.md` (`<XY>` = n° de tâche, 2 chiffres).
- ✅ **Markdown strict** : pas de filet `---` séparateur, pas de hard-wrap, pas de tiret cadratin (cf. ADR-003 §D8 et `.dev/CLAUDE.md`).

## 4. Nature & structure du livrable

- **Format** : Markdown, dans le **dossier du ticket**.
- **Nom** : `<XY>-<SLUG>.md` (cf. ADR-003 §D3).
- **Squelette** :
  ```markdown
  # Tâche <N> — <Titre>

  > **Objet / Résumé** : … (lien vers livrables jumeaux si plusieurs)

  ## <sections de corps : analyse, décisions, résultats…>

  ## Definition of Done
  - [x] …
  ```
- Le `ticket.md` n'est **pas** un artefact de travail (non préfixé).
