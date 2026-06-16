# Tâche 2 : préparation de la publication LinkedIn J-1 (16 juin 2026)

> **Objet / Résumé** : propose trois sujets de post LinkedIn pour la veille de la présentation (J-1, le 16 juin, la présentation étant le 17 juin). Tous sont founder-led (voix de Jérémy Viau-Trudel), adressés en direct à la communauté Linux avec un dog whistle pour les décideurs en cybersécurité. Appuyés sur [FND-012](../../fondations/FND-012-cadres-du-plan-de-communication.md) (stratégie), [FND-013](../../fondations/FND-013-campagnes-de-comm-et-canal-linkedin.md) (LinkedIn), les artefacts du plan ([01](../../artefacts/01-plan-de-communication.md) à [04](../../artefacts/04-verbatim-par-diapo.md)), le [README](../../../README.md) (résumé) et la communication déjà publiée ([comm du 15 juin](../../comm/2026-06-15-informatique-quantique.md)).

## 1. Contexte et contraintes

- **Place dans la campagne** : phase « avant », dernier teasing avant le pic (FND-013 section 5). Un post d'annonce existe déjà (15 juin) : il a posé l'événement, les questions de la présentation, et a déjà utilisé l'histoire d'origine (superordinateurs de Laval). Le post J-1 ne doit **pas répéter** l'annonce ; il apporte une **valeur fraîche** et relance l'attention la veille.
- **Stratégie (rappel)** : audience directe = communauté Linux ; **dog whistle** pour décideurs-cyber (un sous-texte de gestion du risque et de conformité qui résonne pour un RSSI sans jamais virer à l'argumentaire de vente, FND-012 section 7.3).
- **Bonnes pratiques LinkedIn (FND-013 sections 7 à 10)** communes aux trois options : voix personnelle (profil de Jérémy, pas la page entreprise) ; contenu natif ; **accroche forte en première ligne** ; texte de 1200 à 1500 caractères pour un post texte (ou carrousel de 8 à 10 diapos) ; **lien d'inscription en commentaire**, pas dans le corps (les liens externes sont pénalisés) ; une **question** en clôture ; répondre vite aux commentaires le soir de publication.

## 2. Les trois sujets proposés

### Option A : « Demain je parle de quantique, et il n'y a rien de quantique »

- **Concept** : reprendre, en avant-première, le renversement qui ouvre la présentation (l'accroche, diapos 1 et 2 de [03](../../artefacts/03-plan-10-diapos.md)). On crée un écart de curiosité (curiosity gap) et on recadre le sujet.
- **Accroche (hook)** : « Demain je donne une conférence sur le quantique. Et je vais l'ouvrir en avouant qu'il n'y a rien de quantique dedans. »
- **Corps (esquisse)** : on dit le mot quantique partout, mais le vrai sujet est la cybersécurité et la gestion du risque cryptographique dans Linux ; pas de panique, pas de physique, du travail d'ingénierie qu'on sait faire ; rendez-vous demain pour le démontrer (et finir par une démo où vous vérifiez vous-mêmes vos systèmes).
- **Dog whistle décideurs** : « ce n'est pas un problème de physiciens, c'est un problème de gestion du risque » : la phrase qui fait dresser l'oreille d'un RSSI.
- **Format** : post texte natif, accroche choc.
- **Pourquoi ça marche** : dramaturgie et écart de curiosité (FND-012 section 6) ; recadrer (le premier mouvement du récit, [02](../../artefacts/02-argumentaire-recit.md)) ; l'intrigue augmente le temps de lecture (FND-013 section 7).

### Option B : « Le calcul de 30 secondes qui dit si vous êtes déjà en retard » (inégalité de Mosca)

- **Concept** : donner un **outil** utilisable immédiatement, l'inégalité de Mosca, en avant-goût du moment fort de la présentation (diapo 4). Valeur d'abord, teasing ensuite.
- **Accroche (hook)** : « Voici un calcul de 30 secondes qui vous dit si votre organisation est déjà en retard face au risque quantique. »
- **Corps (esquisse)** : trois nombres. X, combien d'années vos données doivent rester secrètes. Y, combien d'années pour migrer votre cryptographie. Z, combien d'années avant l'arrivée de l'ordinateur quantique. Si X plus Y dépasse Z, vous êtes déjà en retard (à cause du « récolter maintenant, déchiffrer plus tard »). On en reparle demain, avec ce que ça implique concrètement pour vos distributions Linux.
- **Dog whistle décideurs** : le cadre durée de vie des données plus fenêtre de migration est exactement le langage d'un décideur en cybersécurité ; il s'auto-évalue en silence.
- **Format** : idéalement un **carrousel** de 8 à 10 diapos (un nombre par diapo), format à plus fort temps de lecture et très enregistré (FND-013 section 9) ; sinon un post texte.
- **Pourquoi ça marche** : outiller (le troisième mouvement du récit) ; thought leadership et valeur d'abord (FND-013 section 6, le 73 pour cent d'Edelman) ; les **enregistrements** sont le signal le plus fort, et un outil concret se sauvegarde (FND-013 section 7).

### Option C : « Ce qui m'a le plus surpris en préparant cette présentation »

- **Concept** : une leçon tirée de l'expérience, format le plus engageant pour un dirigeant (FND-013 section 9), sans répéter l'histoire d'origine déjà publiée. Partager un constat technique réel et contre-intuitif issu de la recherche.
- **Accroche (hook)** : « En préparant ma conférence de demain, une chose m'a frappé : derrière des centaines de distributions Linux, tout se joue dans deux logiciels. »
- **Corps (esquisse)** : OpenSSL 3.5 et OpenSSH 10 (sortis en 2025) ont fait basculer presque tout l'écosystème ; une distribution mène même la danse en signant déjà ses paquets en post-quantique (RHEL) ; la posture d'une distro se lit d'abord dans la version de ces briques. La vraie question n'est pas la physique, c'est : savez-vous ce que vos systèmes embarquent ? Réponse demain.
- **Variante** : « le plus grand risque que j'ai trouvé n'est pas le quantique, c'est l'inaction » (enchaîne sur le HNDL).
- **Dog whistle décideurs** : « savez-vous ce que vos systèmes embarquent ? » pointe vers l'inventaire cryptographique et la chaîne d'approvisionnement logiciel, préoccupation directe d'un décideur.
- **Format** : post texte natif, voix personnelle.
- **Pourquoi ça marche** : ethos et leçon d'expérience (FND-013 section 9 ; rhétorique, FND-012 section 5) ; capital symbolique par compétence démontrée authentiquement (FND-012 section 7) ; apporte une vraie information technique qui plaît à la communauté Linux.

## 3. Recommandation

- **Premier choix : Option B (inégalité de Mosca, en carrousel)**. C'est l'option qui donne le plus de **valeur immédiate**, maximise les enregistrements (le signal LinkedIn le plus fort), porte le dog whistle décideurs le plus naturellement, et met en avant le moment fort ajouté à la présentation. Elle illustre concrètement la posture thought leadership.
- **Second choix : Option A (le renversement)**, plus légère à produire (post texte), idéale si le temps manque la veille ; fort potentiel d'écart de curiosité.
- **Option C** est excellente mais recoupe partiellement le registre personnel de l'annonce du 15 juin ; à garder en réserve, ou pour un post de phase « après ».

## 4. Élements communs à finaliser (quelle que soit l'option)

- **Lien d'inscription en commentaire** (le même que l'annonce), pas dans le corps.
- **Appel implicite** seulement : « rendez-vous demain », jamais un argumentaire de vente.
- **Mention des coauteurs** et des organisateurs (André Gerges, Ikram Zahiri ; Martial Bigras et les Rencontres Linux du Québec) pour le capital social et l'amplification.
- **Hashtags** sobres : PQC, Linux, cybersécurité, Québec.
- **Publication en fin d'avant-midi ou début d'après-midi le 16 juin**, et présence active pour répondre aux commentaires.
- **Amplification** : préparer un court texte prêt à personnaliser pour les coéquipiers et alliés (employee advocacy, FND-013 section 10).

## Definition of Done

- [x] Trois sujets de post J-1 proposés, distincts et exploitables.
- [x] Stratégie respectée : communauté Linux en direct, dog whistle décideurs ; voix founder-led.
- [x] Cohérence avec la communication déjà publiée (pas de répétition de l'annonce) et avec FND-012, FND-013 et les artefacts.
- [x] Recommandation et éléments communs de finalisation fournis.
