# Verbatim par diapo

> **Livrable 4/4 de la tâche 1 du ticket [TKT-001-plan](../tickets/TKT-001-plan/ticket.md).** Contenu détaillé, sous forme de **verbatim oral**, pour chacune des dix diapos du [plan](03-plan-10-diapos.md). Le texte est rédigé pour être **dit**, pas lu : phrases courtes, ton calme et un brin malicieux (cf. motif du récit, livrable 2). Les indications de scène sont en italique. Les faits sont alignés sur les fondations sourcées ; à revalider à l'approche de l'événement.

## Diapo 1 : l'accroche

*(À l'écran : un plan d'apparence très savante. Ton assuré, presque solennel.)*

« Bonjour à tous. Merci d'être là. Aujourd'hui, on va parler de calcul quantique. Voici le plan. D'abord, je vais vous démontrer le théorème de Shor au tableau. Ensuite, on va l'implémenter ensemble en Qiskit. Et pour finir, on va lancer une exécution, gratuitement, sur l'ordinateur quantique d'IBM installé à Bromont, juste à côté. »

*(Pause. On laisse le malaise monter deux secondes.)*

« ... Non. Je blague. »

*(Les lignes du faux plan se barrent une à une à l'écran.)*

« Rien de tout ça. En fait, je vais vous confier un secret pour une salle remplie de gens de Linux : dans toute cette présentation, on va utiliser le mot quantique souvent, mais **il n'y a rien de quantique là-dedans**. Pas de qubit, pas de superposition, pas de physique. Ce dont on parle aujourd'hui, c'est de cybersécurité. Du travail d'ingénierie, normal, que vous connaissez déjà. »

## Diapo 2 : le vrai plan

*(À l'écran : un plan volontairement sobre, presque ennuyeux.)*

« Voici le vrai plan. Et je l'ai fait exprès le plus ordinaire possible, parce que c'est ça mon message principal. On va voir : les menaces, les risques, les composants impactés, la stratégie de mitigation, où en sont quelques distributions Linux, et on finira par une démo d'inventaire cryptographique. »

« C'est un plan de présentation de cybersécurité comme il en existe mille. Et c'est exactement ce que je veux vous montrer : la cryptographie post-quantique, le PQC, ce n'est pas une révolution affolante. C'est la suite normale d'un métier qui, depuis trente ans, remplace ses algorithmes quand il le faut. Gardez cette idée en tête : **on gère**. »

## Diapo 3 : la menace, sans drame

« Alors, la menace. Oui, il y a une course pour casser les algorithmes de cryptographie standards. Mais ce n'est pas la première fois. Souvenez-vous : MD5, cassé. SHA-1, cassé. DES, abandonné pour AES. RC4, déprécié dans TLS. À chaque fois, qu'est-ce qu'on a fait ? On a remplacé l'algorithme par un plus solide. C'est la routine. »

« Le quantique, concrètement, menace quoi ? L'algorithme de Shor **casse** la cryptographie asymétrique : RSA, les courbes elliptiques. C'est le coeur du problème. L'algorithme de Grover, lui, ne fait qu'**affaiblir** le symétrique, AES et les fonctions de hachage ; et la parade est triviale, on double la taille des clés. Donc AES-256 reste solide. »

« Et soyons honnêtes : pendant qu'on améliore le quantique, on améliore aussi le classique. L'an dernier, des chercheurs ont reproduit avec de simples réseaux tensoriels un calcul qu'on disait hors de portée des ordinateurs classiques. Les deux mondes se tirent vers le haut. Message : **pas besoin de paniquer.** »

## Diapo 4 : pourquoi c'est quand même sérieux

« Maintenant, je ne veux pas que vous partiez en pensant que c'est rien. Parce que c'est sérieux, mais pour une raison contre-intuitive. »

« Quand arrive l'ordinateur quantique capable de casser RSA, le fameux Q-Day ? Personne ne le sait. Les experts donnent autour de 28 à 49 pour cent de chances dans les dix ans. C'est incertain. Mais le pire scénario serait catastrophique à l'échelle de l'économie mondiale. Et surtout, il y a le piège : le **Harvest Now, Decrypt Later**. Un adversaire capte **aujourd'hui** vos données chiffrées, les stocke, et les déchiffrera quand il aura la machine. »

« Donc la vraie question n'est pas quand arrive le Q-Day. C'est : combien de temps vos données doivent-elles rester secrètes ? Il y a une petite inégalité pour ça, l'inégalité de Mosca : si la durée de vie de vos données plus le temps qu'il vous faut pour migrer dépasse le temps avant le Q-Day, vous êtes **déjà** en retard. Petit détail savoureux : Mosca est canadien, on y revient. »

## Diapo 5 : des enjeux déjà bien pris en charge

« Bonne nouvelle : le monde s'est organisé, et ça avance bien. »

« Côté normalisation, le NIST a publié en 2024 les premiers standards post-quantiques : ML-KEM pour l'échange de clés, ML-DSA et SLH-DSA pour les signatures. Ce ne sont plus des projets de recherche, ce sont des standards. Et les Européens suivent : le BSI allemand, l'ANSSI française, l'ETSI. »

« Côté vocabulaire, le milieu a ses repères : le Q-Day dont on a parlé, et surtout la **crypto-agilité** : la capacité à changer d'algorithme rapidement, sans tout reconstruire. C'est ça, le vrai objectif. Pas installer du PQC une fois, mais devenir capable d'en changer quand il le faudra. Bref : ce n'est pas le far west, c'est un chantier cadré, avec des règles et un calendrier. »

## Diapo 6 : le leadership canadien

« Je vous avais promis qu'on reviendrait au Canada. Parce qu'on a de quoi être fiers. »

« Le quantique au Canada, c'est un pôle mondial. Et au Québec, il y a un triangle : Québec, Sherbrooke, Montréal. À Sherbrooke, l'Institut quantique de l'Université de Sherbrooke et la zone d'innovation Distriq ; un ordinateur quantique IBM installé à Bromont. Au fédéral, une Stratégie quantique nationale, dont la feuille de route parle explicitement de communication quantique et de cryptographie post-quantique. »

« Et vous vous souvenez de l'inégalité de Mosca, à la diapo d'avant ? Michele Mosca, c'est l'Institut for Quantum Computing de Waterloo, en Ontario. Le cadre qu'on utilise partout dans le monde pour mesurer le risque quantique vient d'ici. Quand on parle de PQC, le Canada n'est pas spectateur, il est sur la ligne de front. »

## Diapo 7 : Linux, où vit la crypto

« Bon, on est entre gens de Linux, rentrons dans la machine. Où est la cryptographie dans une distribution, concrètement ? »

« Elle est partout, mais elle passe par quelques composants clés. **OpenSSL** et **GnuTLS** pour le TLS, c'est-à-dire le HTTPS et la plupart des communications chiffrées. **OpenSSH** pour vos connexions à distance. Et le **noyau** lui-même, pour certaines opérations. Ajoutez la signature des paquets, qui garantit que ce que vous installez vient bien de votre distribution. »

« Ça veut dire que la posture post-quantique d'une distribution ne se décide pas dans le vide : elle dépend surtout de la version de ces composants qu'elle embarque. Si vous savez quelle version d'OpenSSL et d'OpenSSH tourne sur une image, vous savez déjà presque tout de sa maturité PQC. C'est cette grille qu'on a utilisée pour analyser les distributions. »

## Diapo 8 : la roadmap PQC des distributions

« Et justement, qu'est-ce que ça donne sur le terrain ? »

« Le déclencheur, c'est l'amont. En 2025, deux sorties ont tout changé : OpenSSL 3.5, qui active l'échange de clés post-quantique par défaut, et OpenSSH 10, pareil. À partir de là, le PQC **descend** vers les distributions, à la vitesse de leur modèle de publication. »

« Qui mène ? Red Hat, nettement. RHEL active le PQC par défaut dans ses politiques, et surtout, c'est la première grande distribution à **signer ses paquets** avec une signature post-quantique. Derrière, les distributions en rolling, comme Arch ou openSUSE Tumbleweed, l'ont très tôt par fraîcheur. Ubuntu et Debian, eux, l'intègrent au rythme de leurs versions stables. Et tout un monde de dérivés hérite simplement de son amont. La carte est claire, et on l'a documentée image par image. »

## Diapo 9 : démo, inventaire et CBOM

*(Bascule vers la démonstration en direct ou enregistrée.)*

« Maintenant, le concret. Parce qu'il y a une règle simple en migration : on ne migre pas ce qu'on ne connaît pas. La toute première étape, ce n'est pas d'installer du PQC, c'est de savoir **où** vous avez de la cryptographie. »

« Pour ça, il y a le CBOM, le Cryptography Bill of Materials : l'inventaire de toute la crypto d'un système. Je vais le faire devant vous sur deux images contrastées. Une image RHEL récente : vous allez voir un inventaire riche, avec du post-quantique déjà activé. Et une image Alpine minimale : un inventaire tout petit, centré sur OpenSSL et quelques certificats. »

*(Lancer le scan, commenter le résultat.)*

« Voilà à quoi ça ressemble. Et c'est ça, le point de départ de la crypto-agilité : un inventaire à jour, qu'on peut rescanner après chaque migration pour vérifier qu'on a vraiment bougé. »

## Diapo 10 : conclusion et appel

« On résume. La menace quantique sur la cryptographie est réelle, mais c'est un problème d'ingénierie de cybersécurité, pas une apocalypse. Il faut agir maintenant, à cause du Harvest Now Decrypt Later et de la durée de vie de vos données. Et tout est en place pour le faire : des standards, des outils, une carte des distributions, et un vrai leadership canadien. »

« Trois mots à retenir : démystifier, responsabiliser, rassurer. La menace n'est pas magique, l'urgence est réelle mais mesurable, et la solution est connue. La vraie capacité à bâtir, ce n'est pas de migrer une fois, c'est de rester crypto-agile. »

*(Temps. Regard à la salle.)*

« Chez nous, c'est exactement ce qu'on fait. Si la migration post-quantique vous concerne, et elle vous concerne, on est les gens du PQC au Québec. Venez nous parler. Merci. »

## Notes de performance

- Durée cible : environ 15 à 20 minutes ; la démo (diapo 9) est le segment élastique.
- Les deux temps de bascule à répéter : la chute de la diapo 1 (timing du « Non. Je blague. ») et le lancement du scan en diapo 9 (prévoir un enregistrement de secours).
- Chiffres et faits à revalider la semaine précédant l'événement (versions de distributions, statistiques de Q-Day, jalons canadiens) ; sources dans les fondations citées.
