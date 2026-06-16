# Premier jet — Matériel de promotion

> Mis à jour pour tenir compte des précisions sur la conférence (tâche 2) :
> 30 min avec démonstration, audience large (amateurs → professionnels),
> ton amical et accessible mais techniquement irréprochable, et ajout d'un volet
> sur les distributions spécialisées pour les images de conteneurs.

## Informations du présentateur

<img src="https://media.licdn.com/dms/image/v2/D4E03AQECsDfKLjHphg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1712225837200?e=1782950400&v=beta&t=YW_dbRFkgpeTGhZYMHMlKhkclFSSRMd6_NBYvgomqd0" alt="Jérémy Viau-Trudel" width="200" />

- **Nom** : Jérémy Viau-Trudel
- **LinkedIn** : https://www.linkedin.com/in/jvtrudel/
- **GitHub** : https://github.com/jvtrudel
- **Localisation** : Québec, QC
- **Photo (URL)** : https://media.licdn.com/dms/image/v2/D4E03AQECsDfKLjHphg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1712225837200?e=1782950400&v=beta&t=YW_dbRFkgpeTGhZYMHMlKhkclFSSRMd6_NBYvgomqd0

## Biographie

> Réécrite à partir du CV long (mars 2026) pour corriger les inexactitudes du premier jet.

**Version longue (~130 mots)**

Jérémy Viau-Trudel a une trajectoire peu commune : il vient de la **chimie quantique**.
Pendant ses études supérieures à l'Université Laval (et à l'Université Paris-Sud), il a
mené des recherches de haut niveau sur la **simulation de la dynamique électronique de
molécules soumises à des champs laser intenses** — des calculs si lourds qu'ils
tournaient sur des super-calculateurs. C'est là, par nécessité, qu'il a commencé à
utiliser Linux.

Depuis une dizaine d'années, il est **consultant TI spécialisé en Linux**, intervenu à
de multiples reprises en **DevSecOps** — aussi bien sur des infrastructures *on-premise*
qu'en *infonuagique* (Azure, GCP) et en *edge computing* (déploiement de flottes de
milliers d'appareils répartis sur trois pays).

Depuis cinq ans, il développe **Noumanity**, son studio *DeepTech* où il s'attaque à des
sujets techniques complexes — comme celui d'aujourd'hui.

**Version courte (~50 mots, bio d'événement)**

Issu de la recherche en **chimie quantique** (où il a découvert Linux sur
super-calculateurs), Jérémy Viau-Trudel est depuis dix ans **consultant TI spécialisé en
Linux et DevSecOps**, du *on-premise* à l'infonuagique et l'*edge computing*. Il dirige
depuis cinq ans **Noumanity**, son studio *DeepTech*. La combinaison idéale pour parler
du « risque quantique » sans le *hype*.

**Éléments pertinents pour la présentation**

- 🔬 **Crédibilité quantique authentique** : recherche universitaire en chimie/physique
  quantique (dynamique électronique en champ laser intense, Université Laval / Paris-Sud)
  → il peut expliquer *pourquoi* un ordinateur quantique menace RSA/ECC, sans
  approximation.
- 🐧 **Linux « depuis la source »** : il a adopté Linux pour le calcul scientifique sur
  super-calculateurs, bien avant d'en faire son métier → légitimité sur le terrain des
  distributions.
- 🔐 **10 ans de consultation TI / DevSecOps** : *on-premise*, infonuagique (Azure, GCP)
  et *edge computing* → l'angle « modernisation des infrastructures cryptographiques »,
  concret et rassurant.
- 🚀 **Studio DeepTech (Noumanity, 5 ans)** : habitué à vulgariser et à creuser des sujets
  techniques pointus.
- 📍 **Local** : basé à Québec, pertinent pour la communauté hôte de l'événement.

## Format de la conférence

- **Durée** : 30 minutes, incluant une partie démonstration
- **Audience** : communauté Linux de Québec (présentiel) et de toute la province
  (en ligne) — niveaux amateurs à professionnels
- **Ton** : amical et accessible, mais rigoureux sur tout le contenu technique
- **Objectifs de communication** :
  1. **Informer** — expliquer ce qu'est la « menace quantique »
  2. **Prouver** — montrer que c'est réel et pris au sérieux par les éditeurs de distributions
  3. **Rassurer** — ce n'est qu'un chantier de modernisation des infrastructures cryptographiques
  4. **Appel à l'action** — contactez-moi pour en discuter

## Titre

**Option A (retenue par défaut)**
> Pas de panique quantique : comment les distributions Linux modernisent leur cryptographie

**Variantes**
- *Le « risque quantique » et Linux : de la menace à la feuille de route, du poste de travail au conteneur*
- *Récolter maintenant, déchiffrer plus tard : où en est vraiment la migration post-quantique sous Linux ?*

## Abstract

**Option A (~140 mots)**

« Les ordinateurs quantiques vont casser toute la cryptographie ! » On entend la
phrase partout — mais qu'y a-t-il de vrai, et surtout, qu'est-ce que ça change pour
les systèmes Linux que nous utilisons tous les jours ?

En 30 minutes, démonstration à l'appui, nous démystifierons la « menace quantique » :
ce qu'elle est réellement, pourquoi le principe « récolter maintenant, déchiffrer
plus tard » la rend déjà concrète, et comment les éditeurs la prennent au sérieux.
Nous suivrons l'arrivée des standards du NIST (ML-KEM, ML-DSA, SLH-DSA) dans les
feuilles de route de Debian, Ubuntu, Fedora/RHEL, SUSE et Arch, jusqu'aux briques
que vous utilisez déjà : OpenSSL, OpenSSH, GnuTLS. Nous regarderons aussi les
distributions taillées pour les conteneurs (Alpine, Wolfi, distroless, Bottlerocket…).

Bonne nouvelle pour finir : il ne s'agit pas d'une panique, mais d'un chantier de
modernisation déjà bien entamé. Venez voir où en est le vôtre.

**Version courte (~55 mots, pour réseaux sociaux)**

Les ordinateurs quantiques vont-ils vraiment casser votre crypto ? En 30 min, démo
incluse, on démystifie la « menace quantique » et on fait le tour de l'adoption
post-quantique sous Linux : Debian, Fedora, Ubuntu, SUSE, Arch, et les distributions
de conteneurs (Alpine, Wolfi…). Spoiler : pas de panique, mais un vrai chantier.

## Volet « images de conteneurs »

Distributions / écosystèmes minimalistes à couvrir et angles PQC associés :

- **Alpine Linux** — bibliothèque crypto (OpenSSL), base de très nombreuses images
- **Wolfi / Chainguard Images** — chaîne d'approvisionnement, signatures (sigstore/cosign)
- **distroless (Google)** — surface minimale, dépendance aux briques de l'hôte/builder
- **Bottlerocket (AWS)**, **Flatcar** — OS de conteneurs, mises à jour signées
- **Ubuntu Chiseled**, **RHEL UBI micro** — variantes minimales des grandes distributions

Angle transversal : au-delà de TLS, la **signature des artefacts** (paquets, images,
attestations supply-chain) est l'autre grand chantier post-quantique.

## Notes / à valider

- ✅ Public cible : amateurs → professionnels (calibrer le niveau : accessible mais rigoureux)
- ✅ Durée : 30 min, avec démonstration
- ✅ Volet conteneurs ajouté
- ⬜ Idée de **démonstration** à confirmer (p. ex. handshake TLS hybride X25519+ML-KEM
  via OpenSSL 3.5 / `oqs-provider`, ou connexion SSH post-quantique)
- ⬜ Vérifier les contraintes de format des Rencontres Linux du Québec (longueur max
  du titre / de l'abstract, langue, biographie demandée)
- ⬜ Choisir la liste finale des distributions (grandes + conteneurs) à couvrir
- ✅ **Bio réécrite à partir du CV long (mars 2026)** — remplace la version erronée
  basée sur des sources publiques. À confirmer / préciser par Jérémy :
  - formulation « studio DeepTech » pour Noumanity : OK ? (mention aussi possible du
    co-fondateur de l'OBNL en souveraineté numérique)
  - le doctorat est indiqué « non complété » dans le CV → la bio parle de « recherche de
    haut niveau » sans affirmer le titre de docteur (à garder ainsi ?)
  - l'URL de la photo contient un jeton expirant (`e=...`) → prévoir un fichier image
    local dans le dépôt pour un affichage durable
