# Préparer la démo

## contexte

Pour la présentation aux rencontre Linux, nous avons une démo à faire.

Nous allons montrer techniquement comment produires le CBOM pour:
- des images Linux (iso),
- des images de conteneur et
- du code source

Voici les questions auxquelles nous allons répondre dans ce démo:

- 1. Quels sont les outils disponibles pour faire un scan qui produit un CBOM? 
- 2. Lesquels sont open source et ceux qui sont commerciaux?
- 3. Quels sont les les différences entre les scanneurs: fonctionnalité, fiabilité, vitalité du développement, maturité, support disponible, etc?
- 4. Lequel choisir? Dans quelle situation?
- 5. Comment on les utiliser?
- 6. À quoi ressemble l'output? (le CBOM)
- 7. Comment interpréter le CBOM? Qu'est-ce que ça veut dire? Qu'est-ce que je fais avec ça?
- 8. comment sont distribuer les scanners? package natifs, compilé, images?
- 9. Y a-t-il des outils qui font une analyse de vulnérabilité


## Tâches

### 1. Recherche préliminaire sur les CBOM

Produire un essai de fondation qui traite les questions 1 à 3 du contexte de ce ticket et qui produit avec un maximum d'éléments possible de corps dans la dissertation.

### 2. Je trouve d'autres scanners avec google

En faisant une recherche simple sur Google, je trouve d'autres candidats que tu n'as pas inclu dans ta recherche, comme SCANOSS. Pourquoi? 
Ajuster FND-006 au besoin.

### 3. comment utiliser CBOMkit?

Répondre à la question 5 pour CBOMkit.

### 4. Choix de la démonstration

Voici ce qui a été promis:

> Enfin, nous terminerons par une présentation technique portant sur la vérification de l'intégration de la Cryptographie Post-Quantique (PQC) sur les images et les conteneurs Linux.

Voici les autres présentations:

- LM Studio: Déployer des modèles IA locaux par [Dany Dubé](https://www.linkedin.com/in/dany-dub%C3%A9-b797ab126/)
- Est-il temps de quitter BitWarden et pourquoi? par [Alexandre Blanc](https://www.linkedin.com/in/alexandre-blanc-cyber-security-88569022/)
- Cycle de vie des mots de passe avec KeePass par [Jonathan Cyr](https://www.linkedin.com/in/jonathan-cyr-872242/)

Présentatrice: Ikram, étudiante en génie logiciel. Sur poste windows avec docker


Le répertoire du démo @demo/

Contraintes à respecter:

- la démo doit être environ 10 minute
- simple, maximum 2 cas illustrés
- si possible résonne avec les autres présentations (keepass)
- au niveau de présentatrice


TODO: proposer 3 possibilités de démonstration et les décrire

### 5. Option D: keepass

Ajoutons une 4e options aux choix de démo

Pour faire un clin d'oeil aux autres présentateurs, faire un exemple sur keepass.

- PQC par défaut? comment vérifier?
- Possible d'avoir un keepass-pqc? Comment le configurer + script de migration