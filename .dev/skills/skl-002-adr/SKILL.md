---
name: skl-002-adr
description: >-
  Produire un Architecture/Design Decision Record (`.dev/adr/ADR-<XYZ>-<slug>.md`). À utiliser
  quand il faut acter une décision d'architecture ou de conception structurante, durable, et
  qui doit guider les décisions futures (et l'agent IA).
---

# Skill — ADR (décision d'architecture / de conception)

> Une **synthèse stable** qui acte **une décision** : son contexte, les options, le choix et
> sa justification, ses conséquences. Survit aux tickets ; sert de référence aux humains **et**
> aux agents IA.

## Quand l'utiliser

Quand une tâche aboutit à une **décision structurante** (stack, principe, méthodologie,
topologie…) qui doit rester valable au-delà du ticket. Les ADR de ce projet : `ADR-001`
(stack), `ADR-002` (principes de conception), `ADR-003` (méthodologie de tickets).

## 1. Inputs & primitives

- Les **artefacts de travail** qui ont mené à la décision (revues, analyses, prototypes).
- Les **contraintes & principes** applicables (cf. **ADR-002**).
- Les **options** réellement évaluées et leurs compromis.

## 2. Processus de travail

1. **Identifier la décision** unique à acter (un ADR = une décision / un enjeu).
2. Recenser **contexte** + **options** + **compromis**.
3. **Trancher** avec une **justification** explicite.
4. Expliciter les **conséquences** (positives, négatives, dette, suivi).
5. Fixer le **statut** : `proposed` → `unstable` (vivant) → `accepted`.
6. Lier les **sources** (artefacts, tickets) et numéroter séquentiellement.

## 3. Critères de qualité & métriques

- ✅ **Une seule décision** clairement énoncée, **datée**, avec décideur(s).
- ✅ **Contexte + options + justification** présents (pas juste la conclusion).
- ✅ **Conséquences** explicites.
- ✅ **Cohérence de statut** : un ADR `accepted` **ne contient aucun point ouvert / TODO**
  (les questions ouvertes ⇒ statut `unstable`). *(règle issue du ticket 003, tâche 8)*
- ✅ Style **homogène** avec les ADR existants.
- ✅ **Markdown strict** : pas de filet `---` séparateur (hors frontmatter), pas de hard-wrap, pas de tiret cadratin (cf. ADR-003 §D8 et `.dev/CLAUDE.md`).

## 4. Nature & structure du livrable

- **Emplacement** : `.dev/adr/`, nom `ADR-<XYZ>-<slug>.md` (`<XYZ>` séquentiel, 3 chiffres ; cf. ADR-003 §D6).
- **Entête** :
  ```markdown
  # ADR-<XYZ> — <Titre>

  - **Statut** : proposed | unstable | accepted
  - **Date** : AAAA-MM-JJ
  - **Décideurs** : …
  - **Tickets** : …
  ```
- **Corps** : `Contexte` → `Décision` → `Conséquences` → `Références`
  (ADR-002 admet une variante « collection de principes » avec statut `unstable`).
