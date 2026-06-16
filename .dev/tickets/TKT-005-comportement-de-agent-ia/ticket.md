# Comportement attendu de l'agent IA

## Contexte

Ce projet fait un usage intensif de l'IA.

On utilise une méthodologie de tickets:

- les tickets sont dans `@.dev/tickets/XYZ-<SLUG>/ticket.md`
- un ticket pas sujet de travail
- plusieurs tâches par ticket:
- la tâche X est la cible qui, une fois complétée permettra de clore le ticket
- tous les artefacts de travail sont écrit dans le répertoire du ticket
- d'autres documents fréquemments persistés:
  - @.dev/adr => ADR
  - @.dev/fondations => recherche en profondeur sur un sujet métier

### Principes de conception et justificatifs

- un ticket par enjeux => segmentation des enjeux
- pourquoi ticket et pas issues? => on veut vraiment être focus sur la résolution d'un ticket et la production de ses livrables. C'est un outil de travail pragmatique. On ne décrit pas des issues ou documenter des problèmes. Ci c'est le besoin, utiliser un autre mécanisme comme: `@.dev/issues/` 
- le fichier ticket se lit comme un journal de travail. Et il documente une série complète de prompts
- les artefacts de travail documentes les réponses de l'agent IA pour chaque tâche
- en ayant une tâche X, on s'assure que le ticket est réellement applicable. Pour renforcer cette qualitée, on ajout une description du livrable attendu dans la tache x ( == DoD)
- les autres répertoires comme `adr`, `fondations`, `issues` sont des synthèses structurées et riches qui peuvent être utilisés par un agent IA pour comprendre le projet et guider son comportement

## Problématique

- certains comportements de l'agent IA pourraient être améliorer
- on veut conserver la méthodologie utilisée ici

## Tâches

### 1. [behavior-enhancement] association entre les tâches et les artefacts de travail ✅

> **Réalisée** — artefact : [`01-association-taches-artefacts.md`](01-association-taches-artefacts.md).
> Convention `<XY>-<SLUG>.md` adoptée ; 10 artefacts existants (tickets 000, 002, 003, 004)
> renommés ; références entrantes (ticket 000, ADR-001) corrigées.

#### constat

Actuellement, l'agent écrit ses artefacts sous la forme <SLUG>.md

#### problème

c'est difficile de se repérer pour un humain quand recherche des informations dans ces documents et de savoir rapidement lors de quelle tâche ils ont été générés.

#### comportement attendu

Utiliser le format `<XY>-<SLUG>.md`


### 2. documenter dans un ADR ✅

Documenter le comportement actuel dans ADR-003

> **Réalisée** — livrable : [`ADR-003 — Méthodologie de tickets & comportement de l'agent IA`](../../adr/ADR-003-methodologie-tickets.md).
> Documente l'arborescence `.dev/`, l'anatomie d'un ticket, la convention `<XY>-<SLUG>.md`
> (tâche 1) et les principes/justificatifs. Statut `unstable`.

### 3. standardiser les livrables ✅

> **Réalisée** — artefact : [`03-standardisation-livrables.md`](03-standardisation-livrables.md).
> 3 livrables caractérisés (artefact de travail, ADR, essai de fondations) ; un skill par
> livrable dans [`.dev/skills/`](../../skills/) ; ADR-003 enrichi (§D5 catalogue + principe
> « livrable d'abord »).

L'IA est appelé à effectuer à livrer plusieurs types de documents. Par exemple: des adr dans `@.dev/adr` et des essaies dans `@.dev/fondations`.

La production de chaque livrable a différents :
- inputs et primitives
- processus de travail
- critères de qualité et métriques qui permettent l'évaluation
- nature et structure du livrable produit

TODO => documenter cela dans l'ADR-003 + produire un skill pour chaque livrable dans `@.dev/skills`

- listez et caractérisez les livrables utilisés dans ce projet. succintement dans l'adr puis en détail dans les skills
- toujours commencer l'évaluation d'une tâche par l'identification du livrable à produire

### 4. numéroter tous les livrables sous .dev

Un phénomène de confusion mentale similaire à celui décrit dans la tâche 1 a lieu pour les document de fondation.

Dans ce cas, un mappage entre ticket + tâche et le livrable apporterait peu de valeur et serait même plus confondant pour un humain.

Appliquer la même solution que pour les adr: une numérotation séquentielle.

Adopter la convention suivante: <PREFIX>-<XYZ>-<SLUG>.md

Proposer un préfix qui représente bien "Essai de fondation".

Appliquer la même logique à tous les livrables de @.dev/ => fondations, skills, tickets, ...

Demander de confirmer les préfix, puis procéder au refactoring

Documenter dans ADR-003


### 5. Interdire aux agent IA la modification des tickets

Je constate que des fichiers tickets ont été modifiés par l'IA.

Interdire ce comportement.

Créer un document @.dev/CONSTITUTION.md et y ajouter cette règle.

Documenter dans ADR-003

### 6. Composants d'un essai FND

#### constat

Les mêmes sections reviennent souvent dans les essai de fondation. Je me retrouve à décrire encore et encore les mêmes choses à chaque demande.

#### TODO

Analyser le contenu de tous les fichiers de fondation existants dans ce projet et dans les autres. Pattern de recherche approximatif: $HOME/git/**/fondation/*.md

identifier les composants typique de ces documents. Voici ceux que j'ai en tête intuitivement:

- revue de la litérature
- historique
- analyse critique

Proposer une typologie des parties des essai de fondation et documenter-la dans ADR-003

### 7. Corriger D5 de ADR-003

Le catalogue n'est pas conforme à la pratique et aux dernières révisions des décisions.

Notamment, il est incohérent par rapport à D6 et ne contient pas tous les types de livrables utilisés.

voir D6 et la pratique dans @.dev/

Vérifier s'il y a d'autres incohérence dans ADR-003 et dans les skils.

Corriger ADR-003 et, au besoin, les skils.

### 8. [behavior] usage de markdown strict

#### constat

Les livrables portant l'extension `*.md` ressemblent à des documents markdown mais comporte plusieurs défauts.

en voici quelques un:

- Usage de  --- pour séparer un section
- lignes trop longue car il n'y a pas de saut de ligne lors du tendu pour un texte qui est sur une ligne adjacente (ça prend une espace entre les 2 pour créé un nouveau paragraphe)

Autre défaut à corriger impérativement: usage du caractère  —

#### TODO

Renseigne le comportement attendu et les mesures à prendre pour s'en assurer dans ADR-003, @.dev/CLAUDE.md et dans les skills selon le besoin.

### 9. Fichier CLAUDE.md

Générer un fichier CLAUDE.md cohérent avec ADR-003 et les skills

### 10. raison d'être de .dev et comment l'utiliser

#### Raisons

##### travail simultanné sur plusieurs repos

habituellement un anti-pattern, mais dire pourquoi on le fait ici => usage structuré de IA élimine les problématiques usuelles de cette pratique par les humains.

.dev et un repo git indépendant

.dev/repos contient les repos sur lesquels on travail

on doit également spécifier quels sont les repos sur lesquels on travaille, pourquoi faire, les types de livrables autorisés à produire dans chaque repo

##### ne pas polluer repos avec artefacts de développement

Principe de design: "les outils de développement c'est comme des bobettes: on garde ça pour soi." (c'est intime, on a le droit de choisir ce qu'on veut et on a pas à les montrer à tout le monde, on a des préférences personnelles qui font qu'on est plus confortable dans une que dans l'autre)


##### Centraliser tous les artéfacts nécessaires au développement


#### issues

renseigner ces problèmes reconnu mais qui ne peuvent pas être traités pour l'instant:

Semblent être surtout lié à la décentralisation.

##### comment partager un sous ensemble d'artefact?

##### comment identifier une source de vérité  ou la modifier 


CONSTAT IMPORTANT: le travail distribué demande d'avoir une source de vérité. Dans une approche décentralisé, il n'y a simplement plus de source de vérité absolu. Simplement des sources de vérité relative à un contexte : agent / individu ou bien référence / autorité

...

### 11. issues



### x. publier la méthodologie dans github.com/noumanity/nou-ai-methodology.git

