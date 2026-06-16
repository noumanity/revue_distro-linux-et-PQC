---
name: skl-003-essai-de-fondations
description: >-
  Produire un essai de fondation (`.dev/fondations/FND-<XYZ>-<slug>.md`) : recherche en profondeur,
  exhaustive et sourcée, sur un sujet métier. À utiliser quand une tâche demande d'établir une
  base factuelle « irréprochable » réutilisable par d'autres tâches/agents.
---

# Skill — Essai de fondations (recherche en profondeur)

> Une **synthèse de recherche** rigoureuse et **sourcée** sur un sujet métier. Sert de **socle
> factuel** réutilisable (par la présentation, par d'autres tickets, par un agent IA). Ex. :
> `FND-001-recherche-preliminaire-pqc-distributions-linux.md`.

## Quand l'utiliser

Quand la tâche demande d'**explorer en profondeur** un sujet (état de l'art, panorama,
analyse critique) et de produire un document de **référence**, distinct d'une simple réponse
de tâche.

## 1. Inputs & primitives

- Une **question de recherche** et un **périmètre** explicites.
- Des **sources primaires** (specs, documentation officielle, articles, dépôts).
- Les **contraintes de rigueur** (public, niveau d'exigence, fraîcheur attendue).

## 2. Processus de travail

1. **Cadrer** la question et délimiter le périmètre (ce qui est dans / hors sujet).
2. **Recherche exhaustive** multi-sources ; privilégier les sources primaires.
3. **Synthèse structurée** par thèmes ; comparer, hiérarchiser, trancher les ambiguïtés.
4. **Rattacher chaque affirmation factuelle** importante à une **source**.
5. **Dater** et noter la **péremption** (ce qui devra être revalidé, et quand).
6. Inclure, si pertinent, une **analyse critique** et des recommandations.

## 3. Critères de qualité & métriques

- ✅ **Rigueur « irréprochable »** : chaque fait clé est **sourcé**.
- ✅ **Exhaustivité** du périmètre annoncé (pas de zone d'ombre majeure).
- ✅ **Daté & revalidable** : on sait à quelle date l'info était vraie.
- ✅ **Neutre et factuel** ; les opinions sont signalées comme telles.
- ✅ **Navigable** : sections numérotées, table des matières si long.
- ✅ **Markdown strict** : pas de filet `---` séparateur, pas de hard-wrap, pas de tiret cadratin (cf. ADR-003 §D8 et `.dev/CLAUDE.md`).

## 4. Nature & structure du livrable

- **Emplacement** : `.dev/fondations/`, nom `FND-<XYZ>-<slug>.md` (`<XYZ>` séquentiel ; sujet en `kebab-case` ; cf. ADR-003 §D6).
- **Entête** :
  ```markdown
  # <Titre> — recherche

  > **Statut** : essai de fondation (tâche(s) … du ticket …).
  > **Date** : … — **Objectif** : …
  > ⚠️ **Note de rigueur** : chaque affirmation est sourcée ; dates vérifiées à …
  ```
- **Corps** : sections thématiques **numérotées** ; cadrage en tête.
- **Fin** : section **`Sources`** (références traçables).

### Gabarit type (cadre + menu) — cf. ADR-003 §D7

Un essai FND combine un **cadre invariant** et un **corps composé**. Réutiliser ce gabarit
plutôt que de redécrire la structure :

**Cadre (toujours présent, dans cet ordre)** :

1. **En-tête de genre** — titre « — recherche / revue / essai / dissertation » + bloc
   *statut · date · objectif*.
2. **Avertissement méthodologique** (*note de rigueur*) — qualité des sources, niveau d'exigence.
3. **Cadrage / Thèse** — question, **périmètre** (dans/hors), **définitions** de travail.
4. *(corps — voir menu)*
5. **Synthèse** — ce qu'il faut retenir.
6. **Limites** — non-couvert + **péremption** (« à revalider à … »).
7. **Bibliographie / Sources** — **obligatoire**.

**Corps (menu — choisir/ordonner selon le sujet)** :

- **Historique / évolution**
- **Revue de littérature / état de l'art**
- **Panorama / cartographie / taxonomie** (inventaire structuré)
- **Analyse critique / réserves** (forces, faiblesses)
- **Outils & instrumentation**
- **Tendances actuelles**
- **Comparaison / synthèse comparative**
- **Application au projet / réponses aux questions du ticket / recommandations**
- *(Lexique / glossaire — optionnel)*

> ✅ **Conformité** : un essai sans ce cadre (p. ex. un *dump* de conversation) est **non
> conforme** ; le reprendre au gabarit. Commencer **toujours** par poser le cadre, puis composer
> le corps depuis le menu.
