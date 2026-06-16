# Tâche 4 — Numérotation séquentielle de tous les livrables sous `.dev/`

> **Objet** : pour les livrables **persistés à plat** (fondations, skills, tickets…), le mapping
> *ticket + tâche* (§D3) apporte peu de valeur et **embrouille** plutôt l'humain. On adopte,
> comme pour les ADR, une **numérotation séquentielle préfixée** : **`<PREFIX>-<XYZ>-<SLUG>`**.
> Préfixes **confirmés par l'humain** avant refactoring.

## 1. Convention adoptée

`<PREFIX>-<XYZ>-<SLUG>` — `<XYZ>` = compteur **séquentiel** (3 chiffres, ordre de création) ;
`<SLUG>` = `kebab-case`. Documentée dans **ADR-003 §D6**.

| Type | Préfixe | Casse | Note |
|---|---|---|---|
| Ticket (dossier) | `TKT` | MAJ | — |
| ADR | `ADR` | MAJ | déjà en place |
| Essai de fondation | `FND` | MAJ | préfixe demandé par la tâche |
| Skill (dossier) | `skl` | **min.** | contrainte Anthropic (cf. §3) |

**Non concerné** : les **artefacts de travail dans un ticket** gardent `<XY>-<SLUG>` (mapping
tâche, §D3) — là, le lien tâche↔artefact a de la valeur.

## 2. Préfixes confirmés (échange avec l'humain)

- Fondation → **`FND`** (parallèle à `ADR`).
- Skills → **`skl-XYZ`** en **minuscules**, `name:` aligné.
- Tickets → **`TKT-XYZ`**.

## 3. Contrainte Anthropic sur les skills (vérifiée)

La spec *Agent Skills* impose un `name` en **minuscules** (lettres/chiffres/traits d'union)
**identique au nom du dossier**. Un préfixe `SKL-` (majuscule) serait **incompatible** → on
retient **`skl-`** (minuscule), et chaque `SKILL.md` a `name: skl-<XYZ>-<slug>`. Les skills
restent **promouvables tels quels** vers `.claude/skills/`.
*(Source : spécification du format SKILL.md — name lowercase, dossier = name.)*

## 4. Refactoring appliqué

**Renommages**

| Avant | Après |
|---|---|
| `fondations/recherche-preliminaire-pqc-distributions-linux.md` | `FND-001-…` |
| `fondations/pratiques-design-web-tokens-et-quantomic-design.md` | `FND-002-…` |
| `fondations/03-mathematique-du-web.md` | `FND-003-mathematique-du-web.md` |
| `skills/artefact-de-travail/` | `skills/skl-001-artefact-de-travail/` |
| `skills/adr/` | `skills/skl-002-adr/` |
| `skills/essai-de-fondations/` | `skills/skl-003-essai-de-fondations/` |
| `tickets/000-…` → `005-…` | `tickets/TKT-000-…` → `TKT-005-…` (6 dossiers) |

**Références** : tous les liens/chemins `.md` mis à jour (remplacement littéral) ; `name:` des
3 skills alignés ; **ADR-003** mis à jour (D1, D2, **D6**, §6, références).

## 5. Vérifications

- ✅ Aucune ancienne référence (fondations/skills/tickets) résiduelle.
- ✅ Aucun lien relatif `.md` cassé **introduit** par le refactor (profondeur des dossiers
  inchangée). *(Lien pré-existant hors périmètre : `abstract.md` absent à la racine, référencé
  depuis le ticket 000.)*

## Definition of Done

- [x] Préfixe « essai de fondation » proposé et **confirmé** (`FND`).
- [x] Convention `<PREFIX>-<XYZ>-<SLUG>` appliquée à fondations, skills, tickets.
- [x] Compatibilité skills Anthropic vérifiée et respectée.
- [x] Documenté dans ADR-003 (§D6).
