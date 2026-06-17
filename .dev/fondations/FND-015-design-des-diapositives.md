# FND-015 : Design des diapositives (présentations professionnelles, grilles, design graphique) : recherche

> **Statut** : essai de fondation (tâche 4 du ticket TKT-002).
> **Date** : 2026-06-16. **Objectif** : établir un socle factuel et sourcé sur le design des présentations professionnelles, la théorie des grilles et les fondamentaux du design graphique, puis en tirer un cadre applicable aux diapositives de la présentation (Beamer + thème Noumanity, format 16:9).
> ⚠️ **Note de rigueur** : les références canoniques (Müller-Brockmann, Tufte, Reynolds, Duarte, R. Williams, Bringhurst) sont des ouvrages publiés et datés ; les recommandations chiffrées (largeurs de grille, proportions d'espace blanc) proviennent de praticiens et sont signalées comme heuristiques, non comme lois. Dates et attributions vérifiées au 2026-06-16.

## 1. Cadrage et thèse

### 1.1 Question de recherche

Quel corpus de principes (design graphique général, théorie des grilles, design de présentation) doit guider la conception visuelle des diapositives, et comment le traduire en règles opérationnelles pour un générateur Beamer piloté par modèles ?

### 1.2 Périmètre

Dans le périmètre : la composition visuelle d'une diapositive (mise en page, grille, hiérarchie, typographie, couleur, espace blanc), les principes propres au médium présentation (signal contre bruit, rythme narratif, rôle de l'oral), et l'application au stack figé par ADR-001 (Beamer, LuaLaTeX, base metropolis, topologie de marque Noumanity).

Hors périmètre : le contenu argumentatif de la présentation (traité par TKT-001 et les FND de communication), l'animation et la vidéo, l'accessibilité détaillée (contraste WCAG mentionné mais non approfondi), et l'implémentation logicielle proprement dite (objet de TKT-002 tâches 3, 6 et x, et du skill de la tâche 5).

### 1.3 Définitions de travail

- **Grille (grid)** : structure invisible de lignes et de champs qui organise le placement des éléments sur une surface. Ce n'est pas une contrainte esthétique mais un système de décision spatiale.
- **Hiérarchie visuelle** : organisation des éléments par importance perçue, qui dicte l'ordre de lecture.
- **Signal contre bruit (signal-to-noise ratio)** : rapport entre l'information pertinente et l'information parasite dans un affichage.
- **Diapositive d'appui (assistive slide)** contre **document (leave-behind, slidedoc)** : une diapositive projetée pendant un exposé n'a pas la même densité qu'un document lu seul ; les confondre produit le travers le plus courant.

### 1.4 Thèse

Un bon design de diapositive n'est pas une affaire de goût mais l'application disciplinée de trois couches : (1) une grille qui fixe la structure spatiale, (2) les fondamentaux du design graphique (hiérarchie, Gestalt, contraste, typographie, espace blanc) qui orientent l'attention, et (3) les principes propres au médium présentation (maximiser le signal, une idée par diapositive, l'écran appuie l'orateur sans le doubler). Le générateur doit encoder ces couches dans des modèles, de sorte que la conformité visuelle soit produite par construction et non laissée à l'improvisation de l'auteur.

## 2. Historique et écoles

### 2.1 Le Style typographique international (Style suisse)

La théorie moderne de la grille naît du Style typographique international (Swiss Style), formalisé dans les écoles de Zurich et de Bâle dans les années 1950. Josef Müller-Brockmann (1914-1996), formé à l'architecture et à l'histoire de l'art à Zurich, expose son interprétation de la grille dès 1961, puis publie l'ouvrage de référence, "Grid Systems in Graphic Design" (Raster Systeme), en 1981. La grille y est présentée comme l'expression d'un état d'esprit professionnel et éthique : ordre, clarté, objectivité, lisibilité. Müller-Brockmann insiste pourtant que "la grille est une aide, pas une garantie" : elle ouvre un espace de solutions, elle ne dispense pas du jugement.

Cet héritage compte directement ici : le thème metropolis (base imposée par ADR-001) procède de cette esthétique suisse (sobriété, sans-serif, aplats, fort espace blanc).

### 2.2 L'ère PowerPoint et sa critique

L'arrivée des logiciels de présentation grand public (PowerPoint, 1990) démocratise la diapositive mais installe des travers : surcharge textuelle, listes à puces systématiques, gabarits décoratifs. Edward Tufte formule la critique la plus connue : l'article "PowerPoint Is Evil" (Wired, 2003) et l'essai "The Cognitive Style of PowerPoint" (2003) reprochent à l'outil de fragmenter le raisonnement, d'imposer une logique hiérarchique appauvrissante et de privilégier le décor sur les données. Tufte avait déjà posé les bases dans "The Visual Display of Quantitative Information" (1983), où il forge les notions de **chartjunk** (ornement inutile) et de **data-ink ratio** (maximiser la part d'encre porteuse d'information).

### 2.3 Le mouvement Presentation Zen

En réaction, une école de design de présentation émerge à la fin des années 2000. Garr Reynolds ("Presentation Zen", 2008 ; "Presentation Zen Design", 2010) applique la simplicité d'inspiration zen et les principes du design d'information, dont le **signal-to-noise ratio** : tout élément qui peut être retiré sans changer le sens doit l'être. Nancy Duarte ("slide:ology", 2008 ; "Resonate", 2010) apporte la rigueur de studio (traitement des visuels, structure narrative de l'exposé) et popularise plus tard la notion de **slidedoc** pour distinguer la diapositive projetée du document destiné à la lecture.

## 3. Théorie des grilles graphiques

### 3.1 Anatomie d'une grille

Une grille se décompose en primitives stables :

- **Marges** : l'espace de respiration au bord de la surface ; elles cadrent le contenu et protègent les éléments des bords (et, à l'écran, du "title-safe" projeté).
- **Colonnes** : bandes verticales qui portent le contenu.
- **Gouttières (gutters)** : l'espace entre colonnes (et entre rangées), qui sépare sans cloisonner.
- **Champs ou modules (modules)** : cellules issues du croisement de colonnes et de rangées, dans une grille modulaire.
- **Lignes de flux (flowlines)** : lignes horizontales qui découpent l'espace en bandes et guident le déplacement de l'oeil.
- **Grille de ligne de base (baseline grid)** : trame verticale fine sur laquelle s'alignent les lignes de texte, garante d'un rythme typographique régulier.

### 3.2 Typologie des grilles

Müller-Brockmann et la littérature ultérieure distinguent quatre familles principales :

1. **Grille à colonne unique (manuscript / single-column)** : un seul bloc ; convient au texte continu, peu adaptée aux diapositives riches.
2. **Grille multi-colonnes (column grid)** : plusieurs colonnes ; souplesse pour juxtaposer texte et image.
3. **Grille modulaire (modular grid)** : colonnes plus rangées ; contrôle fin du placement, idéale pour les contenus hétérogènes (texte, figure, légende, code).
4. **Grille hiérarchique (hierarchical grid)** : modules irréguliers ajustés au contenu plutôt qu'à une trame régulière.

### 3.3 La grille appliquée à l'écran 16:9

Pour les diapositives panoramiques 16:9 (défaut moderne, recommandé notamment pour la conversion en vidéo), la pratique courante retient une **grille à 12 colonnes**, divisible proprement en 2, 3, 4 et 6 colonnes, ce qui couvre la plupart des dispositions (pleine largeur, demi, tiers, deux-tiers). Heuristiques de praticiens à retenir, en les traitant comme des points de départ :

- aligner chaque élément (titre, contenu, logo, pagination, mention légale) sur la grille invisible, pour une cohérence inter-diapositives ;
- caler le texte sur une grille de ligne de base pour un rythme vertical régulier ;
- dimensionner la gouttière en cohérence avec l'interligne (souvent gouttière proche de l'interligne) ;
- réserver de l'espace blanc significatif (un ordre de grandeur de 15 à 20 % de vide est cité comme signe de maîtrise, non comme règle stricte).

## 4. Fondamentaux du design graphique

### 4.1 Hiérarchie visuelle

La hiérarchie organise les éléments par importance et fixe l'ordre de lecture. Sur une diapositive : un titre dominant, un contenu d'appui subordonné, des éléments de service (pagination, logo) discrets. Les leviers de hiérarchie sont la taille, le poids (graisse), la couleur, la position et l'espace.

### 4.2 Principes de Gestalt

La psychologie de la forme (Gestalt) explique comment l'oeil regroupe les éléments en ensembles cohérents. Les principes les plus opérants en mise en page :

- **Proximité** : les éléments proches sont perçus comme liés.
- **Similarité** : les éléments semblables (forme, couleur) sont regroupés.
- **Clôture** : l'oeil complète les formes incomplètes.
- **Continuité** : l'oeil suit les lignes et les alignements.
- **Figure contre fond** : distinction entre l'objet et son arrière-plan (d'où l'importance d'un overlay sur une photo de fond pour garantir la lisibilité du texte).

### 4.3 Les quatre principes CRAP (Robin Williams)

Robin P. Williams, dans "The Non-Designer's Design Book" (1994), résume le design accessible en quatre principes, souvent désignés par l'acronyme CRAP :

- **Contrast (contraste)** : marquer fortement les différences (taille, couleur, graisse) pour signaler ce qui compte ; éviter les écarts timides.
- **Repetition (répétition)** : répéter des éléments visuels (couleur de marque, police, gabarit) pour créer l'unité d'un jeu de diapositives.
- **Alignment (alignement)** : tout élément s'aligne sur quelque chose ; l'alignement matérialise la grille invisible.
- **Proximity (proximité)** : regrouper ce qui va ensemble, séparer ce qui diffère, par l'espace.

Ces quatre principes recoupent et opérationnalisent la Gestalt et la grille ; ils forment une grille de relecture rapide de toute diapositive.

### 4.4 Typographie

La typographie est le vecteur principal du sens sur une diapositive. Repères (Bringhurst, "The Elements of Typographic Style", 1992, pour la doctrine ; pratique de présentation pour les valeurs) :

- limiter le nombre de familles (idéalement une à deux ; ici la topologie Noumanity impose ABeeZee pour titres et emphases fortes, Arimo pour le corps) ;
- établir une échelle typographique cohérente (titres, corps, légende) plutôt que des tailles arbitraires ;
- viser une taille de corps lisible à distance de projection (les praticiens recommandent de ne pas descendre sous une vingtaine de points pour le corps) ;
- soigner l'interligne et la longueur de ligne ; éviter les pavés de texte.

### 4.5 Couleur

La couleur sert la hiérarchie et l'identité, pas la décoration. Une palette de marque restreinte (ici deux couleurs : orange #FA4D1F et noir #000000, plus neutres techniques) suffit et renforce la répétition. Principes : usage parcimonieux de la couleur d'accent (réserver l'orange pour signaler, pas pour remplir), contraste suffisant texte/fond pour la lisibilité projetée, cohérence sémantique (une couleur égale une fonction).

### 4.6 Espace blanc

L'espace blanc (négatif) n'est pas du vide perdu mais un élément actif : il sépare, hiérarchise, met en valeur et exprime la confiance. Le réflexe à combattre est l'horreur du vide (remplir parce que la place existe). Une diapositive sobre et aérée porte mieux une idée qu'une diapositive saturée.

## 5. Design de présentations professionnelles

### 5.1 Maximiser le signal, réduire le bruit

Synthèse de Tufte et Reynolds appliquée à la diapositive : retirer tout ce qui n'ajoute pas de sens (chartjunk, ombres, dégradés, gabarits chargés, logos répétés trop gros, listes à puces décoratives). Le critère opérationnel de Reynolds : si un élément peut disparaître sans perte de sens, il doit disparaître.

### 5.2 Une idée par diapositive

Une diapositive porte une seule idée principale, énoncée idéalement par le titre. Le corps appuie cette idée ; il ne la concurrence pas par une seconde. Cette discipline favorise le rythme (plus de diapositives plus simples plutôt que peu de diapositives saturées) et la mémorisation.

### 5.3 Diapositive d'appui contre document

Distinction structurante (Duarte) : la diapositive projetée accompagne un orateur ; elle doit être lisible en quelques secondes et ne pas se substituer au discours. Le document destiné à être lu seul (slidedoc, leave-behind) peut être dense, mais c'est un autre artefact. Confondre les deux produit la diapositive-rapport illisible. Les notes de l'orateur (et un éventuel document séparé) portent la densité ; la diapositive porte le signal.

### 5.4 Les règles chiffrées et leurs limites

Les heuristiques populaires (règle du 6x6, du 7x7, du 10/20/30 de Guy Kawasaki) sont des garde-fous contre la surcharge, utiles comme rappels mais non comme lois : leur vraie fonction est de signaler qu'une diapositive trop dense doit être scindée ou allégée. On les cite comme symptômes, pas comme prescriptions rigides.

### 5.5 Texte, image et données

- **Texte** : phrases courtes ou syntagmes, pas de paragraphes ; le titre fait le travail.
- **Image** : pleine de sens et de qualité ; une image plein cadre avec overlay porte souvent mieux qu'un visuel timide encadré.
- **Données** : appliquer le data-ink ratio de Tufte (retirer grilles lourdes, ticks redondants, effets 3D) ; une figure égale un message.
- **Code** (pertinent pour la démo PQC) : extrait minimal, coloration sobre, taille lisible ; montrer la ligne qui compte, pas le fichier entier.

## 6. Application au projet (cadre opérationnel)

### 6.1 Contraintes héritées

Le stack est figé par ADR-001 : Beamer plus LuaLaTeX, thème beamerthemeNoumanity étendant metropolis, modèles (model) comme briques de mise en page, topologie de marque (2 couleurs, 2 polices, logo plus isotipo) externalisée dans branding.yml. metropolis fournit déjà une esthétique suisse (sobriété, espace blanc, sans-serif) compatible avec les principes ci-dessus ; le travail consiste à la spécialiser, pas à la combattre.

### 6.2 Une grille de référence pour la présentation

Adopter une grille implicite commune à tous les modèles, pensée pour le 16:9 :

- marges franches et constantes (zone title-safe) ;
- une trame de 12 colonnes comme référence de placement (pleine largeur, demi, tiers, deux-tiers) ;
- une bande de titre stable (le bandeau du thème), une zone de contenu, une zone de pied (pagination, et au besoin logo discret) ;
- alignement systématique de tous les éléments sur cette trame, y compris les éléments de service.

### 6.3 Traduction en principes de modèles

| Couche | Principe | Encodage dans le générateur |
|---|---|---|
| Grille | placement constant, alignement | gabarits model fixant marges, bande de titre, zone de contenu identiques |
| Hiérarchie | titre dominant, corps subordonné | échelle typographique du thème (ABeeZee titres, Arimo corps), une couleur d'accent |
| Gestalt | figure contre fond lisible | overlay sombre obligatoire sur les fonds photographiques |
| CRAP | répétition, cohérence | thème unique, palette de marque, gabarits réutilisés |
| Signal | une idée par diapositive | un model par intention ; corps Markdown bref ; pas de gabarit décoratif |
| Espace blanc | sobriété | densité de contenu limitée par modèle ; héritage metropolis |

### 6.4 Recommandations concrètes

1. **Le titre porte l'idée** : rédiger les titres comme des messages, pas des étiquettes.
2. **Un model par intention** : titre, contenu simple, section, et plus tard agenda/citation/figure/code ; ne pas multiplier les variantes décoratives.
3. **Overlay systématique** sur fond photographique pour garantir le contraste figure contre fond (déjà en place dans le modèle title).
4. **Palette disciplinée** : l'orange est une couleur de signal, pas de remplissage ; le corps reste noir sur blanc.
5. **Typographie de marque** : appliquer ABeeZee/Arimo via fontspec une fois le passage à LuaLaTeX effectué (tâche 6) ; conserver une échelle de tailles lisible en projection.
6. **Sobriété par défaut** : préférer plus de diapositives simples à peu de diapositives denses ; réserver la densité aux documents séparés (notes, article).
7. **Données et code** : appliquer le data-ink ratio ; pour la démo, ne montrer que les lignes signifiantes.

## 7. Synthèse

Le design de diapositive professionnel se ramène à trois couches cumulatives. La grille (héritage du Style suisse, Müller-Brockmann) fournit la structure spatiale et l'alignement. Les fondamentaux du design graphique (hiérarchie, Gestalt, CRAP de R. Williams, typographie de Bringhurst, usage discipliné de la couleur et de l'espace blanc) orientent l'attention. Les principes du médium présentation (signal contre bruit de Reynolds, data-ink de Tufte, une idée par diapositive et distinction diapositive/document de Duarte) adaptent le tout à un écran qui appuie un orateur. Pour le projet, ces couches doivent être encodées dans les modèles Beamer/metropolis spécialisés Noumanity, afin que la qualité visuelle soit produite par construction.

## 8. Limites et péremption

- Cet essai couvre la doctrine et les heuristiques, non l'accessibilité fine (contraste WCAG, daltonisme) ni l'animation, qui mériteraient un complément si la présentation les mobilise.
- Les valeurs chiffrées (12 colonnes, 15 à 20 % d'espace blanc, tailles de police) sont des heuristiques de praticiens, à ajuster à la salle, au projecteur et à la distance réelles ; à revalider lors d'un test de projection.
- Les références doctrinales (Müller-Brockmann, Tufte, R. Williams, Bringhurst, Reynolds, Duarte) sont stables ; les recommandations outillées (grilles PowerPoint, ratios) évoluent et seraient à revoir vers 2028 ou si le stack change.

## 9. Sources

- Josef Müller-Brockmann, "Grid Systems in Graphic Design / Raster Systeme für die visuelle Gestaltung" (exposé initial 1961, ouvrage 1981). [Notice et résumé](https://en.wikipedia.org/wiki/Grid_(graphic_design)) ; [PDF d'archive](https://ia802309.us.archive.org/4/items/GridSystemsInGraphicDesignJosefMullerBrockmann/Grid%20systems%20in%20graphic%20design%20-%20Josef%20Muller-Brockmann.pdf) ; [fiche éditeur](https://draw-down.com/products/grid-systems-in-graphic-design).
- Edward Tufte, "The Visual Display of Quantitative Information" (1983) ; "PowerPoint Is Evil" (Wired, 2003) ; "The Cognitive Style of PowerPoint" (2003). Concepts de chartjunk et data-ink ratio. [Synthèse signal/bruit, IEEE ProComm](https://procomm.ieee.org/design-your-slides-to-maximize-signal-to-noise-ratio/).
- Garr Reynolds, "Presentation Zen" (2008) et "Presentation Zen Design" (2010). [Design tips de l'auteur](https://www.garrreynolds.com/design-tips) ; [Design Fundamentals: Contrast, Repetition, Alignment, Proximity](https://presentationzen.com/blog/design-fundamentals-contrast-repetition-alignment-proximity).
- Nancy Duarte, "slide:ology" (2008) et "Resonate" (2010) ; notion de slidedoc (diapositive d'appui contre document).
- Robin P. Williams, "The Non-Designer's Design Book" (1994) : principes CRAP. [Synthèse CRAP](https://clueify.com/blog/crap-design-principles/).
- Principes de Gestalt appliqués au design. [Toptal, Gestalt Principles](https://www.toptal.com/designers/ui/gestalt-principles-of-design) ; [Interaction Design Foundation, Visual Hierarchy](https://ixdf.org/literature/topics/visual-hierarchy).
- Robert Bringhurst, "The Elements of Typographic Style" (1992) : doctrine typographique.
- Pratiques de grille pour diapositives 16:9 (grille 12 colonnes, baseline, gouttières, espace blanc). [BrightCarbon, grids and guides](https://www.brightcarbon.com/blog/advanced-powerpoint-grids-guides/) ; [SlideBazaar, invisible grid system](https://slidebazaar.com/blog/the-invisible-grid-system-that-makes-every-slide-layout-look-intentional/) ; [Design Shack, grids and typography](https://designshack.net/articles/layouts/grids-and-typography/) ; [Memorial University, accessible PowerPoint](https://blog.citl.mun.ca/technologyresources/microsoft-powerpoint/designing-accessible-powerpoint-presentations/).
