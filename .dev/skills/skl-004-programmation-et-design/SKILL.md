---
name: skl-004-programmation-et-design
description: >-
  Garde-fou de conformité pour programmer le générateur de présentation et concevoir les
  diapositives. À utiliser avant et pendant toute écriture de code (dev.sh, prétraitement,
  modèles, thème) ou toute décision de design de slide, pour respecter le stack figé par
  ADR-001, les principes ADR-002 et le cadre de design FND-015. Empêche les dérives
  (Python, pandoc, pdflatex, valeurs codées en dur, thème hors metropolis).
---

# Skill : programmation et design conformes

> Ce skill n'est pas un type de livrable : c'est une grille de conformité à appliquer dès qu'on touche au générateur de présentation ou au design d'une diapositive. Les décisions de référence ont déjà été prises et actées ; le rôle de l'agent est de les respecter, pas de les rejouer.

## Quand l'utiliser

- Avant d'écrire ou de modifier `scripts/dev.sh`, `activate`, le prétraitement, les gabarits `templates/models/`, le thème `beamerthemeNoumanity`, ou la configuration (`config.yaml`, `branding.yml`).
- Avant de concevoir ou réviser la mise en page d'une diapositive (grille, hiérarchie, typographie, couleur, espace blanc).
- En revue, pour vérifier qu'une implémentation existante (par exemple le prototype de TKT-002 tâches 3 et x) respecte les décisions avant de la reprendre (tâche 6).

## 1. Inputs et primitives (à charger avant d'agir)

- [ADR-001](../../adr/ADR-001-stack-technologique.md) : le stack technologique figé (statut Accepté).
- [ADR-002](../../adr/ADR-002-principes-de-conception.md) : les principes de conception P1 à P7.
- [FND-015](../../fondations/FND-015-design-des-diapositives.md) : le cadre de design des diapositives (grilles, fondamentaux, médium présentation), section 6 pour l'application au projet.
- [TKT-003](../../tickets/TKT-003-choix-de-la-stack/ticket.md) et ses artefacts : la genèse des choix de stack.
- `assets/branding/branding.yml` : la topologie de marque (2 couleurs, 2 polices, logo plus isotipo).

## 2. Décisions de stack à respecter (ADR-001)

- **Rendu** : Beamer plus **LuaLaTeX** (jamais pdflatex). Thème **beamerthemeNoumanity étendant metropolis** (ne pas réinventer un thème maison hors metropolis).
- **Orchestration** : **bash** (`scripts/dev.sh` avec `gen` / `clean` / `--help`, `activate`).
- **Prétraitement** : **Lua via texlua** (fourni par TeX Live, pas de runtime en plus). YAML lu en Lua ; Markdown vers LaTeX via **lunamark** ; templating via **etlua** (délimiteurs `<% %>`).
- **Interdits explicites** : **pas de Python**, **pas de pandoc** comme coeur du générateur (P2 ; jugés respectivement langage superflu et peu fiable pour un rendu pro). **pas de minted** (utiliser **listings**).
- **Bibliographie** : **biblatex plus biber**, un `.bib` central (`slides/references.bib`).
- **Paquets** : chargement piloté par les modèles (union dédupliquée des `%% requires:`). Socle : beamer, fontspec, babel french, csquotes, tikz, xcolor, graphicx, hyperref, listings, microtype. Adoptés : booktabs, fontawesome5, qrcode.
- **Build** : `latexmk -lualatex -outdir=workdir`, PDF copié dans `dist/presentation.pdf`.
- **variation** : implémentée par **overlays Beamer** (`\only` / `\onslide` / `\uncover`) sur une même frame.

## 3. Principes de conception à respecter (ADR-002)

- **P1 le plus simple pour l'utilisateur** : l'humain édite du Markdown, jamais du LaTeX ; CLI explicites, `--help`, sorties prévisibles.
- **P2 pas de langage superflu** : bash plus Lua plus outils CLI ; éviter Python.
- **P3 ne rien coder en dur** : valeurs de marque et de présentation dans `branding.yml` et `config.yaml`.
- **P4 minimalisme des dépendances** : ne charger que les paquets réellement utilisés.
- **P5 SVG si possible** : primitives graphiques en SVG, formats raster et PDF dérivés.
- **P6 lazy generating** : générer au dernier moment, cacher et réutiliser les intermédiaires.
- **P7 séparation des préoccupations** : contenu indépendant du rendu ; template indépendant de la marque (il n'en connaît que la topologie).

## 4. Cadre de design à respecter (FND-015)

Trois couches cumulatives à encoder dans les modèles plutôt qu'à improviser :

- **Grille** : marges constantes (title-safe), trame de référence 12 colonnes pour le 16:9, bande de titre stable, zone de contenu, pied (pagination, logo discret) ; tout élément aligné sur la grille.
- **Fondamentaux graphiques** : hiérarchie (titre dominant, corps subordonné), Gestalt (figure contre fond, d'où overlay sombre obligatoire sur photo de fond), CRAP (contraste, répétition, alignement, proximité), typographie de marque (ABeeZee titres, Arimo corps, échelle lisible en projection), couleur d'accent disciplinée (l'orange signale, ne remplit pas), espace blanc actif.
- **Médium présentation** : maximiser le signal et réduire le bruit (retirer tout élément sans valeur), une idée par diapositive (portée par le titre), distinguer la diapositive d'appui du document dense, data-ink ratio pour les figures et le code.

## 5. Anti-patterns (signaux d'alerte)

- Écrire le prétraitement en **Python** ou s'appuyer sur **pandoc** pour le rendu : non conforme (utiliser Lua/texlua, lunamark, etlua).
- Compiler avec **pdflatex** : non conforme (utiliser LuaLaTeX via latexmk).
- Recréer un thème de zéro au lieu d'**étendre metropolis**.
- Coder en dur des couleurs, polices ou textes de marque dans un gabarit : violer P3 (lire `branding.yml`).
- Charger des paquets non utilisés : violer P4.
- Diapositive saturée, plusieurs idées, listes à puces décoratives, fond photo sans overlay : violer FND-015.

## 6. Critères de qualité et de conformité

- ✅ Aucun Python, aucun pandoc, aucun pdflatex, aucun minted dans la chaîne.
- ✅ LuaLaTeX plus Beamer plus metropolis ; prétraitement bash plus Lua (texlua, lunamark, etlua).
- ✅ Aucune valeur de marque codée en dur ; tout vient de `branding.yml` et `config.yaml`.
- ✅ Paquets chargés en union des besoins des modèles utilisés.
- ✅ Modèles encodant la grille, la hiérarchie, la palette disciplinée, l'overlay sur fond photo, l'espace blanc.
- ✅ L'humain n'édite que du Markdown plus en-tête YAML.
- ✅ Markdown strict dans tout livrable `.md` associé (pas de filet de séparation, pas de hard-wrap, pas de tiret cadratin ; cf. ADR-003 §D8 et `.dev/CLAUDE.md`).

## 7. Note sur l'état actuel (à corriger en TKT-002 tâche 6)

Le prototype des tâches 3 et x de TKT-002 a été écrit avec Python, pandoc, pdflatex et un thème maison : il viole ADR-001 et P2. La tâche 6 (reprogrammer pour respecter le stack) doit le reprendre intégralement selon ce skill. Tenir ce skill pour la cible de conformité.
