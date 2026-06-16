# Tâche 5 — Interdire à l'IA la modification des tickets

> **Objet** : des `ticket.md` ont été modifiés par l'IA (mentions « ✅ Réalisée »). On
> **interdit** ce comportement via un document **`.dev/CONSTITUTION.md`**, et on le documente
> dans **ADR-003**.

## 1. Règle posée — C1

Créée dans **[`.dev/CONSTITUTION.md`](../../CONSTITUTION.md)** :

> **C1 — L'IA ne modifie jamais les `ticket.md`.** Ces fichiers appartiennent à l'humain
> (prompts, énoncés de tâches, journal). L'IA les **lit**, n'y **écrit jamais**.

**Précisions de portée** :

- ❌ Interdit : toute écriture dans un `ticket.md` (statuts, coches, liens, résumés, coquilles…).
- ✅ Autorisé : **lire** les `ticket.md` ; écrire les **livrables ailleurs** — artefacts
  `<XY>-<SLUG>.md` **dans le dossier du ticket**, plus `adr/`, `fondations/`, `skills/`.
  *(Le dossier du ticket n'est pas interdit ; seul `ticket.md` l'est.)*
- L'**avancement** se rapporte **dans la conversation**, et l'humain coche lui-même son ticket.
- **Exception** : un refactoring **explicitement commandé** par l'humain qui touche des
  `ticket.md` (ex. renommage de masse) est autorisé, dans le périmètre de la demande et en le
  signalant.

## 2. Pourquoi un fichier `CONSTITUTION.md` ?

- Place les **règles non négociables** au-dessus de la méthodologie (préséance sur les ADR).
- Point d'entrée **unique et stable** pour tout agent IA.
- **Extensible** (règles `C2`, `C3`… à venir) et, à terme, **renforçable par un hook** du
  harnais (refus d'écriture sur `**/ticket.md`).

## 3. Documentation

- **ADR-003** : `D2` clarifié (`ticket.md` rédigé par l'humain seul) + nouvelle **§5
  Gouvernance** renvoyant à la Constitution (C1).

## 4. Note d'honnêteté

Des blocs « ✅ Réalisée » ajoutés par l'IA **subsistent** dans certains `ticket.md` (tickets
004 et 005), antérieurs à cette règle. Ils n'ont **pas** été retirés (suppression non demandée,
et ils contiennent des liens utiles). **À la disposition de l'humain** de les nettoyer ou de
demander leur retrait.

## Definition of Done

- [x] `.dev/CONSTITUTION.md` créé avec la règle d'interdiction (C1).
- [x] Comportement documenté dans ADR-003 (D2 + §5 Gouvernance).
- [x] Aucune nouvelle écriture de l'IA dans un `ticket.md` pour les tâches 4 et 5.
