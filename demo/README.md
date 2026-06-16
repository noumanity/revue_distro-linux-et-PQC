# Demo: PQC sur images linux

Questions de travail:
- comment vérifier pour savoir si on prend en charge le risque crypto et à quel niveau de "maturité"?
- quels critères considérer?
- que regarder?

Définir les types de vérifications possibles:

- test manuel
- scan statiques: code source, iso, image conteneur, ...
- scan dynamique: certificats présents, librairie + config, ports/protocoles ouvert, traffic réseau
- autre?


## Candidat: vérifications "manuelles" (no de version + test de fonctionnalités)

### Cas image redhat/ubi10:latest (10.2)



Le package `crypto-policies-scripts`est installé. Mais pas activé au démarrage par défault.

`openssl` est à la version 3.5.x, mais pas installé.

```sh
### show version
cat /etc/redhat-release

### install openssl
dnf install openssl
openssl -v


### check mlkm connection by default # => nope!
echo | openssl s_client -connect cloudflare.com:443 2>&1 | grep -i "ML-KEM\|mlkem"


### show crypto policy
update-crypto-policies --set DEFAULT # => DEFAULT

### show crypto policy file   # => error file is not present. must be activated
cat /etc/crypto-policies/state/CURRENT.pol | grep -i mlkem

### activate crypto policy
update-crypto-policies --set DEFAULT

### policy file is now present
cat /etc/crypto-policies/state/CURRENT.pol | grep -i mlkem

# now it use mlkem
echo | openssl s_client -connect cloudflare.com:443 2>&1 | grep -i "ML-KEM\|mlkem"

```

## Candidat: scanner des ressources statiques

### CLI cbomkit-theia

Intérêt de ce scanner:

- est un cli
- un des premiers
- Originalement développé par IBM, le créateur du format CBOM

cbomkit est une suite complète d'outils, une véritable plateforme pour gérer vos assets cryptos


#### scanner des images conteneurs

Remarque sur le scan d'images: probablement pas les plus intéressante en raison de leur minimalisme.

```sh
# obtenir et le cli builder cbomkit-theia
git clone git@github.com:cbomkit/cbomkit-theia.git /tmp/cbom-theia
cd /tmp/cbomkit-theia
docker build -t cbomkit-theia .
cd -

# Environnement de travail: dans docker
docker run -it   \
    -v /var/run/docker.sock:/var/run/docker.sock  \
    -v $(pwd):/src \
    -w /src \
     docker:latest sh
```

Dans le conteneur:

```sh
# Génération d'un certiicat PQC avec et sur openquantumsafe/oqs-ossl3
docker build -t with-pqc-cert .

# scan 
docker run --rm cbomkit-theia image with-qpc-cert:latest | tee -a cbom-with-pqc-cert.json

```



#### Cas Scan d'une image

Il faut d'abord produire un SBOM (pour certain plugins. lesquels?)
- on monte le volume local sur /output pour récupérer le fichier
- on monte le répertoire cache localement pour ne pas téléchargé les assets à chaque fois.

```sh
IMAGE=quay.io/keycloak/keycloak:latest

# generate a sbom
docker run --rm \
   -v ${PWD}:/output \
   -v ${PWD}/trivy-cache:/root/.cache/trivy \
   aquasec/trivy image\
        --format cyclonedx \
        --output /output/sbom.json \
        $IMAGE_NAME

# scan with 
docker run --rm \
   -v ${PWD}/sbom.json:/data/sbom.json \
   cbomkit-theia image \
       --bom /data/sbom.json \
       -p certificates,javasecurity,secrets,opensslconf,problematicca \
       $IMAGE_NAME > cbom.json


```

Remarque: limite de l'outil, cet cbomkit-theia est incapable de scanner de grosses images qui contient des références circulaires TMAGE_NAME: python,odoo,debian,...