# Branding noumanity — kit d'usage

Données d'image de marque de **noumanity** récupérées pour la présentation.
Source : <https://github.com/noumanity/imagen> (fichier de référence : `marca.yml`).

## Spécification (extrait de `marca.yml`)

| Élément | Valeur |
|---|---|
| **Couleur primaire** | `#fa4d1f` (orange) |
| **Couleur secondaire** | `#ffffff` (blanc) |
| **Police primaire** | **Arimo** |
| **Police secondaire** | **ABeeZee** |
| **Logo par défaut** | `logo/noumanity-logotipo-color.svg` |

> 💡 Les polices **Arimo** et **ABeeZee** sont des **Google Fonts libres** (embarquables sans
> souci dans le PDF). → Cela **répond à la question ouverte du ticket 003** (« quelle est la
> police de marque noumanity ? »). Les fichiers de police ne sont pas dans le dépôt `imagen` ;
> ils peuvent être récupérés via Google Fonts ou `texlive-fonts-extra` (Arimo) — à déposer
> dans `assets/fonts/` au besoin.

## Contenu de ce dossier — **SVG uniquement** (primitives)

> Principe de conception « **utilisez SVG si possible** » + « **lazy generating** »
> (cf. [ADR-002](../../.dev/adr/ADR-002-principes-de-conception.md)). Seules les
> **primitives SVG** sont stockées ; les formats raster/PDF sont produits **à la demande**
> au moment de la génération. Tous les assets sont **propres** (sans « transformation
> numérique »).

```
branding/
├── marca.yml                            # spécification minimale officielle
├── branding.yml                         # jetons de marque consommés par le thème
├── noumanity-brand-manual.pdf           # manuel de marque (référence ; doc, pas une primitive)
├── logo/                                # mot-symbole « noumanity »
│   ├── noumanity-logotipo-color.svg     #   COULEUR (bichromie orange/noir)
│   └── noumanity-logotipo-white.svg     #   BLANC (fond foncé)
└── isotipo/                             # symbole seul (le « slash »)
    ├── noumanity-isotipo-color.svg      #   COULEUR (orange)
    └── noumanity-isotipo-white.svg      #   BLANC (fond foncé)
```

Ces SVG ont été **extraits/vectorisés** depuis le dépôt de marque via l'outil
**`imagen.sh`** (dans `workdir/imagen/scripts/`), qui produit n'importe quelle variante
propre sur stdout :

```bash
. workdir/imagen/activate
imagen.sh logotipo color > logo.svg     # types : logotipo | isotipo
imagen.sh isotipo  white > iso.svg      # labels : color | white | black | orange
```

## Conventions d'usage

- **Source = SVG.** Les PNG/PDF sont **générés au build** (lazy), jamais stockés ici.
- **Sur fond clair** : variante `color`. **Sur fond foncé** : variante `white`.
- **Logo vs isotipo** : le **logo** (mot-symbole) pour les pages titre / pied de page ;
  l'**isotipo** (symbole) pour les usages compacts (coin de slide, puce).

## ⚠️ Règle d'exclusion (consigne du ticket 004)

Le logo portant la mention **« transformation numérique »** **ne doit pas être utilisé**.
La mention étant **dans l'image** (tracés vectorisés, pas dans le nom de fichier), une
sélection sur les noms ne suffisait pas. Les assets de ce dossier ont donc été
**nettoyés** (tâche 2) :
- **Wordmark** : exporté depuis `noumanity-norma.svg` en **respectant son `viewBox`**, qui
  recadre sur une cellule **propre** ; version blanche obtenue par recoloration.
- **Isotipo** : la **tagline a été recadrée (crop)** des PNG individuels.
- Tous les fichiers individuels qui contenaient la tagline (`logo-noumanity-*.png`,
  planches `*.svg`/`.pdf`) ont été **supprimés**.

## Sélection / nettoyage effectués

N'ont **pas** été repris ou ont été retirés : les fichiers `.ai` (sources éditables), les
`.jpg` (doublons), les variantes `*2.*`, le dossier `diseño/` (maquettes web), les
**planches de variantes** (`logo noumanity.svg/pdf`, `Isotipo Noumanity.svg/pdf`) et **tout
asset portant la mention « transformation numérique »**.
