# Tâche 8 : Markdown strict pour les livrables

Constat : les livrables `*.md` ressemblaient à du Markdown mais comportaient des défauts (filets `---` comme séparateurs, paragraphes coupés sur plusieurs lignes, et usage du tiret cadratin). On documente le comportement attendu et les mesures.

## Règles adoptées (trois, impératives)

1. Pas de filet horizontal (`---`, `***`, `___`) comme séparateur de section : seuls les titres structurent. Exception : la clôture YAML (`---`) en tête d'un `SKILL.md`.
2. Pas de retour à la ligne manuel dans un paragraphe : un paragraphe tient sur une seule ligne source ; les blocs sont séparés par une ligne vide. Raison : deux lignes adjacentes sans ligne vide fusionnent au rendu, donc le hard-wrap produit une source trompeuse.
3. Ne jamais utiliser le tiret cadratin (em dash, U+2014) ni le demi-cadratin (U+2013). Reformuler, ou employer parenthèses, deux points, ou un tiret simple entouré d'espaces.

## Où c'est documenté

- `ADR-003` nouveau §D8 (règle et mesures).
- `.dev/CLAUDE.md` (chargé par l'agent, donc appliqué d'office) : section « Règles impératives ».
- Les trois skills (`skl-001`, `skl-002`, `skl-003`) : un critère de qualité « Markdown strict » renvoyant à §D8.

## Mesures pour s'en assurer

- L'agent applique les règles d'office car elles vivent dans `CLAUDE.md`.
- Auto-vérification avant livraison : un `grep` du tiret cadratin et des filets `^---$` (hors frontmatter de skill) ne doit rien renvoyer, sauf dans les documents qui définissent la règle et citent donc le caractère.
- Renforcement possible : un hook du harnais refusant toute écriture contenant un tiret cadratin ou un filet `---` hors frontmatter (à configurer via `/update-config`).

## Portée et reste à faire

Le nouveau contenu produit pour les tâches 8 et 9 (CLAUDE.md, ce §D8, ces artefacts) respecte les règles. Les documents antérieurs (ADR-003 sections D1 à D7, skills, essais FND-001 à FND-004, artefacts précédents) ne sont pas encore conformes : une mise en conformité reste à planifier (idéalement scriptée pour les filets et le hard-wrap, manuelle et relue pour le tiret cadratin car le remplacement dépend du sens).

## Definition of Done

- [x] Comportement attendu renseigné dans ADR-003 (§D8).
- [x] Renseigné dans `.dev/CLAUDE.md`.
- [x] Renseigné dans les skills (critère « Markdown strict »).
- [x] Mesures de contrôle décrites (auto-grep, hook).
