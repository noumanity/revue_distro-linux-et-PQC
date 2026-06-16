# Tâche 7 — Corriger D5 d'ADR-003 (cohérence avec D6 + complétude)

> **Objet** : le catalogue **D5** n'était plus conforme à la pratique ni à D6 (nommage obsolète,
> types manquants). On **réaligne D5 sur D6**, on **complète** les types, et on corrige les
> incohérences **collatérales** dans ADR-003 et les skills.

## 1. Incohérences constatées

**Dans D5 (avant)** :

- Nommage **obsolète** vs D6 : `fondations/<slug>.md` (au lieu de `FND-<XYZ>-…`),
  `adr/ADR-NNN-<slug>.md`, `tickets/…/<XY>-<SLUG>.md` (sans `TKT-`).
- **Type manquant** : **Skill** (`skl-…`) — pourtant produit et utilisé.
- **Ambiguïté** : ni le `ticket.md` (humain, C1) ni `CONSTITUTION.md` (gouvernance) n'étaient
  situés vs le catalogue.

**Dans les skills (avant)** :

- `skl-002-adr` : `ADR-NNN-<slug>.md` → non aligné sur `<XYZ>` (D6).
- `skl-003-essai-de-fondations` : `fondations/<slug>.md` → manquait le préfixe `FND-<XYZ>`.
- `skl-001-artefact-de-travail` : `tickets/XYZ-<slug>/` → manquait `TKT-`.

## 2. Corrections appliquées

**D5 (ADR-003)** :

- Nommage de chaque ligne **rendu conforme à §D6** (`TKT-<XYZ>`, `ADR-<XYZ>`, `FND-<XYZ>`,
  `skl-<XYZ>`).
- **Ajout du type `Skill`** (`skills/skl-<XYZ>-<slug>/SKILL.md`) — **auto-décrit** par le format
  *Agent Skills* (pas de skill récursif).
- **Hors catalogue explicité** : `ticket.md` (rédigé par l'humain, C1) et `CONSTITUTION.md`
  (gouvernance singulière) — présents au **registre D6** pour le `ticket.md`, mais **pas** des
  livrables de l'IA.
- *Guide d'usage* requalifié en type **« observé mais non encore standardisé »** (avec son
  emplacement réel) plutôt qu'hypothétique.

**Skills** : nommage corrigé dans `skl-001` (`TKT-<XYZ>`), `skl-002` (`ADR-<XYZ>`),
`skl-003` (`FND-<XYZ>`), avec renvoi à §D6.

## 3. Cohérence D5 ↔ D6 (clarifiée)

L'asymétrie est **voulue** et désormais **documentée des deux côtés** :

| | D5 (livrables **produits par l'IA**) | D6 (objets **numérotés à plat** sous `.dev/`) |
|---|---|---|
| Artefact de travail | ✅ (`<XY>` task-numéroté, §D3) | ❌ (pas séquentiel) |
| ADR / Essai / Skill | ✅ | ✅ (`<XYZ>` séquentiel) |
| Ticket | ❌ (humain, C1) | ✅ (`TKT-<XYZ>`) |

## 4. Vérification

- ✅ Aucun motif non conforme résiduel (`ADR-NNN`, `fondations/<slug>`, `tickets/XYZ-…`,
  `skills/<nom>`) dans ADR-003 ni les skills.

## Definition of Done

- [x] D5 réaligné sur D6 (nommage).
- [x] D5 complété (type **Skill** ajouté ; ticket/Constitution situés hors catalogue).
- [x] Incohérences de nommage corrigées dans les 3 skills.
- [x] Cohérence D5↔D6 vérifiée et documentée.
