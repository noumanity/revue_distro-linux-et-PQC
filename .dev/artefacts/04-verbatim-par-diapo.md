# Verbatim par diapo

> **Document de travail pour l'équipe de préparation (noumanity&co).** Contenu détaillé, sous forme de verbatim oral, pour chaque diapo du [plan](03-plan-10-diapos.md), aligné sur le [récit](02-argumentaire-recit.md). Texte rédigé pour être dit ; indications de scène en italique. Chaque diapo indique une **durée estimée** (débit posé, en français, avec pauses). Le leitmotiv « qu'arriverait-il si on n'agissait pas ? » est décliné de diapo en diapo. Faits à revalider avant l'événement (sources dans les fondations citées).

## Budget de temps

Total visé : environ **20 à 23 minutes**. Diapos 5, 6 et 9 (le coeur et la démo) sont les segments élastiques ; en cas de retard, raccourcir d'abord les tableaux des diapos 6 et 8.

| Diapo | Durée estimée |
|---|---|
| 1. Accroche | 1 min 30 |
| 2. Vrai plan | 1 min 00 |
| 3. Repenser le risque | 2 min 30 |
| 4. Déjà pris en charge | 2 min 30 |
| 5. Linux infrastructure | 3 min 00 |
| 6. Flux upstream | 3 min 00 |
| 7. Briques (technique) | 2 min 30 |
| 8. Carte de maturité | 1 min 30 |
| 9. Démo | 3 min 30 |
| x. Conclusion et appel | 1 min 30 |
| **Total** | **environ 22 min** |

## Diapo 1 : l'accroche (1 min 30)

*(À l'écran : un plan d'apparence très savante. Ton assuré, presque solennel.)*

« Bonjour à tous, merci d'être là. Aujourd'hui, on parle de calcul quantique. Voici le plan. D'abord, je vous démontre le théorème de Shor au tableau. Ensuite, on l'implémente ensemble en Qiskit. Et pour finir, on lance une exécution, gratuitement, sur l'ordinateur quantique d'IBM installé à Bromont, juste à côté. »

*(Pause. On laisse le malaise monter.)*

« ... Non. Je blague. »

*(Les lignes du faux plan se barrent une à une.)*

« Rien de tout ça. Un secret, pour une salle de gens de Linux : dans toute cette présentation, on va dire le mot quantique souvent, mais **il n'y a rien de quantique là-dedans**. Pas de qubit, pas de physique. Ce dont on parle, c'est de cybersécurité, et de Linux. Du travail d'ingénierie que vous connaissez déjà. »

## Diapo 2 : le vrai plan (1 min 00)

*(À l'écran : un plan sobre, presque ennuyeux.)*

« Voici le vrai plan, et je l'ai fait exprès le plus ordinaire possible, parce que c'est ça, mon message. On va repenser une menace, voir que tout le monde a déjà commencé à s'en occuper, puis passer le gros de notre temps dans le concret : où vit la cryptographie dans Linux, comment les améliorations y arrivent, et comment vous pouvez vérifier l'état des choses vous-mêmes. »

« Gardez une idée en tête : le quantique, ici, ce n'est qu'une porte d'entrée. Le vrai sujet, c'est la gestion de la cryptographie dans l'infrastructure Linux qui fait tourner le monde. »

## Diapo 3 : repenser la menace comme un risque (2 min 30)

« Alors, de quoi parle-t-on, si ce n'est pas de quantique ? On parle de **risque**. Posez-vous la question, froidement : si la cryptographie à clé publique, celle qui protège à peu près tout, devenait cassable, on fait quoi ? »

« Ce qui rend ce sujet inconfortable, c'est qu'il touche au **socle** de notre cybersécurité. Et face à ça, je vois deux erreurs symétriques. La première : **négliger**, parce qu'on n'y croit pas, parce que ça fait peur, ou parce que ce n'est jamais la priorité. La deuxième : se laisser **submerger par le battage médiatique**, au point de ne plus voir l'enjeu réel. Les deux mènent au même endroit : l'inaction. »

« Or le risque quantique n'est qu'un **déclencheur**. Le vrai enjeu, c'est de gérer notre cryptographie et de vérifier notre chaîne d'approvisionnement logiciel. Et il y a une urgence concrète, le Harvest Now Decrypt Later : on capte vos données chiffrées aujourd'hui pour les déchiffrer plus tard. L'exposition est donc **déjà** là. »

*(Premier énoncé du leitmotiv, calmement.)*

« Alors posons la question qui va nous suivre toute la présentation : **qu'arriverait-il si on n'agissait pas ?** Gardez-la en tête. »

## Diapo 4 : c'est déjà pris en charge, et vous ? (2 min 30)

*(Ton qui s'ouvre. Interaction avec la salle.)*

« Justement, posons-la pour de vrai. Qu'est-ce qui arriverait si personne n'agissait ? »

*(Laisser deux ou trois réponses.)*

« Bonne nouvelle : on n'en est pas là, parce que le monde a déjà commencé. La communauté internationale de cybersécurité a agi. Le NIST a publié ses standards post-quantiques en 2024 : ML-KEM pour l'échange de clés, ML-DSA et SLH-DSA pour les signatures. Les Européens suivent : le BSI allemand, l'ANSSI française, l'ETSI. Le G7 a même publié une déclaration commune. »

« Et le Canada n'est pas en reste, comme **régulateur**. Le Centre canadien pour la cybersécurité a publié une feuille de route de migration, entrée en vigueur en juin 2025, avec des **obligations contraignantes** : les systèmes du gouvernement doivent migrer toute leur cryptographie à clé publique. Il y a même un guide pour les organisations. Voilà comment les autres s'y prennent : c'est cadré, c'est balisé. »

*(Temps. Regard aux décideurs.)*

« Donc la question n'est plus de savoir si c'est sérieux. C'est : est-ce que ce risque est couvert par **vos** processus de cybersécurité ? Est-il dans **vos** veilles stratégiques ? »

## Diapo 5 : Linux, infrastructure stratégique (3 min 00)

« Maintenant, le coeur. Et on commence par une mise au point pour les décideurs. »

« On entend souvent les amateurs de Linux se plaindre que personne ne l'utilise. C'est vrai sur un seul terrain : le poste de travail, autour de 5 pour cent. Partout ailleurs, Linux **domine** : environ 60 pour cent du web, 90 pour cent du cloud public, 71 pour cent du mobile via Android, la totalité des supercalculateurs. Linux n'est pas un noyau de bricoleur. C'est une **infrastructure stratégique, fondamentale et irremplaçable**. Et une infrastructure, ça s'entretient. Donc ça se finance. »

*(Afficher les deux tableaux.)*

« Et l'important, c'est que la cryptographie ne joue pas le même rôle selon l'usage. Voici nos six catégories. À gauche, leur importance stratégique. À droite, l'usage de la crypto et les défis propres à chacune. Un serveur d'entreprise, une image de conteneur, un routeur, un téléphone : ce ne sont pas les mêmes contraintes. »

*(Déclinaison du leitmotiv.)*

« Qu'arriverait-il si on laissait ce socle stratégique sans entretien ? La première étape pour l'éviter, c'est simplement de comprendre ça : où est la crypto, et ce qu'elle protège, selon l'usage. »

## Diapo 6 : le flux upstream vers downstream (3 min 00)

« La bonne nouvelle, c'est que derrière la diversité des centaines de distributions, il n'y a qu'une **poignée de briques logicielles**. Les voici. Si vous savez ce qui tourne dans ces quelques composants, vous savez presque tout. »

« Et les améliorations arrivent par un **flux** prévisible, de l'amont vers l'aval. Deux choses décident de la vitesse : la **feuille de route** de l'éditeur, et le **modèle de publication**, rolling ou stable. Regardez ce deuxième tableau : RHEL avance vite parce que son éditeur est proactif, Arch parce qu'il est rolling, Debian plus lentement parce qu'il est prudent. »

*(Déclinaison du leitmotiv, vers la communauté.)*

« Qu'arriverait-il si vos équipes ignoraient la feuille de route PQC de vos propres distributions ? Et voici la réponse facile : ça s'apprend. En gros, **une journée de formation** Linux-PQC permet à une équipe opérationnelle de prendre en charge l'essentiel du risque, et surtout de savoir le **remonter** à l'équipe cyber. »

*(À la communauté.)*

« La question à vous poser en rentrant : est-ce que le couple feuille de route plus modèle de publication de vos distributions colle à vos besoins de protection des données ? »

## Diapo 7 : les briques de la crypto Linux, en détail (2 min 30)

« Entrons dans la technique, c'est la partie la plus importante pour vous. Voici les briques, et depuis quelle version chacune fait du post-quantique. »

« Les deux moteurs, ce sont **OpenSSL** et **OpenSSH**. OpenSSL 3.5, sorti en avril 2025, apporte ML-KEM, ML-DSA et SLH-DSA nativement, et active l'échange de clés hybride par défaut en TLS. OpenSSH fait du post-quantique par défaut depuis la version 10. À côté, GnuTLS, NSS et le runtime Go ont le même échange hybride ; Go l'active par défaut depuis la 1.24, ce qui couvre tous les outils cloud-native écrits en Go. Pour l'embarqué, wolfSSL est déjà prêt et validé ; mbedTLS, pas encore. Et le noyau a ses propres chantiers en cours. »

*(Déclinaison du leitmotiv.)*

« Qu'arriverait-il si vous laissiez ces briques sur une version pré-PQC ? À l'inverse, passer à OpenSSL 3.5 et OpenSSH 10, c'est déjà l'essentiel du chemin. La posture d'une distribution, c'est d'abord la version de ces briques qu'elle embarque. »

## Diapo 8 : carte de maturité PQC par catégorie (1 min 30)

« Si on prend de la hauteur, voici la carte de qui en est où. »

« Le meneur, c'est Red Hat. RHEL active le post-quantique par défaut et, fait unique, **signe ses paquets** avec une signature post-quantique. Les distributions en rolling, Fedora, Tumbleweed, Arch, suivent très tôt. Ubuntu et Debian arrivent au rythme de leurs versions stables. Le conteneur est plutôt mûr, surtout les images fraîches et signées comme Wolfi. Le mobile avance sur le web mais traîne côté plateforme. Et l'IoT contraint, c'est le plus en retard. »

*(Déclinaison du leitmotiv, brève.)*

« Qu'arriverait-il si vous misiez, sans le savoir, sur une distribution à la traîne ? Cette carte vous évite la mauvaise surprise. »

## Diapo 9 : démo, vérifier le PQC soi-même (3 min 30)

*(Bascule vers la démonstration, préparée séparément.)*

« Et maintenant, le plus utile. Je ne veux pas que vous repartiez avec juste une carte ; je veux que vous repartiez avec une **compétence**. »

« La première étape de toute migration, ce n'est pas d'installer du post-quantique. C'est de savoir **où** vous avez de la cryptographie. On appelle ça un CBOM, un inventaire cryptographique. »

*(Énoncé du leitmotiv, version forte.)*

« Parce que, honnêtement : qu'arriverait-il si vous ne saviez même pas où se trouve votre cryptographie ? On ne migre pas ce qu'on ne voit pas. Alors voici comment la rendre visible, et vous allez voir, c'est à votre portée. »

*(Lancer la démo préparée. Commenter le résultat sur une ou deux images contrastées.)*

« Voilà. Vous saurez refaire ça en rentrant chez vous. Et c'est exactement le point de départ de la crypto-agilité : un inventaire à jour, qu'on rescanne après chaque changement. »

## Diapo x : conclusion et appel (1 min 30)

« On résume en trois mots. **Recadrer** : le quantique n'est qu'un déclencheur, le vrai sujet est la gestion de la cryptographie dans Linux. **Responsabiliser** : ni déni, ni panique ; l'enjeu est cadré, le monde et le Canada ont agi, à vous de jouer. **Outiller** : vous repartez avec une compétence concrète, l'inventaire cryptographique. »

*(Rappel explicite du leitmotiv.)*

« Vous avez remarqué : à chaque étape, j'ai posé la même question, qu'arriverait-il si on n'agissait pas ? Et à chaque fois, il y avait un voici comment. C'est ça, le message : ces choses-là se font. »

*(Temps. Regard à la salle, puis aux décideurs.)*

« Pour les organisations dans la salle : pour vous, c'est du travail ; pour nous, c'est le métier. Ce qu'on vient de montrer est directement applicable chez vous. Nous sommes les gens du PQC au Québec. Venez nous parler. Merci. »

## Notes de performance

- Deux interactions à préparer : « qu'arriverait-il si on n'agissait pas ? » (diapo 4, ouvrir la salle) et le lancement de la démo (diapo 9, prévoir un enregistrement de secours).
- Trois bascules de ton : la chute de la diapo 1, l'ouverture rassurante de la diapo 4, le passage à la compétence transmise en diapo 9.
- Le leitmotiv doit rester léger et naturel à chaque occurrence ; ne pas le marteler mécaniquement, le laisser monter jusqu'à la diapo 9 et la conclusion.
- Faits à revalider la semaine précédant l'événement : versions de distributions, jalons du CCCS (ITSM.40.001, ITSAP.00.017), standards NIST.
