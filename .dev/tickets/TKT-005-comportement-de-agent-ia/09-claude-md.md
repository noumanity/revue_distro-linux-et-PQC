# Tâche 9 : Fichier CLAUDE.md

Livrable créé : `.dev/CLAUDE.md`, guide opératoire de l'agent, cohérent avec ADR-003, les skills et la Constitution.

## Contenu

- Règles impératives en tête : ne jamais modifier `ticket.md` (Constitution C1), Markdown strict (ADR-003 §D8), et « livrable d'abord ».
- Résumé de la méthodologie de tickets et de l'arborescence `.dev/`.
- Catalogue des livrables et leur skill (aligné sur ADR-003 §D5).
- Conventions de nommage (§D3 pour `<XY>` dans un ticket, §D6 pour `<PREFIX>-<XYZ>` à plat).
- Liste de contrôle avant livraison (liens, grep Markdown, références entrantes).

## Cohérence vérifiée

- Nommage et catalogue identiques à ADR-003 (post tâche 7).
- Règles Markdown identiques à §D8.
- Règle C1 identique à `CONSTITUTION.md`.
- Le fichier est lui-même rédigé en Markdown strict (aucun tiret cadratin, aucun filet séparateur, aucun hard-wrap).

## Emplacement

Placé dans `.dev/` comme demandé par la tâche 8 (`@.dev/CLAUDE.md`). Il est chargé par l'agent quand il travaille dans cette arborescence.

## Definition of Done

- [x] `.dev/CLAUDE.md` généré.
- [x] Cohérent avec ADR-003, les skills et la Constitution.
- [x] Conforme aux règles Markdown strict.
