# ADR-003 — Méthodologie de tickets & comportement de l'agent IA

- **Statut** : `unstable` (méthodologie vivante — affinée au fil des tickets ; cf. ticket 005)
- **Date** : 2026-06-13
- **Décideurs** : Jérémy Viau-Trudel (noumanity)
- **Tickets** : `005` (comportement de l'agent IA)

---

## 1. Contexte

Ce dépôt produit **une** présentation (Rencontres Linux du Québec) et fait un **usage
intensif de l'IA**. Pour cadrer ce travail assisté, on a adopté une **méthodologie de
tickets** légère, orientée *livrables*. Cet ADR **documente le comportement actuel** de
l'agent et la structure attendue, pour qu'ils servent de référence stable (un agent IA peut
lire cet ADR pour comprendre comment travailler dans ce dépôt).

> **Pourquoi des tickets et non des *issues* ?** On veut rester **focalisé sur la résolution
> d'un ticket et la production de ses livrables**. C'est un **outil de travail pragmatique**,
> pas un suivi de bugs. Documenter un problème ou une anomalie relève d'un autre mécanisme
> (p. ex. `.dev/issues/`).

## 2. Décision

### D1 — Arborescence `.dev/`

| Répertoire | Rôle |
|---|---|
| `.dev/tickets/TKT-<XYZ>-<SLUG>/` | Un **ticket** = un **sujet de travail** segmenté. |
| `.dev/adr/` | **ADR** : décisions d'architecture/conception, synthèses structurées. |
| `.dev/fondations/` | **Recherche en profondeur** sur un sujet métier (essais riches). |
| `.dev/issues/` | (au besoin) problèmes/anomalies — *séparés* des tickets. |

`adr/`, `fondations/` et `issues/` sont des **synthèses riches et réutilisables** : un agent
IA s'en sert pour comprendre le projet et **guider son comportement**.

### D2 — Anatomie d'un ticket

- Un ticket vit dans `.dev/tickets/TKT-<XYZ>-<SLUG>/`, numéroté (`TKT-000`, `TKT-001`, …; cf. §D6).
- Le fichier **`ticket.md`** se lit comme un **journal de travail** : il documente une
  **série complète de prompts** et l'avancement. Il est **rédigé exclusivement par l'humain** ;
  **l'IA ne le modifie jamais** (cf. [CONSTITUTION](../CONSTITUTION.md) **C1** et §6).
- Un ticket contient **plusieurs tâches** :
  - les tâches sont numérotées (`1`, `2`, …) ;
  - la **tâche `x`** est la **cible de clôture** : une fois complétée, le ticket peut être
    clos. On y associe une **description du livrable attendu** (≈ *Definition of Done*) pour
    garantir que le ticket est réellement applicable et débouche sur un livrable.
- **Tous les artefacts de travail** d'un ticket sont écrits **dans son répertoire**.

### D3 — Nommage des artefacts de travail : `<XY>-<SLUG>.md`  *(ticket 005, tâche 1)*

Chaque artefact de travail est nommé **`<XY>-<SLUG>.md`** :

- `<XY>` = **numéro de la tâche** qui a produit l'artefact, **zéro-paddé sur 2 chiffres**
  (`01`, `02`, …) ; la tâche cible utilise le préfixe `x-`.
- `<SLUG>` = slug court en `kebab-case` décrivant le livrable.

*Règles :*

- Le préfixe trace la **genèse** : un artefact créé en tâche `N` puis mis à jour plus tard
  **garde** `N`.
- Le `ticket.md` n'est **pas** préfixé (ce n'est pas un artefact de travail).

> **Pourquoi ?** Sans préfixe (`<SLUG>.md`), un humain qui fouille un dossier de ticket ne
> sait pas **de quelle tâche** provient un document. Le préfixe `<XY>` rétablit cette
> **traçabilité tâche → artefact** d'un coup d'œil.

### D4 — Rôle des artefacts vs. des synthèses

- Les **artefacts de travail** (`<XY>-<SLUG>.md`) documentent la **réponse de l'agent** pour
  chaque tâche : c'est la matière première, datée et tracée.
- Les **synthèses** (`adr/`, `fondations/`) **extraient et stabilisent** ce qui mérite de
  survivre au ticket. Un livrable de tâche peut donc être persisté **hors** du ticket
  (p. ex. l'ADR-001 est le livrable de la tâche `x` du ticket 003).

### D5 — Catalogue des livrables (et « livrable d'abord »)  *(ticket 005, tâche 3)*

L'agent produit **plusieurs types de livrables**, chacun avec ses *inputs*, son *processus*,
ses *critères de qualité* et sa *structure* propres. **Règle fondamentale** : **toute
évaluation d'une tâche commence par l'identification du livrable à produire** — c'est lui qui
dicte le processus et les critères de qualité.

| Livrable (produit par l'IA) | Emplacement / nom (**conforme à §D6**) | En une ligne | Skill |
|---|---|---|---|
| **Artefact de travail** | `tickets/TKT-<XYZ>-<slug>/<XY>-<SLUG>.md` | Réponse de l'agent à *une* tâche ; matière première tracée. | [`skl-001-artefact-de-travail`](../skills/skl-001-artefact-de-travail/SKILL.md) |
| **ADR** | `adr/ADR-<XYZ>-<slug>.md` | Acte **une décision** d'archi/conception (contexte→choix→conséquences). | [`skl-002-adr`](../skills/skl-002-adr/SKILL.md) |
| **Essai de fondation** | `fondations/FND-<XYZ>-<slug>.md` | Recherche en profondeur, **exhaustive et sourcée**, sur un sujet métier. | [`skl-003-essai-de-fondations`](../skills/skl-003-essai-de-fondations/SKILL.md) |
| **Skill** | `skills/skl-<XYZ>-<slug>/SKILL.md` | **Playbook** d'un type de livrable (les 4 axes). | *(auto-décrit — format *Agent Skills* ; pas de skill dédié)* |

- **Hors catalogue (pas des livrables de l'IA)** : le **`ticket.md`**
  (`tickets/TKT-<XYZ>-<slug>/ticket.md`) figure au **registre des préfixes (§D6)** mais est
  **rédigé par l'humain seul** (cf. §5 Gouvernance, **C1**) ; **`CONSTITUTION.md`** est un
  document de **gouvernance** singulier (cf. §5), non un type récurrent.
- La **caractérisation détaillée** de chaque livrable (les 4 axes) vit dans son **skill**
  (`.dev/skills/skl-<XYZ>-<slug>/SKILL.md`) ; l'ADR n'en donne que la **vue d'ensemble**.
  *(Le type **Skill** est **auto-décrit** par le format *Agent Skills* — pas de skill récursif.)*
- Le catalogue est **extensible** : un type **observé mais non encore standardisé** (p. ex. le
  *guide d'usage*, cf. `tickets/TKT-004-branding-noumanity/04-guide-usage-branding.md`) sera
  **promu** ici **et** doté d'un skill quand il se confirmera.

### D6 — Numérotation séquentielle des livrables : `<PREFIX>-<XYZ>-<SLUG>`  *(ticket 005, tâche 4)*

Pour les livrables **persistés à plat** dans un répertoire (et non rangés par ticket), un
mapping *ticket + tâche* apporterait **peu de valeur** et serait même **trompeur** (un essai de
fondation n'« appartient » pas à une tâche). On adopte donc, comme pour les ADR, une
**numérotation séquentielle** par **type**, avec un **préfixe** identifiant le type :

> **`<PREFIX>-<XYZ>-<SLUG>`** — `<XYZ>` = compteur **séquentiel** sur **3 chiffres**, par ordre
> de création ; `<SLUG>` = slug court en `kebab-case`.

**Registre des préfixes** :

| Type de livrable | Préfixe | Casse | Exemple |
|---|---|---|---|
| Ticket (dossier) | `TKT` | MAJ | `tickets/TKT-005-comportement-de-agent-ia/` |
| ADR | `ADR` | MAJ | `adr/ADR-003-methodologie-tickets.md` |
| Essai de fondation | `FND` | MAJ | `fondations/FND-001-recherche-preliminaire-pqc-distributions-linux.md` |
| Skill (dossier) | `skl` | **min.** | `skills/skl-002-adr/` |

- ⚠️ **Exception de casse pour les skills** : la spécification *Agent Skills* d'Anthropic exige
  un `name` en **minuscules** (lettres/chiffres/traits d'union) **identique au nom du dossier**.
  Le préfixe skill est donc **`skl`** (minuscule) et le `name:` du `SKILL.md` reflète le dossier
  (`name: skl-002-adr`). Cela garde les skills **promouvables tels quels** vers `.claude/skills/`.
- 🔁 **Distinction avec `<XY>-<SLUG>` (§D3)** : à l'**intérieur** d'un ticket, les artefacts de
  travail restent indexés par **numéro de tâche** (`<XY>`, 2 chiffres) — là, le lien tâche↔
  artefact **a** de la valeur. La numérotation **séquentielle** (`<XYZ>`, 3 chiffres) ne
  s'applique qu'aux livrables **à plat** (tickets, adr, fondations, skills).

### D7 — Typologie des parties d'un essai de fondation (FND)  *(ticket 005, tâche 6)*

L'analyse du corpus de fondations (ce projet + autres repos) montre qu'un essai FND combine un
**cadre quasi invariant** et un **corps composé** depuis un menu. Documenter ce gabarit évite de
**redécrire la structure** à chaque essai. *(Détail dans le skill `skl-003-essai-de-fondations`.)*

**Cadre (quasi universel — l'ossature)** :

1. **En-tête de genre** — titre signalant le type (« — recherche / revue / essai / dissertation »)
   + bloc *statut · date · objectif*.
2. **Avertissement méthodologique** — niveau de rigueur, qualité des sources (la *note de
   rigueur* des FND).
3. **Cadrage / Thèse** — question, **périmètre** (dans/hors), **définitions**.
4. *(… corps …)*
5. **Synthèse** — ce qu'il faut retenir.
6. **Limites** — ce qui n'est **pas** couvert + **péremption** (« à revalider »).
7. **Bibliographie / Sources** — **obligatoire** (chaque fait important sourcé).

**Corps (menu — à choisir/ordonner selon le sujet)** : Historique · Revue de littérature /
état de l'art · Panorama / cartographie / **taxonomie** · **Analyse critique** / réserves ·
Outils & instrumentation · Tendances actuelles · Comparaison · **Application au projet /
réponses aux questions du ticket / recommandations** · (Lexique).

> Le **cadre** ne se redécrit plus ; seul le **corps** se compose. Un essai sans cadre (p. ex.
> un *dump* de conversation) est **non conforme** et à reprendre au gabarit.

### D8 : Règles de rédaction Markdown strict (livrables `*.md`)  *(ticket 005, tâche 8)*

Les livrables `*.md` doivent être du **Markdown propre** dont la source reflète fidèlement le rendu. Trois règles impératives.

1. **Pas de filet horizontal comme séparateur de section.** Ne pas employer `---`, `***` ni `___` pour séparer des sections : la structure passe uniquement par les titres (`#`, `##`, `###`). Seule exception tolérée : la clôture de l'en-tête YAML (`---`) en tête d'un `SKILL.md`, requise par le format Agent Skills.
2. **Pas de retour à la ligne manuel dans un paragraphe.** Un paragraphe s'écrit sur **une seule ligne source** (aucune coupure à une colonne fixe). Les blocs (paragraphes, items de liste) sont séparés par **une ligne vide**. Raison : en Markdown, deux lignes adjacentes sans ligne vide **fusionnent** au rendu ; couper un paragraphe sur plusieurs lignes produit une source trompeuse.
3. **Ne jamais utiliser le tiret cadratin (em dash, U+2014).** Le remplacer par une reformulation, des parenthèses, deux points, ou un tiret simple entouré d'espaces. Éviter de même le tiret demi-cadratin (U+2013) pour les intervalles (écrire « de X à Y »).

Mesures pour s'en assurer :

- ces règles vivent aussi dans `.dev/CLAUDE.md` (chargé par l'agent), donc appliquées d'office ;
- auto-vérification avant de livrer : un `grep` du tiret cadratin et des filets `^---$` (hors frontmatter de skill) ne doit rien renvoyer, exception faite des documents qui définissent la règle et citent donc le caractère ;
- renforcement possible par un **hook** du harnais refusant toute écriture contenant un tiret cadratin ou un filet `---` hors frontmatter (via `/update-config`).

Les documents antérieurs à cette règle (y compris le présent ADR dans ses sections D1 à D7) ne sont pas encore conformes : une mise en conformité reste à planifier.

## 3. Principes & justificatifs

- **Un ticket par enjeu** → segmentation claire des enjeux.
- **Orientation livrable** : la tâche `x` + sa DoD garantissent qu'un ticket est applicable
  et produit quelque chose de concret.
- **Traçabilité** : `ticket.md` (journal de prompts) + artefacts préfixés (réponses par
  tâche) rendent le raisonnement **rejouable et auditable**.
- **Pragmatisme** : pas de cérémonie d'*issue tracker* ; on optimise pour *faire avancer et
  livrer*.
- **Livrable d'abord** : on identifie le **type de livrable** avant d'exécuter ; son **skill**
  fixe alors le processus et les critères de qualité (cf. §D5). Cela garantit qu'on travaille
  vers une cible explicite et évaluable.

## 4. Conséquences

- ✅ Repérage humain immédiat (tâche ↔ artefact) dans chaque dossier de ticket.
- ✅ Référence unique pour le comportement attendu de l'agent dans ce dépôt.
- ⚠️ Le préfixe `<XY>` doit être maintenu à la création de **tout** nouvel artefact.
- 🔁 Méthodologie `unstable` : susceptible d'évoluer (cf. ticket 005, tâche `x` —
  publication de la méthodologie).

## 5. Gouvernance — la Constitution

Les règles **non négociables** de comportement des agents IA vivent dans
**[`.dev/CONSTITUTION.md`](../CONSTITUTION.md)**, qui a **préséance** sur la présente
méthodologie. Règle fondatrice :

- **C1 — Tickets en lecture seule pour l'IA** : un agent IA **ne modifie jamais** un
  `ticket.md` (propriété de l'humain : prompts, tâches, journal). L'IA **lit** les tickets et
  écrit ses **livrables ailleurs** (artefacts `<XY>-<SLUG>.md` dans le dossier du ticket,
  `adr/`, `fondations/`, `skills/`). L'avancement se **rapporte dans la conversation**, pas
  dans le `ticket.md`. *(ticket 005, tâche 5)*

> Conséquence sur D2 : le `ticket.md` reste un journal, mais **rédigé par l'humain seul**.

## 6. Références

- `.dev/CONSTITUTION.md` (règle C1).
- `.dev/tickets/TKT-005-comportement-de-agent-ia/ticket.md`
- `.dev/tickets/TKT-005-comportement-de-agent-ia/01-association-taches-artefacts.md` (tâche 1)
- `.dev/tickets/TKT-005-comportement-de-agent-ia/03-standardisation-livrables.md` (tâche 3)
- `.dev/tickets/TKT-005-comportement-de-agent-ia/04-numerotation-sequentielle-livrables.md` (tâche 4)
- `.dev/tickets/TKT-005-comportement-de-agent-ia/05-interdiction-modification-tickets.md` (tâche 5)
- `.dev/skills/` — un skill par livrable (`skl-001-artefact-de-travail`, `skl-002-adr`, `skl-003-essai-de-fondations`).
- ADR-002 (principes de conception) — même esprit de *document vivant* `unstable`.
