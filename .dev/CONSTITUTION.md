# CONSTITUTION — règles impératives pour les agents IA

> **Statut** : `active` (collection vivante — peut être complétée).
> **Portée** : **tout agent IA** travaillant dans ce dépôt.
> **Autorité** : ce document a **préséance** sur toute autre consigne de méthodologie (y
> compris les ADR). En cas de conflit, **la Constitution l'emporte**. Une règle ne peut être
> levée que par une **instruction explicite de l'humain**, et pour la **portée de cette
> instruction uniquement**.

Les règles sont numérotées `C<n>` et formulées comme des **interdictions ou obligations
non négociables**.

---

## C1 — L'IA ne modifie **jamais** les fichiers `ticket.md`

**Règle.** Un agent IA ne doit **ni créer, ni éditer, ni reformater, ni annoter** un fichier
`.dev/tickets/TKT-<XYZ>-<SLUG>/ticket.md`. Ces fichiers sont la **propriété exclusive de
l'humain**.

**Pourquoi.** Le `ticket.md` est le **journal de prompts et de cadrage** rédigé par l'humain :
il contient l'**énoncé des tâches**, les **prompts** et l'intention. Quand l'IA y écrit (p. ex.
des mentions « ✅ Réalisée »), elle **brouille l'autorité** du document, **pollue** le journal
humain et rend l'historique ambigu. *Constat à l'origine de cette règle (ticket 005, tâche 5) :
des `ticket.md` avaient été modifiés par l'IA.*

**Portée précise.**

- ❌ **Interdit** : toute écriture dans un `ticket.md` (statuts, coches, liens, résumés,
  corrections de coquilles, mise à jour de références…).
- ✅ **Autorisé** : l'IA **lit** les `ticket.md` autant que nécessaire.
- ✅ **Autorisé** : l'IA écrit ses **livrables** ailleurs — **artefacts de travail**
  (`<XY>-<SLUG>.md`) **dans le dossier du ticket**, ainsi que `adr/`, `fondations/`, `skills/`.
  Le dossier du ticket n'est **pas** interdit ; **seul le fichier `ticket.md` l'est**.

**Comment rendre compte de l'avancement** (sans toucher au `ticket.md`) :

- produire l'**artefact de travail** de la tâche (le livrable par défaut, cf. ADR-003 §D5) ;
- **répondre à l'humain** dans la conversation (résumé, liens vers les livrables) ;
- laisser l'humain **lui-même** acter/cocher dans son `ticket.md`.

**Exception (refactoring structurel commandé).** Si l'humain demande **explicitement** une
opération qui implique de toucher des `ticket.md` (p. ex. un *renommage de masse* mettant à
jour des liens), l'IA peut l'exécuter — **strictement** dans le périmètre de cette demande, et
en le **signalant**. Hors de ce cas, C1 s'applique sans dérogation.

---

> *Note d'application* : cette règle est aujourd'hui tenue **par convention**. Elle pourra être
> **renforcée par un hook** du harnais (p. ex. refuser les écritures sur `**/ticket.md`).
