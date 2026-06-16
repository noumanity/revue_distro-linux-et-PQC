# Tâche 2 : scanners supplémentaires (SCANOSS et autres), et pourquoi ils manquaient

## Le constat

Une recherche Google simple fait remonter des candidats absents de la première version de FND-006, notamment SCANOSS. La question est : pourquoi ?

## Pourquoi ils manquaient

La cause n'est pas qu'ils sont hors sujet, mais un biais de périmètre et de recherche.

1. Biais de cible de scan. FND-006 a été écrit pour la démo, qui scanne des images au repos (ISO et conteneurs). J'ai donc privilégié les scanners d'image et de système de fichiers (cbomkit-theia, Syft, Trivy) et sous-pondéré les scanners de code source. Or SCANOSS Crypto Finder, cryptobom-forge et CodeQL travaillent sur le code source.
2. Biais de catégorie. SCANOSS est d'abord connu comme un outil de SCA (analyse de composition logicielle par empreintes de code). Sa fonction de détection cryptographique (Crypto Finder) est récente, donc il n'apparaît pas spontanément dans des recherches centrées sur le mot CBOM.
3. Biais de requêtes. Mes recherches initiales tournaient autour de CBOM, CycloneDX, image de conteneur et des fournisseurs d'inventaire cryptographique. SCANOSS et cryptobom-forge sont indexés plutôt sous SCA et détection de crypto au niveau source.

En résumé : ces outils produisent bien des CBOM, mais ils s'appliquent au code source, pas à une ISO ou à un conteneur livré sans source. Ils sont pertinents pour qui dispose du code, moins directement pour notre démo sur images.

## Ce qui a été ajouté à FND-006

- SCANOSS Crypto Finder : détection d'algorithmes, protocoles, certificats et clés dans le code source ; sortie CBOM CycloneDX ; analyse par règles via OpenGrep, consciente de la syntaxe (AST) ; langages Java, Python, Go, C.
- cryptobom-forge (Santander Security Research) : construit un CBOM à partir des résultats de CodeQL.
- CodeQL, Semgrep et OpenGrep : moteurs d'analyse statique scriptables pour repérer la crypto et alimenter un CBOM.
- Une note de transparence expliquant l'omission initiale.
- Trois sources ajoutées (12, 13, 14) et deux lignes dans le tableau comparatif.

## Autres candidats repérés mais non retenus comme outils de CBOM au sens strict

- Checkmarx, Cybeats SBOMgen : plutôt des plateformes commerciales de SCA ou de SBOM avec contenu sur le CBOM ; à surveiller.
- Cryptoscope : travail académique d'analyse des usages cryptographiques, pas un produit.

## Leçon de méthode

Pour un panorama d'outils, séparer explicitement les deux questions dès le départ : la cible de scan (source, image, binaire, runtime, réseau) et le statut (open source ou commercial). FND-006 le fait maintenant via la taxonomie de la section 5, ce qui aurait évité l'angle mort.

## Definition of Done

- [x] Expliqué pourquoi SCANOSS et consorts manquaient.
- [x] FND-006 ajusté (panorama, tableau, note de transparence, sources).
