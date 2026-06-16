# Tâche 3 : comment utiliser CBOMkit (question 5)

Cet artefact répond à la question 5 du ticket (comment utiliser l'outil) pour CBOMkit, en se concentrant sur le composant utile à la démo : cbomkit-theia, qui scanne des images de conteneur et des répertoires. Les informations proviennent de la documentation du dépôt PQCA/cbomkit-theia (voir FND-006, sources 3 et 4) et sont à revalider à l'approche de la présentation.

## 1. Quel composant de CBOMkit pour quel besoin

CBOMkit est une suite. Pour la démo (images au repos), le bon composant est cbomkit-theia.

| Besoin | Composant | Cible |
|---|---|---|
| Scanner une image de conteneur ou un répertoire (notre cas) | cbomkit-theia | image OCI ou Docker, système de fichiers |
| Scanner un dépôt de code source | cbomkit-hyperion (plugin SonarQube) ou le service web CBOMkit | code source (Java, Python) |
| Visualiser un CBOM et ses statistiques | cbomkit-coeus | un CBOM existant |
| Évaluer une politique (par exemple quantum-safe) | cbomkit-themis | un CBOM existant |

La suite n'est pas spécialement faite pour les images ISO. Pour une ISO, on monte ou on extrait son système de fichiers, puis on le scanne avec le sous-commande `dir` (voir section 5).

## 2. Prérequis

- Go version 1.25 ou supérieure (si compilation depuis les sources).
- Docker ou un runtime de conteneur compatible. Définir au besoin la variable `DOCKER_HOST`.

## 3. Installation

Deux options.

Construction de l'image Docker :

```bash
docker build -t cbomkit-theia .
docker run cbomkit-theia [commande] > cbom.json
```

Compilation du binaire :

```bash
go mod download
go build
./cbomkit-theia [commande] > cbom.json
```

## 4. Commandes de base

Structure générale :

```
cbomkit-theia [commande] [arguments] [drapeaux]
```

Sous-commandes principales :

- `dir <chemin>` : analyse les actifs cryptographiques dans un répertoire.
- `image <nom>` : analyse les actifs cryptographiques dans une image de conteneur.
- `help` : affiche l'aide.

Exemples minimaux :

```bash
cbomkit-theia dir mon/repertoire
cbomkit-theia image nginx
```

La sortie est un CBOM au format CycloneDX 1.6, émis sur la sortie standard (stdout). On la redirige donc vers un fichier.

## 5. Cas d'usage de la démo

### 5.1 Image de conteneur (registre ou démon Docker)

```bash
cbomkit-theia image nginx:latest > nginx-cbom.json
```

Sources d'image prises en charge : répertoires, Dockerfiles, images du démon Docker, archives TAR, images OCI, images de registre, images Singularity.

### 5.2 Image Linux ISO

cbomkit-theia ne lit pas une ISO directement. On extrait ou on monte d'abord son système de fichiers, puis on le scanne comme un répertoire :

```bash
# exemple : monter l'ISO en lecture seule, puis scanner le point de montage
sudo mount -o loop,ro image.iso /mnt/iso
cbomkit-theia dir /mnt/iso > iso-cbom.json
sudo umount /mnt/iso
```

Remarque : une ISO contient souvent des paquets compressés (squashfs, archives) ; selon le cas, il faut extraire ces couches avant le scan pour que les certificats, clés et configurations soient visibles. À tester sur une ISO réelle lors d'une tâche ultérieure.

## 6. Drapeaux utiles

| Drapeau | Rôle |
|---|---|
| `-b, --bom <fichier>` | fournir un CBOM existant à vérifier et enrichir |
| `-p, --plugins <liste>` | choisir les plugins (certificates, javasecurity, secrets, opensslconf, keys, vex) |
| `--ignore <motifs>` | ignorer des fichiers (syntaxe glob, par exemple `testdata/,*.tmp`) |
| `--docker-host <socket>` | socket du démon Docker (défaut `unix:///var/run/docker.sock`) |
| `--log-level <niveau>` | verbosité des journaux (défaut info) |
| `--schema <fichier>` | schéma BOM pour validation |

Exemple avec un sous-ensemble de plugins :

```bash
cbomkit-theia image nginx -p certificates -p secrets > nginx-cbom.json
```

## 7. Ce que détectent les plugins par défaut

- certificates : certificats X.509.
- javasecurity : vérifie l'exécutabilité d'actifs cryptographiques en Java.
- secrets : clés privées, publiques et secrets (via gitleaks).
- opensslconf : lit la configuration OpenSSL et en extrait protocoles TLS et suites de chiffrement.

C'est la nuance déjà soulignée dans FND-006 (section 8) : theia voit surtout du matériel cryptographique (certificats, clés, configurations) et la présence de bibliothèques, plus que l'usage effectif des algorithmes dans les binaires.

## 8. Enrichissement d'un CBOM existant

theia peut enrichir un CBOM produit ailleurs (par exemple par hyperion sur le code source), en le passant avec `-b`. Le résultat fusionne les actifs détectés dans l'image avec ceux du CBOM fourni :

```bash
cbomkit-theia image mon-image -b cbom-source.json > cbom-enrichi.json
```

## 9. Limites et points à tester (vers les tâches suivantes)

- Validé sur la documentation, pas encore exécuté sur une image réelle dans ce dépôt : à faire avant la démo.
- Le cas ISO (extraction des couches squashfs) demande un essai concret.
- La version de CycloneDX en sortie (1.6) et les drapeaux exacts sont à reconfirmer avec la version installée le jour de la démo.
- L'interprétation du CBOM produit (questions 6 et 7 du ticket) fera l'objet d'une tâche dédiée.

## Definition of Done

- [x] Question 5 (comment utiliser) traitée pour CBOMkit, centrée sur cbomkit-theia.
- [x] Installation, sous-commandes, drapeaux, plugins et cas image et ISO documentés avec commandes.
- [x] Limites et points à tester listés pour les tâches suivantes.
