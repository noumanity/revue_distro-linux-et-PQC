# Tâche 4 : choix de la démonstration

> **Objet / Résumé** : propose trois possibilités de démonstration pour la fin de la présentation, et les décrit. Toutes respectent les contraintes du ticket (environ 10 minutes, simple, maximum deux cas, au niveau de la présentatrice Ikram sur poste Windows avec Docker, résonance possible avec la conférence KeePass). S'appuie sur [FND-006](../../fondations/FND-006-outils-cbom-scan-panorama-comparaison.md) (panorama des outils), l'artefact [03-utiliser-cbomkit](03-utiliser-cbomkit.md) et le matériel déjà présent dans `demo/`.

## 1. Contraintes et rappel de la promesse

Promesse faite (README) : « une présentation technique portant sur la **vérification de l'intégration de la Cryptographie Post-Quantique (PQC) sur les images et les conteneurs Linux** ». Contraintes : environ 10 minutes ; simple ; **deux cas maximum** ; au niveau d'une étudiante en génie logiciel ; **Windows plus Docker** ; si possible une **résonance avec KeePass** (gestion des mots de passe).

## 2. La tension à trancher : inventaire (CBOM statique) ou vérification (dynamique)

Le ticket insiste sur la **production d'un CBOM** (un inventaire cryptographique statique : ce qui est présent dans une image). La promesse parle de **vérifier l'intégration de la PQC** (montrer que le post-quantique fonctionne vraiment). Ce ne sont pas tout à fait la même chose : un CBOM révèle le **matériel et les bibliothèques** présents, mais pas toujours l'**usage réel** des algorithmes (limite documentée en FND-006 sections 8 et 10) ; une vérification dynamique (une poignée de main TLS) montre l'algorithme **à l'oeuvre**, mais ne produit pas d'inventaire. Les trois options ci-dessous se placent à des points différents de ce spectre ; le choix dépend de ce qu'on veut faire ressentir au public.

## 3. Les trois options

### Option A : la vérification vivante (poignée de main PQC en direct)

- **Approche** : vérification **dynamique**, sans CBOM. On observe une vraie connexion TLS et on y cherche l'algorithme post-quantique (ML-KEM).
- **Les deux cas** :
  - **Cas 1 (PQC active)** : dans un conteneur Red Hat UBI 10 (OpenSSL 3.5 plus crypto-policies), `openssl s_client` vers un serveur compatible PQC (par exemple Cloudflare), puis `grep` de ML-KEM. On montre la bascule : **avant** activation des crypto-policies, pas de ML-KEM ; **après** `update-crypto-policies`, ML-KEM apparaît dans la poignée de main. Matériel déjà éprouvé dans [03-utiliser-cbomkit](03-utiliser-cbomkit.md).
  - **Cas 2 (contraste)** : une image plus ancienne ou minimale (par exemple Ubuntu 24.04 ou Alpine sans OpenSSL 3.5), où la poignée de main ne contient **pas** de ML-KEM.
- **Ce qu'on montre** : le post-quantique **en action**, et le fait que l'activer peut tenir à une politique système.
- **Résonance KeePass** : « vos outils protègent vos secrets par TLS ; cette poignée de main est-elle déjà quantique ? Regardons-la en direct. »
- **Niveau et plateforme** : très accessible, commandes à copier-coller, tourne en Docker sur Windows.
- **Forces** : visuel et concret ; montre l'**usage réel** (dépasse la limite source contre binaire) ; colle parfaitement au mot « vérification ».
- **Risques** : dépend d'un **accès réseau** et d'un serveur PQC joignable le soir même (prévoir une capture de secours).

### Option B : le CBOM par scan d'image (cbomkit-theia)

- **Approche** : scan **statique** d'image, production d'un **CBOM** CycloneDX. C'est le coeur historique du ticket.
- **Les deux cas** :
  - **Cas 1 (image riche)** : Keycloak (déjà scanné, résultats dans `demo/results/`) : on génère le SBOM avec Trivy, puis le CBOM avec `cbomkit-theia`, et on **lit** le CBOM (certificats, keystores, algorithmes).
  - **Cas 2 (contraste minimal)** : une image Alpine : CBOM minuscule, pour montrer la différence de surface cryptographique.
- **Ce qu'on montre** : à quoi ressemble un CBOM, et comment l'**interpréter** (questions 6 et 7 du ticket).
- **Résonance KeePass** : « on ne migre pas ce qu'on ne voit pas ; voici l'inventaire de la crypto d'une image, comme un coffre-fort dont on listerait les serrures. »
- **Niveau et plateforme** : moyen ; deux outils (Trivy puis cbomkit-theia), JSON à lire ; tourne en Docker sur Windows.
- **Forces** : remplit littéralement la promesse « produire un CBOM » ; réutilise le matériel déjà préparé.
- **Risques** : le JSON est **moins spectaculaire** qu'une démo vivante ; cbomkit-theia échoue sur les grosses images (références circulaires : python, debian) et donne peu sur les images minimales ; bien rappeler la limite (présence n'est pas usage).

### Option C : de l'inventaire à la preuve (hybride, recommandée si le temps de répétition le permet)

- **Approche** : raconter l'histoire de la présentation en deux temps, **un cas par approche**.
- **Les deux cas** :
  - **Cas 1 (inventaire)** : un CBOM rapide sur une image (cbomkit-theia) : « l'inventaire dit qu'OpenSSL 3.5 est là ».
  - **Cas 2 (preuve)** : on le **vérifie en direct** par la poignée de main `openssl s_client` avec ML-KEM : « l'inventaire le dit, prouvons que ça marche vraiment ».
- **Ce qu'on montre** : la séquence **inventorier puis vérifier**, qui est exactement le message de la présentation (on commence par voir, ensuite on agit).
- **Résonance KeePass** : même fil que A et B réunis.
- **Niveau et plateforme** : plus exigeant (deux approches en dix minutes), à **scripter** et répéter ; Docker sur Windows.
- **Forces** : satisfait **à la fois** le CBOM (ticket) et la vérification PQC (promesse) ; pédagogie la plus forte.
- **Risques** : le plus à orchestrer en dix minutes ; demande la meilleure préparation.

### Option D : le clin d'oeil KeePass (ajoutée à la tâche 5)

- **Approche** : un exemple sur KeePass, en clin d'oeil aux autres présentations de la soirée. On vérifie la posture cryptographique d'un coffre et on casse un mythe (le coffre, symétrique, est déjà résistant au quantique ; le vrai levier est le KDF et le mot de passe maître).
- **En bref** : pas de CBOM ici ; tourne nativement sous Windows avec KeePassXC (sans Docker), donc l'option la plus accessible ; se marie bien comme court segment accolé à A, B ou C.
- **Détail complet** : voir [05-option-d-keepass](05-option-d-keepass.md) (réponses à « PQC par défaut et comment vérifier », « keepass-pqc, configuration et migration », et déroulé de démo).

## 4. Résonance avec les autres présentations (KeePass et BitWarden)

Trois conférences de la soirée portent sur la protection des secrets (KeePass, BitWarden). Un fil d'accroche réutilisable quelle que soit l'option : un gestionnaire comme KeePass chiffre votre base avec de l'**AES-256** (symétrique), qui **résiste** au quantique (Grover ne fait que diviser la sécurité par deux). Le danger n'est donc pas là, mais dans l'**asymétrique** (l'échange de clés et les signatures, cassés par Shor) : exactement ce que TLS utilise, et ce que notre démo va vérifier. Cela relie la démo aux autres exposés et renforce le message clé de la présentation (Shor casse l'asymétrique, Grover ne fait qu'affaiblir le symétrique).

## 5. Recommandation

- **Premier choix : Option A (vérification vivante)**. C'est la plus **robuste pour une présentatrice étudiante** (commandes simples, effet visuel fort), elle colle au mot « vérification », montre l'usage réel, et résonne directement avec KeePass. Prévoir une **capture vidéo de secours** contre l'aléa réseau.
- **Si le temps de répétition le permet : Option C (hybride)**, plus riche et fidèle à la fois au ticket (CBOM) et à la promesse.
- **Option B** si l'on tient à montrer **l'artefact CBOM** lui-même (le livrable du ticket) ; à compléter alors d'un mot sur ses limites.

## 6. Points communs à préparer (quelle que soit l'option)

- **Scripter** la démo dans `demo/` (commandes prêtes, copier-coller), avec un `README` de déroulé pas à pas au niveau de la présentatrice.
- **Épingler les versions** (image UBI, OpenSSL, cbomkit-theia, Trivy, CycloneDX) pour éviter toute surprise (le standard et les outils bougent, FND-006 section 8).
- **Plan B hors-ligne** : capture vidéo ou sorties pré-générées (déjà partiellement présentes dans `demo/results/`) en cas d'absence de réseau au Paccini.
- **Tenir les dix minutes** : chronométrer ; deux cas maximum ; couper le superflu.
- **Honnêteté** : énoncer la limite d'un scan d'image (présence n'est pas usage) si l'on montre un CBOM.
- **Lien** : pointer vers le dépôt de démo en fin de présentation pour que le public refasse l'exercice (compétence repartable, cohérent avec la diapo 9 du plan).

## Definition of Done

- [x] Trois possibilités de démonstration proposées et décrites, conformes aux contraintes.
- [x] Tension CBOM statique contre vérification dynamique explicitée.
- [x] Résonance avec KeePass proposée ; adéquation au niveau de la présentatrice et à Windows plus Docker vérifiée.
- [x] Recommandation et points communs de préparation fournis.
