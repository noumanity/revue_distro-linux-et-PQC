# CLAUDE.md (`.dev/`) : guide opératoire de l'agent IA

Ce fichier résume comment travailler dans ce dépôt. Les sources de vérité sont `.dev/CONSTITUTION.md` (règles impératives), `.dev/adr/ADR-003-methodologie-tickets.md` (méthodologie) et les skills `.dev/skills/`. En cas de conflit, la Constitution l'emporte, puis ADR-003.

## Règles impératives (à respecter sans exception)

1. **Ne jamais modifier un `ticket.md`** (Constitution C1). Ces fichiers appartiennent à l'humain (prompts, énoncés de tâches, journal). L'agent les lit, n'y écrit jamais. L'avancement se rapporte dans la conversation, pas dans le `ticket.md`.
2. **Markdown strict** dans tout livrable `*.md` (ADR-003 §D8) :
   - pas de filet horizontal (`---`, `***`, `___`) comme séparateur de section ; la structure passe par les titres (`#`, `##`, `###`). Seule exception : la clôture de l'en-tête YAML (`---`) en tête d'un `SKILL.md`.
   - pas de retour à la ligne manuel dans un paragraphe : un paragraphe tient sur une seule ligne source, et les blocs sont séparés par une ligne vide (deux lignes adjacentes fusionnent au rendu).
   - ne jamais utiliser le tiret cadratin (em dash, U+2014) ni le tiret demi-cadratin (U+2013) ; reformuler, ou employer parenthèses, deux points, ou un tiret simple entouré d'espaces.
3. **Livrable d'abord** : avant d'exécuter une tâche, identifier le type de livrable à produire ; son skill fixe alors le processus et les critères de qualité.
4. **Programmation et design conformes** : toute écriture ou révision de code du générateur de présentation (`scripts/dev.sh`, `activate`, prétraitement, `templates/`, thème) et toute décision de design de diapositive suivent `skl-004-programmation-et-design`. Ce skill consolide le stack (ADR-001), les principes de conception (ADR-002) et le cadre de design (FND-015). En particulier : LuaLaTeX plus Beamer plus metropolis, prétraitement bash plus Lua (texlua, lunamark, etlua), **ni Python ni pandoc**, aucune valeur de marque codée en dur (tout via `branding.yml` et `config.yaml`).

## Méthodologie de tickets (résumé d'ADR-003)

Le travail est segmenté en tickets sous `.dev/tickets/TKT-<XYZ>-<slug>/`. Le fichier `ticket.md` (humain) énonce les tâches numérotées ; la tâche `x` est la cible de clôture, assortie de sa Definition of Done. L'agent écrit ses livrables ailleurs que dans `ticket.md`.

Arborescence `.dev/` :

- `tickets/` : sujets de travail (un dossier par ticket).
- `adr/` : décisions d'architecture et de conception.
- `fondations/` : essais de recherche en profondeur, sourcés.
- `skills/` : un playbook par type de livrable, plus des skills de processus (ex. `skl-004-programmation-et-design`, garde-fou de conformité du code et du design).
- `CONSTITUTION.md` : règles impératives. `CLAUDE.md` : ce guide.

## Catalogue des livrables et leur skill (ADR-003 §D5)

| Livrable | Emplacement et nom | Skill |
|---|---|---|
| Artefact de travail | `tickets/TKT-<XYZ>-<slug>/<XY>-<SLUG>.md` | `skl-001-artefact-de-travail` |
| ADR | `adr/ADR-<XYZ>-<slug>.md` | `skl-002-adr` |
| Essai de fondation | `fondations/FND-<XYZ>-<slug>.md` | `skl-003-essai-de-fondations` |
| Skill | `skills/skl-<XYZ>-<slug>/SKILL.md` | auto-décrit (format Agent Skills) |

Le `ticket.md` et `CONSTITUTION.md` ne sont pas des livrables produits par l'agent.

Outre les skills de type de livrable ci-dessus, `skl-004-programmation-et-design` est un **skill de processus** (garde-fou) : il ne produit pas un livrable dédié mais conditionne toute programmation du générateur et tout choix de design (cf. règle impérative 4).

## Conventions de nommage (ADR-003 §D3 et §D6)

- À l'intérieur d'un ticket, un artefact de travail est préfixé par le numéro de la tâche qui l'a produit : `<XY>-<SLUG>.md` (`<XY>` sur 2 chiffres ; la tâche cible utilise `x-`).
- Les livrables persistés à plat sont numérotés séquentiellement avec un préfixe de type : `<PREFIX>-<XYZ>-<SLUG>` (`<XYZ>` sur 3 chiffres, ordre de création). Préfixes : `TKT` (ticket), `ADR`, `FND` (essai de fondation), `skl` (skill, en minuscules car la spec Agent Skills exige un `name` minuscule identique au dossier).

## Avant de livrer

- Vérifier les liens relatifs (aucune référence cassée).
- Vérifier le Markdown strict : un `grep` du tiret cadratin et des filets `---` (hors frontmatter de skill) ne doit rien renvoyer.
- Mettre à jour les références entrantes si un fichier est renommé ou déplacé.
