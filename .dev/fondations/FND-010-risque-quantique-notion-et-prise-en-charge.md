# Le risque quantique : de la notion de risque à sa prise en charge en cybersécurité : recherche

> **Statut** : essai de fondation (tâche 1 du ticket `TKT-008-risque-quantique`).
> **Date** : juin 2026 ; **Objectif** : ouvrir largement la recherche sur le « risque quantique ». D'abord poser la notion générale de risque, puis son traitement dans la pratique de la cybersécurité (l'état de l'art), enfin situer le risque quantique comme un cas particulier de ce cadre. On cherche le « What Matters » et l'état de l'art, pas l'exhaustivité technique.
> **Note de rigueur** : ce document vise un socle réutilisable pour la présentation et les tickets suivants. Chaque affirmation factuelle importante est rattachée à une source (section *Sources*). Les standards et échéanciers cités sont vérifiés à juin 2026 et devront être revalidés à l'approche de l'événement (l'écosystème quantique évolue vite). Cet essai reste volontairement en surface : il cartographie, il ne tranche pas encore ce qui ira dans la présentation (ce sera l'objet des tâches suivantes du ticket).

## 1. Cadrage et thèse

### 1.1 La question

« Qu'est-ce que le risque quantique ? » La question paraît technique (des ordinateurs quantiques cassent de la cryptographie), mais elle est d'abord une question de **gestion du risque**. Un décideur en cybersécurité ne raisonne pas en qubits : il raisonne en actifs, en probabilités, en impacts, en mesures de traitement et en risque résiduel accepté. La thèse de cet essai est donc la suivante : le risque quantique ne se comprend bien que **rapporté au vocabulaire et aux cadres établis de la gestion du risque**. C'est précisément ce cadrage qui le rend lisible (et actionnable) pour notre audience prioritaire, les décideurs en cybersécurité.

### 1.2 Périmètre

Dans le périmètre : la définition normalisée du risque ; la décomposition classique du risque en cybersécurité ; les grands cadres de gestion du risque (NIST, ISO, FAIR) ; les options de traitement du risque ; puis le risque quantique comme instance de ce cadre (nature de la menace, fenêtre d'exposition, échéanciers, pression réglementaire, mesures de traitement).

Hors périmètre : la physique des ordinateurs quantiques ; le détail mathématique des algorithmes post-quantiques ; l'état d'intégration de la cryptographie post-quantique (PQC) dans les distributions Linux (déjà couvert par [FND-001](FND-001-recherche-preliminaire-pqc-distributions-linux.md)) ; la sélection éditoriale de ce qui ira dans la présentation (tâches ultérieures du ticket).

### 1.3 Définitions de travail

- **Risque** : selon l'ISO 31000 et l'ISO Guide 73, « l'effet de l'incertitude sur les objectifs ». L'effet est un écart, positif ou négatif, par rapport à l'attendu. En cybersécurité, on s'intéresse surtout à l'écart négatif (la perte).
- **Menace, vulnérabilité, actif, impact** : briques élémentaires du risque opérationnel (voir §2.2).
- **CRQC** (*Cryptographically Relevant Quantum Computer*) : un ordinateur quantique assez puissant pour casser la cryptographie asymétrique en usage. Il n'en existe pas aujourd'hui (juin 2026).
- **PQC** (*Post-Quantum Cryptography*) : cryptographie conçue pour résister à un CRQC, exécutée sur des ordinateurs classiques.
- **HNDL** (*Harvest Now, Decrypt Later*) : capter aujourd'hui du trafic chiffré pour le déchiffrer plus tard, une fois le CRQC disponible.

## 2. La notion de risque (cadre général)

### 2.1 Une définition normalisée

Le tournant des normes modernes (ISO 31000:2018, vocabulaire ISO Guide 73) est d'avoir cessé de définir le risque comme une simple « probabilité de perte » pour le définir comme **l'effet de l'incertitude sur les objectifs**. Trois conséquences utiles. D'abord, le risque est rattaché à des **objectifs** : pas d'objectif, pas de risque interprétable. Ensuite, il englobe l'**incertitude**, donc l'absence d'information, pas seulement les événements connus. Enfin, il peut être positif (une opportunité) autant que négatif ; en cybersécurité, on se concentre sur le versant négatif.

### 2.2 La décomposition opérationnelle

Pour rendre le risque mesurable, la pratique le décompose. La formulation la plus répandue est **Risque = fonction(probabilité, impact)** : la probabilité qu'un événement défavorable survienne, multipliée (au sens large) par la gravité de ses conséquences. En sécurité de l'information, le standard d'analyse (NIST SP 800-30) raffine cela en **quatre facteurs** : la **menace** (l'agent ou l'événement), la **vulnérabilité** (la faiblesse exploitable), la **probabilité** d'exploitation, et l'**impact** de la perte sur un **actif**. Un risque n'existe que lorsque ces facteurs se rencontrent : une vulnérabilité sans menace, ou une menace sans actif de valeur, ne produit pas de risque significatif.

### 2.3 Risque inhérent, résiduel, appétit et tolérance

Deux notions structurent toute décision de risque. Le **risque inhérent** est le niveau de risque avant toute mesure ; le **risque résiduel** est ce qui subsiste après traitement. Aucune organisation ne ramène le risque à zéro : elle le ramène sous son **appétit pour le risque** (le niveau qu'elle accepte de courir pour atteindre ses objectifs) et sa **tolérance** (l'écart admissible autour de cet appétit). Décider, en sécurité, c'est presque toujours décider **quel risque résiduel on accepte**, et pas « comment tout éliminer ». Ce point est central pour le risque quantique (voir §4.6).

## 3. La prise en charge du risque en cybersécurité (état de l'art)

### 3.1 Un cycle, pas un projet

La gestion du risque est un **cycle continu** et non une action ponctuelle : identifier le contexte et les actifs, **évaluer** (analyser et estimer) les risques, les **traiter**, puis **surveiller** et réviser. Les grands référentiels diffèrent par le vocabulaire et l'accent, mais partagent cette ossature.

### 3.2 Les grands référentiels

- **NIST Risk Management Framework (SP 800-37 Rev. 2, 2018)** : sept étapes (Préparer, Catégoriser, Sélectionner, Implémenter, Évaluer, Autoriser, Surveiller) reliant l'analyse de risque au choix et au suivi des mesures de sécurité, avec une intégration de la vie privée et du risque de chaîne d'approvisionnement.
- **NIST Cybersecurity Framework 2.0 (2024)** : aux cinq fonctions historiques (Identifier, Protéger, Détecter, Répondre, Récupérer) s'ajoute une sixième, **Gouverner** (*Govern*), qui ancre explicitement le risque cyber comme un **risque d'affaires** et couvre la stratégie de risque, les rôles, les politiques et le risque de chaîne d'approvisionnement.
- **ISO/IEC 27005** : la déclinaison « gestion du risque » de la famille ISO 27000 (système de management de la sécurité de l'information), alignée sur le vocabulaire ISO 31000.
- **FAIR (*Factor Analysis of Information Risk*)** : un modèle de **quantification** du risque en termes économiques (probabilité et magnitude des pertes, en dollars), de plus en plus utilisé pour traduire le risque technique en langage de décision et pour prioriser les investissements. Il se combine avec NIST CSF 2.0 plutôt qu'il ne s'y oppose.

Le mouvement de fond commun à ces référentiels récents (CSF 2.0, FAIR) est la **bascule du risque cyber vers le risque d'affaires** : on ne parle plus seulement de vulnérabilités techniques, mais d'exposition financière et de gouvernance. C'est exactement le registre qui parle aux décideurs.

### 3.3 Les quatre options de traitement

Une fois un risque évalué, le cadre de réponse est stable et universel. On peut l'**éviter** (renoncer à l'activité qui le porte), le **réduire / mitiger** (mesures techniques et organisationnelles qui baissent probabilité ou impact), le **transférer / partager** (assurance, sous-traitance, clauses contractuelles), ou l'**accepter** (assumer le risque résiduel en connaissance de cause). La cryptographie est, dans ce cadre, une **mesure de réduction** parmi d'autres : elle protège la confidentialité et l'intégrité, donc baisse l'impact d'une compromission.

### 3.4 Ce que cela implique pour la suite

Trois acquis de cette section servent directement à lire le risque quantique. Premièrement, un risque se juge sur **probabilité et impact**, pas sur la seule existence d'une menace. Deuxièmement, ce qui compte pour un actif est sa **durée de vie de confidentialité** (combien de temps la donnée doit rester secrète). Troisièmement, la décision finale est un **choix de risque résiduel** sous contrainte d'appétit. Le risque quantique se distingue parce qu'il déplace la menace dans le **futur** tout en rendant l'exposition **présente**.

## 4. Application : le risque quantique comme cas particulier

### 4.1 Ce qui est menacé (et ce qui ne l'est pas)

Le risque quantique n'est pas « la fin de toute la cryptographie ». La cryptographie **asymétrique** (RSA, Diffie-Hellman, courbes elliptiques) est **cassée** par un CRQC via l'algorithme de Shor : c'est le coeur du problème (échange de clés TLS, signatures de certificats, clés SSH). La cryptographie **symétrique** (AES) et les **fonctions de hachage** ne sont qu'**affaiblies** par l'algorithme de Grover, dont l'accélération seulement quadratique se compense en doublant les tailles de clés (AES-256 reste sûr). La migration concerne donc essentiellement deux primitives asymétriques : l'**échange de clés** et les **signatures**.

### 4.2 La singularité : une menace future, une exposition présente

La particularité du risque quantique est le découplage temporel. Le CRQC n'existe pas encore, mais la menace **HNDL** rend le risque **actuel** : un adversaire peut capter et stocker aujourd'hui du trafic chiffré pour le déchiffrer une fois le CRQC disponible. Toute donnée à **longue durée de vie de confidentialité** (secrets d'État, dossiers médicaux, propriété intellectuelle, secrets commerciaux) est donc exposée dès maintenant. Cela explique qu'on priorise l'échange de clés (confidentialité, sensible au HNDL) avant les signatures (authenticité, qui n'a de valeur qu'au présent).

### 4.3 L'outil de décision : l'inégalité de Mosca

L'inégalité de Mosca formalise exactement le raisonnement « probabilité et impact dans le temps » de la §2. Avec **X** = nombre d'années pendant lesquelles la donnée doit rester confidentielle, **Y** = nombre d'années nécessaires pour migrer l'infrastructure vers du quantique-sûr, et **Z** = nombre d'années avant l'arrivée d'un CRQC, alors **si X + Y > Z, il est déjà trop tard**. Exemple : une donnée à protéger 10 ans, plus 5 ans de migration, donne une fenêtre d'exposition de 15 ans à comparer à Z. C'est le pont conceptuel entre la gestion du risque classique et le risque quantique : il transforme une incertitude technologique lointaine en une **échéance de décision présente**.

### 4.4 L'échéancier (Z) : ce que disent les experts

Les estimations restent incertaines mais convergent vers « pas demain, mais à portée de planification ». Le *Quantum Threat Timeline Report 2025* du Global Risk Institute (l'enquête d'experts de référence sur le sujet, conduite par Michele Mosca et Marco Piani) situe la probabilité qu'un CRQC émerge **dans les 10 ans entre 28 % et 49 %**, et la juge **probable (51 % à 70 %) dans les 15 ans** : la plus haute estimation à 10 ans en sept ans d'enquête, signe d'une accélération perçue. La plupart des projections placent l'arrivée plausible d'un CRQC dans **les années 2030**.

### 4.5 La pression réglementaire : Z est aussi une date imposée

Pour beaucoup d'organisations, l'échéance pertinente n'est pas l'arrivée physique du CRQC mais la **conformité**. Trois jalons structurent le paysage.

- **Standards NIST publiés (août 2024)** : trois standards finaux, FIPS 203 (**ML-KEM**, encapsulation de clé, ex-CRYSTALS-Kyber), FIPS 204 (**ML-DSA**, signature, ex-CRYSTALS-Dilithium) et FIPS 205 (**SLH-DSA**, signature à base de hachage, ex-SPHINCS+). La PQC est donc **standardisée et disponible**.
- **NIST IR 8547 (transition)** : trajectoire attendue de retrait des algorithmes vulnérables. Les algorithmes à environ 112 bits de sécurité (RSA-2048, ECC P-256) sont **dépréciés vers 2030** et visés pour un **retrait d'ici 2035**.
- **NSA CNSA 2.0** : pour les systèmes de sécurité nationale américains, adoption de la PQC attendue à partir de la fin des années 2020 et bascule complète d'ici 2035.

### 4.6 Le traitement : crypto-agilité et inventaire

Mises bout à bout, les §3 et §4 donnent la posture recommandée. La mesure de réduction de fond n'est pas seulement « installer de la PQC », mais la **crypto-agilité** : la capacité à changer rapidement d'algorithme cryptographique en réponse à une menace, sans refondre les systèmes. Elle se construit sur un préalable : l'**inventaire cryptographique** (savoir où, quoi et comment on chiffre, souvent formalisé en *CBOM*, Cryptography Bill of Materials), faute de quoi la migration est impilotable. Et comme toute la cryptographie n'est pas migrable d'un coup, une part du risque sera **acceptée** transitoirement : on revient au choix de risque résiduel de la §2.3, mais désormais documenté et daté.

## 5. What Matters : ce qui compte pour notre audience prioritaire

Pour un décideur en cybersécurité, l'essentiel tient en cinq points.

1. **Le risque quantique est un risque d'affaires, pas une curiosité de laboratoire.** Il se gère avec les mêmes cadres (NIST, ISO, FAIR) que tout autre risque ; ce qui change, c'est la dimension temporelle.
2. **L'exposition est déjà présente** via HNDL, alors même que la menace (le CRQC) est future. C'est contre-intuitif, et c'est précisément ce qui justifie d'agir maintenant pour les données à longue durée de vie.
3. **L'inégalité de Mosca (X + Y > Z) est l'outil de décision** : elle convertit une incertitude technologique en une échéance concrète, propre à chaque organisation selon la sensibilité et la durée de vie de ses données.
4. **La solution existe et est normalisée** (FIPS 203/204/205, 2024) ; la question n'est plus « si » mais « quand et comment migrer », sous une pression réglementaire datée (dépréciation vers 2030, retrait vers 2035).
5. **La vraie capacité à bâtir est la crypto-agilité**, fondée sur un inventaire cryptographique. C'est un chantier de gouvernance et d'architecture, pas un simple correctif.

Pour la communauté Linux (audience accidentelle mais réelle), le même cadre se décline concrètement : l'écosystème (OpenSSL, OpenSSH, bibliothèques TLS, distributions) intègre progressivement ML-KEM et les signatures PQC, ce qui rend le sujet tangible et démontrable (voir [FND-001](FND-001-recherche-preliminaire-pqc-distributions-linux.md)).

## 6. Synthèse

Le « risque quantique » se définit proprement comme un **risque** au sens de l'ISO 31000 (effet de l'incertitude sur des objectifs), instancié dans le cadre opérationnel de la cybersécurité (menace, vulnérabilité, probabilité, impact ; cycle évaluer-traiter-surveiller ; quatre options de traitement ; choix de risque résiduel). Sa singularité est temporelle : une menace **future** (le CRQC, plausible dans les années 2030, probabilité à 10 ans estimée de 28 % à 49 %) double d'une exposition **présente** (HNDL). L'inégalité de Mosca relie les deux et fournit l'outil de décision. La parade est connue, normalisée (FIPS 203/204/205) et désormais réglementée dans son calendrier (retrait des algorithmes vulnérables visé pour 2035) ; sa mise en oeuvre passe moins par un produit que par une **capacité** (crypto-agilité) bâtie sur un inventaire cryptographique.

## 7. Limites et péremption

- **Surface assumée** : cet essai cartographie large et ne descend pas dans le détail mathématique ni dans la mise en oeuvre. Les choix éditoriaux pour la présentation relèvent des tâches suivantes du ticket.
- **Sources secondaires** sur certains points : plusieurs faits (jalons CNSA 2.0, formulations de Mosca, lecture du rapport GRI) s'appuient sur des synthèses de qualité plutôt que sur le texte primaire intégral ; à reconfirmer sur les documents sources NIST et NSA avant toute affirmation publique chiffrée.
- **Péremption** : les estimations de calendrier (Z) et les jalons réglementaires bougent vite. À revalider à l'approche de l'événement, en particulier le *Quantum Threat Timeline Report* le plus récent et l'état d'avancement de NIST IR 8547.
- **Non couvert** : aspects économiques détaillés (coût de migration), aspects géopolitiques, et cas des signatures à état (XMSS, LMS) volontairement laissés de côté à ce stade.

## 8. Sources

- ISO 31000:2018 et ISO Guide 73 (définition du risque) : [ISO 31000 (Wikipedia)](https://en.wikipedia.org/wiki/ISO_31000), [Risk (Wikipedia)](https://en.wikipedia.org/wiki/Risk).
- NIST SP 800-37 Rev. 2, Risk Management Framework : [NIST.SP.800-37r2 (PDF)](https://csrc.nist.gov/pubs/sp/800/37/r2/fpd), synthèse [Anchore](https://anchore.com/compliance/nist/800-37/).
- Facteurs de risque (menace, vulnérabilité, probabilité, impact), NIST SP 800-30 / 800-39 : [NIST SP 800-39 (PDF)](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-39.pdf).
- NIST Cybersecurity Framework 2.0, fonction Govern : [CSF Tools v2.0](https://csf.tools/reference/nist-cybersecurity-framework/v2-0/), [FAIR Institute sur CSF 2.0](https://www.fairinstitute.org/blog/nist-csf-2-0-cyber-risk-business-risk).
- FAIR (quantification du risque) : [FAIR Institute](https://www.fairinstitute.org/resources/how-to-use-fair-to-mature-your-cyber-risk-management-program-with-nist-csf-2.0).
- Options de traitement du risque (NIST risk response) : [CSRC Glossary, risk response](https://csrc.nist.gov/glossary/term/risk_response).
- Inégalité / théorème de Mosca : [Mosca's Theorem (postquantum.com)](https://postquantum.com/post-quantum/moscas-theorem/).
- Harvest Now, Decrypt Later : [HNDL (Wikipedia)](https://en.wikipedia.org/wiki/Harvest_now,_decrypt_later).
- Standards PQC FIPS 203/204/205 (août 2024) : [NIST news](https://www.nist.gov/news-events/news/2024/08/nist-releases-first-3-finalized-post-quantum-encryption-standards), [Federal Register](https://www.federalregister.gov/documents/2024/08/14/2024-17956/announcing-issuance-of-federal-information-processing-standards-fips-fips-203-module-lattice-based).
- Transition NIST IR 8547 (dépréciation 2030, retrait 2035) : [NIST IR 8547 (PDF)](https://nvlpubs.nist.gov/nistpubs/ir/2024/NIST.IR.8547.ipd.pdf).
- Global Risk Institute, Quantum Threat Timeline Report 2025 (probabilités CRQC, crypto-agilité) : [Global Risk Institute](https://globalriskinstitute.org/publication/quantum-threat-timeline-report-2025b/).
