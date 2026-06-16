# Tâche 5 : Option D de démonstration, KeePass

> **Objet / Résumé** : ajoute une quatrième option de démonstration (un exemple sur KeePass), en clin d'oeil aux autres présentations de la soirée (KeePass et BitWarden). Complète l'artefact [04-choix-de-la-demonstration](04-choix-de-la-demonstration.md). Répond aux deux questions du ticket : KeePass est-il PQC par défaut et comment le vérifier ? Un keepass-pqc est-il possible (configuration et migration) ? La réponse courte est contre-intuitive et constitue justement un excellent ressort pédagogique.

## 1. La réponse courte (et le piège à éviter)

Le coffre de KeePass est chiffré avec de la cryptographie **symétrique** (AES-256 ou ChaCha20), une dérivation de clé (Argon2) et un hachage (SHA-256). Or la cryptographie symétrique et les hachages ne sont **pas cassés par l'algorithme de Shor** : ils sont seulement **affaiblis par Grover**, qui ne fait que diviser la sécurité effective par deux, ce qui laisse **AES-256 à environ 128 bits, donc sûr**. Conclusion : **le coffre de KeePass est déjà, de fait, résistant au quantique**, et il n'y a aucun algorithme **asymétrique** vulnérable à remplacer dedans.

Le piège à éviter : on lit parfois que « AES, ChaCha20, Argon2 ne sont pas post-quantiques ». C'est une confusion. Le post-quantique (PQC, à base de réseaux euclidiens) **remplace l'asymétrique** (RSA, courbes elliptiques) cassé par Shor. Il ne s'applique tout simplement pas au chiffrement symétrique d'un coffre local, qui se défend en **doublant les tailles de clés**, pas en changeant de famille d'algorithmes. C'est exactement la distinction Shor contre Grover de la présentation : ce cas KeePass la **renforce**.

## 2. Ce que chiffre KeePass, exactement

- **Chiffrement du coffre (outer cipher)** : AES-256-CBC par défaut, ou ChaCha20, ou Twofish (KDBX 4). Symétrique.
- **Dérivation de la clé maître (KDF)** : Argon2d ou Argon2id (KDBX 4, recommandé, mémoire-dur), ou l'ancien AES-KDF (KDBX 3.1). Le KDF ralentit et durcit la dérivation depuis le mot de passe maître.
- **Protection des champs sensibles (inner stream)** : ChaCha20 (a remplacé Salsa20).
- **Intégrité** : HMAC-SHA-256 (authentifie les données et l'en-tête en KDBX 4, empêchant le downgrade des paramètres).

Tout cela est **symétrique ou du hachage**. Aucun RSA ni courbe elliptique n'intervient dans le chiffrement du coffre. Donc rien que Shor puisse casser.

## 3. KeePass est-il PQC par défaut, et comment le vérifier

La question est en partie un faux problème : il n'y a pas de PQC à mettre dans le coffre, puisqu'il n'y a pas d'asymétrique vulnérable. Mais on peut **vérifier la posture** du coffre, ce qui est le vrai sujet utile.

- **En interface (KeePassXC)** : Base de données, puis Paramètres de la base, puis Sécurité : on y voit le **chiffrement** (AES-256 ou ChaCha20) et la **fonction de dérivation** (Argon2 ou AES-KDF). En KeePass 2 (Windows) : Fichier, puis Paramètres de la base, puis Sécurité.
- **En ligne de commande (vérification)** : `keepassxc-cli db-info chemin/vers/base.kdbx` affiche la version du format (KDBX 3.1 ou 4), le chiffrement et le KDF. C'est la commande de vérification idéale pour une démo (lisible, rapide).
- **Ce qu'on cherche** : un coffre sain est en **KDBX 4**, chiffré en **AES-256** ou **ChaCha20**, dérivé par **Argon2id**, avec un **mot de passe maître fort**. Un coffre ancien (KDBX 3.1, AES-KDF) est le candidat à durcir.

## 4. Un keepass-pqc, et le script de migration

Un keepass-pqc au sens « algorithmes à base de réseaux » n'a **pas de sens pour le coffre** : il n'y a rien d'asymétrique à y migrer. La **vraie migration** qui compte est un durcissement, et elle est simple.

Procédure (migration KDBX 3.1 vers KDBX 4 durci) :

1. **Vérifier l'état actuel** : `keepassxc-cli db-info base.kdbx` (note la version, le chiffrement, le KDF).
2. **Durcir en interface (KeePassXC)** : Base de données, Paramètres de la base, Sécurité : passer le **KDF à Argon2id**, le **chiffrement à AES-256 ou ChaCha20**, et régler le **temps de déchiffrement** (bouton de test, viser environ 1 seconde). Enregistrer : la base est réécrite en **KDBX 4**.
3. **Renforcer le mot de passe maître** : c'est ici le seul vrai levier face au quantique. Grover accélère la **force brute** du mot de passe maître (gain quadratique), donc une **phrase de passe à haute entropie** plus Argon2 (mémoire-dur) est la défense. Un mot de passe faible reste faible, quantique ou pas.
4. **Re-vérifier** : `keepassxc-cli db-info base.kdbx` confirme KDBX 4, AES-256 ou ChaCha20, Argon2id.

Note sur l'automatisation : la réécriture des paramètres (KDF, chiffrement) se fait de façon fiable en interface ; l'édition complète de ces paramètres en ligne de commande dépend de la version de `keepassxc-cli` installée (à confirmer sur la version de la démo). Pour une démonstration au niveau de la présentatrice, l'interface est le chemin sûr, avec `db-info` pour vérifier avant et après.

Les **vrais points où le post-quantique concerne l'écosystème KeePass** ne sont pas le coffre, mais : (a) la **synchronisation** du fichier `.kdbx` à travers le réseau (le transport TLS, qui lui utilise de l'asymétrique vulnérable à Shor), et (b) la **signature des mises à jour** du logiciel et des greffons (chaîne d'approvisionnement). Ces deux points relèvent de TLS et des signatures, exactement les primitives que la présentation traite.

## 5. Option D comme démonstration

- **Concept** : casser un mythe en direct. « Votre KeePass est-il quantum-safe ? » On inspecte un coffre, on montre que son chiffrement symétrique l'est déjà, et que le vrai point d'attention est le KDF et le mot de passe maître.
- **Les deux cas** :
  - **Cas 1 (coffre ancien)** : une base **KDBX 3.1 / AES-KDF** : `db-info` révèle l'ancien KDF ; message : « le risque ici n'est pas le quantique, c'est la force brute ».
  - **Cas 2 (coffre durci)** : la même base migrée en **KDBX 4 / AES-256 / Argon2id** : `db-info` le confirme ; message : « coffre symétrique déjà résistant au quantique, dérivation durcie, mot de passe fort ».
- **Déroulé (environ 10 minutes)** : vérifier le cas 1, expliquer Shor contre Grover en une phrase, migrer en interface, re-vérifier (cas 2), conclure sur les vrais points PQC (transport et signatures).
- **Plateforme** : **KeePassXC tourne nativement sur Windows**, sans Docker : c'est l'option la plus simple pour la présentatrice.
- **Résonance** : clin d'oeil direct à la conférence KeePass (cycle de vie des mots de passe) et à celle sur BitWarden ; le « cycle de vie » inclut justement la migration du format et du KDF.
- **Forces** : très accessible ; renforce le message clé de la présentation (symétrique survit, asymétrique tombe) ; corrige une idée fausse répandue ; pas de dépendance réseau pour le coeur de la démo.
- **Risques** : aucun inventaire CBOM ici (ce n'est pas le sujet de cette option) ; veiller à ne pas laisser croire que « KeePass n'est pas sûr » (au contraire) ; bien formuler la nuance.

## 6. Recommandation d'usage

L'Option D est la plus **accessible** (KeePassXC sur Windows, sans Docker) et la plus **résonante** avec la soirée. Elle ne produit pas de CBOM ; elle se marie donc bien comme **court segment d'ouverture ou de clôture** accolé à l'une des options A, B ou C (par exemple Option A pour la vérification PQC sur image, plus un clin d'oeil KeePass de deux minutes). Présentée seule, elle tient les dix minutes et délivre un message net.

## Definition of Done

- [x] Quatrième option de démonstration (KeePass) proposée et décrite, en complément de [04](04-choix-de-la-demonstration.md).
- [x] Question « PQC par défaut et comment vérifier » traitée (crypto symétrique, vérification en interface et par `keepassxc-cli db-info`).
- [x] Question « keepass-pqc, configuration et migration » traitée (la vraie migration : KDBX 4, Argon2id, AES-256, mot de passe fort ; nuances transport et signatures).
- [x] Faits vérifiés et sourcés ; nuance Shor contre Grover formulée correctement ; markdown strict.

## Sources

- Chiffrement de KeePass (AES-256, ChaCha20, Twofish ; Argon2 contre AES-KDF ; HMAC-SHA-256) : [PanicVault, How KeePass Encryption Works](https://www.panicvault.org/keepass/encryption-explained/), [Almost Secure, Documenting KeePass KDBX4](https://palant.info/2023/03/29/documenting-keepass-kdbx4-file-format/).
- Migration KDBX 3.1 vers 4 et durcissement (Argon2d, ChaCha20, en interface) : [gHacks, Improve KeePass security](https://www.ghacks.net/2023/02/05/improve-keepass-security-with-this-simple-configuration-change/), [PanicVault, KDBX Compatibility Guide](https://www.panicvault.org/keepass/compatibility-guide/).
- Distinction Shor contre Grover et résistance de l'AES-256 : voir [FND-001](../../fondations/FND-001-recherche-preliminaire-pqc-distributions-linux.md) et [FND-010](../../fondations/FND-010-risque-quantique-notion-et-prise-en-charge.md).
