# Argumentaire et récit de la présentation

> **Document de travail pour l'équipe de préparation (noumanity&co).** Il fixe la thèse, la tactique de communication et le fil narratif que la présentation doit supporter. Il se lit avec le plan ([03](03-plan-10-diapos.md)) et le verbatim ([04](04-verbatim-par-diapo.md)) ; le plan de communication (objectifs et stratégie) est dans [01](01-plan-de-communication.md). Sources factuelles : [FND-008](../fondations/FND-008-usages-de-linux.md), [FND-009](../fondations/FND-009-pqc-par-categorie-dimages.md), [FND-010](../fondations/FND-010-risque-quantique-notion-et-prise-en-charge.md), [FND-011](../fondations/FND-011-pqc-soixante-images-par-categorie.md), [FND-006](../fondations/FND-006-outils-cbom-scan-panorama-comparaison.md).

## 1. La thèse (une phrase)

**Le « risque quantique » n'est qu'un déclencheur : le vrai sujet, c'est la gestion de la cryptographie dans l'infrastructure Linux qui fait tourner le monde, et c'est un travail d'ingénierie que l'on sait faire.**

Le quantique ouvre la porte ; Linux et la pratique de cybersécurité occupent la pièce.

## 2. La tactique de communication

Trois ressorts agissent ensemble du début à la fin.

### 2.1 Le leitmotiv : « Qu'arriverait-il si on n'agissait pas ? »

C'est le coeur de la stratégie de passage à l'action. On pose cette question de façon récurrente, en l'**adaptant à chaque sujet** de la présentation (l'inaction face au risque, face à l'infrastructure non entretenue, face à une feuille de route inconnue, face à une cryptographie non inventoriée). Et **chaque fois**, on enchaîne aussitôt avec : « voici comment s'en occuper, et c'est faisable ». L'effet visé est un **appel à l'action implicite** : le participant se dit « ce n'est pas si facile pour moi, mais ces gens-là savent quoi faire et pour eux c'est facile ; je contacte noumanity&co ». On ne vend jamais directement ; on installe ce réflexe par répétition.

### 2.2 La progression : recadrer, responsabiliser, outiller

Le récit avance en trois mouvements. **Recadrer** : déplacer l'attention du quantique vers la gestion de la cryptographie dans Linux. **Responsabiliser** : installer l'urgence juste, en évitant les deux pièges du déni et du battage médiatique, et en montrant que le monde a déjà agi. **Outiller** : mettre une compétence concrète et réutilisable entre les mains de l'audience.

### 2.3 La posture : expert de référence

Le ton porte la crédibilité autant que le contenu : **calme, concret, compétent**, avec une pointe de malice. On ne cherche pas à impressionner par la complexité ; on rassure par la maîtrise. C'est cette posture, répétée, qui construit la perception « référence PQC ».

## 3. Le what matters (ce que l'audience doit retenir)

1. **Recadrer** : le quantique n'est pas le sujet ; le sujet est la gestion du risque cryptographique et la chaîne d'approvisionnement logiciel. Le premier pas est de vérifier ce qu'on a.
2. **Responsabiliser sans dramatiser** : il y a un double risque, négliger l'enjeu ou se laisser paralyser par le battage ; or l'enjeu est déjà pris en charge par la communauté internationale et par les autorités canadiennes. La seule question est « et vous, en êtes-vous ? ».
3. **Outiller** : Linux est une infrastructure stratégique ; sa posture PQC se ramène à un petit nombre de briques et à un flux upstream vers downstream lisible ; et on peut vérifier soi-même son état (CBOM).

Effet visé sur l'audience prioritaire (décideurs) : « le PQC est un axe de gestion du risque que mes équipes peuvent prendre en charge, et ces gens savent l'outiller ».

## 4. Le récit en cinq actes

### Acte 1 : le renversement (diapos 1 et 2)

On ouvre comme une conférence quantique intimidante (théorème de Shor, Qiskit, ordinateur quantique d'IBM à Bromont), puis chute : rien de quantique ici. On révèle un vrai plan, volontairement ordinaire pour une présentation de cybersécurité. Fonction : désamorcer l'intimidation, créer la complicité, planter la thèse (le mot quantique est un appât ; le sujet est Linux et la cybersécurité).

### Acte 2 : repenser la menace comme un risque (diapo 3)

On dédramatise en recadrant sur la gestion du risque. De quoi parle-t-on ? De ceci : si la cryptographie à clé publique tombe, on fait quoi ? Le sujet crée un malaise profond parce qu'il touche au socle de la cybersécurité. D'où un double risque : le négliger (déni, peur, non-priorité) ou se laisser submerger par le battage (qui masque l'enjeu réel). Le risque quantique est un déclencheur ; l'enjeu réel est la gestion de la cryptographie, et le danger immédiat est l'inaction, parce que le « Harvest Now, Decrypt Later » rend l'exposition présente. Première déclinaison du leitmotiv : qu'arriverait-il si on n'agissait pas du tout ? Message décideurs : prendre en charge le PQC est un impératif urgent de gestion du risque, qui impose de vérifier sa chaîne d'approvisionnement logiciel.

### Acte 3 : c'est déjà pris en charge, et vous ? (diapo 4)

On passe du « tell » au « show ». La communauté internationale a agi : standards PQC du NIST (ML-KEM, ML-DSA, SLH-DSA), équivalents européens (BSI, ANSSI, ETSI), déclaration du G7. Les autorités canadiennes ont agi : le Centre canadien pour la cybersécurité a publié une feuille de route de migration (ITSM.40.001) assortie d'obligations contraignantes pour les systèmes du gouvernement, et un guide aux organisations (ITSAP.00.017). Déclinaison du leitmotiv portée à la salle : qu'arriverait-il si on était les seuls à ne pas agir ? Puis : voici comment les autres s'y prennent, c'est cadré. Message décideurs : cet enjeu est-il couvert par vos processus de cybersécurité, vos veilles stratégiques ?

### Acte 4 : le coeur, Linux comme infrastructure stratégique (diapos 5 à 8)

C'est le centre de gravité. Quatre temps, et le leitmotiv décliné à chacun.

- **Linux est une infrastructure stratégique** (diapo 5) : marginal sur le bureau, dominant ou hégémonique partout ailleurs. Pour un décideur, Linux n'est pas « un noyau », c'est un socle irremplaçable qu'il faut entretenir, donc financer. Le rôle et l'implémentation de la cryptographie dépendent de la catégorie d'usage. Leitmotiv : qu'arriverait-il si on laissait ce socle sans entretien ?
- **Un flux lisible** (diapo 6) : malgré la diversité des distributions, il n'y a qu'un petit nombre de briques logicielles, et la mise en production des améliorations suit un flux upstream vers downstream déterminé par la feuille de route de l'éditeur et le modèle de publication. Leitmotiv : qu'arriverait-il si vos équipes ignoraient la feuille de route PQC de vos distributions ? Et la réponse facile : une journée de formation suffit à prendre en charge l'essentiel du risque opérationnel et à le remonter à l'équipe cyber.
- **Les briques en détail** (diapo 7) : le contenu le plus technique pour l'audience Linux : quelle version de chaque brique introduit le PQC, ce qu'elle livre, et la suite de sa feuille de route. Le « voici comment, c'est déjà là » prend ici tout son sens (OpenSSL 3.5, OpenSSH 10).
- **La carte de maturité** (diapo 8) : qui mène, qui suit, qui est à la traîne, et pourquoi. Leitmotiv : qu'arriverait-il si vous misiez sur une distribution à la traîne sans le savoir ?

### Acte 5 : la démo et l'appel (diapo 9 et conclusion)

La présentation se termine par une démonstration, préparée à part. Récit : nous allons vous montrer comment vérifier le PQC, et vous saurez le faire vous-mêmes en rentrant. C'est l'aboutissement du leitmotiv : qu'arriverait-il si vous ne saviez même pas où se trouve votre cryptographie ? Voici comment le vérifier, et c'est à votre portée. On donne une compétence réutilisable (l'inventaire cryptographique, le CBOM). Message décideurs : nous livrons de la valeur directement applicable dans votre entreprise. L'appel reste implicite, porté par la répétition du leitmotiv : pour vous c'est du travail, pour nous c'est le métier ; parlons-nous.

## 5. Ce que le récit écarte volontairement

Pour garder Linux au premier plan et tenir le format, on n'expose pas : la démonstration du théorème de Shor, le détail mathématique des algorithmes, le panorama de la recherche quantique canadienne (seules les actions réglementaires canadiennes restent, en diapo 4), la classification des données, et la cryptographie quantique (QKD). Ces éléments restent en réserve dans les fondations pour le matériel de suivi.
