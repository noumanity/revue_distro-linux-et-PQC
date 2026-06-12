# Comment les distributions Linux s'adaptent-elles au "risque quantique"?

## Abstract

Depuis les travaux du mathématicien Peter Shor en 1994 sur les algorithmes quantiques de factorisation des grands nombres entiers, on spécule sur la capacité des standards de cryptographie à résister à des attaques utilisant des ordinateurs quantiques. La menace "récolter maintenant, déchiffrer plus tard" (HNDL), l'accélération de la maturité des technologies de l'information quantique et l'échéance estimée autour de 2030 ravivent les craintes.

Cette présentation est une revue du sujet et aborde les principales considérations de cybersécurité que doivent connaitre les mainteneurs et utilisateurs Linux. Nous discuterons en premier lieu de la prise en charge de cet enjeu par les organisations de normalisation internationales et des mesures de conformité imposées par le Canada pour éviter les pires scénarios. Puis, nous verrons un peu plus techniquement quelles "briques" fondamentales des systèmes Linux ont dû être adaptées. Nous ferons le tour de quelques distributions Linux pour voir comment elles comptent intégrer ces nouveaux mécanismes. Enfin, nous terminerons par une présentation technique portant sur la vérification de l'intégration de la Cryptographie Post-Quantique (PQC) sur les images et les conteneurs Linux.

## Biographie

<img src="https://media.licdn.com/dms/image/v2/D4E03AQECsDfKLjHphg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1712225837200?e=1782950400&v=beta&t=YW_dbRFkgpeTGhZYMHMlKhkclFSSRMd6_NBYvgomqd0" alt="Jérémy Viau-Trudel" width="200" />

Ayant une trajectoire atypique, [Jérémy Viau-Trudel](https://www.linkedin.com/in/jvtrudel/) vient de la chimie quantique.
Pendant ses études supérieures à l'Université Laval, puis à l'Université Paris-Sud, il a
mené des recherches de haut niveau sur la **simulation de la dynamique électronique de
molécules soumises à des champs laser intenses**.
C'est là, d'abord par nécessité, qu'il a commencé à
utiliser Linux.

Depuis une dizaine d'années, il est **consultant TI spécialisé en Linux** et intervient régulièrement
sur des mandats **DevSecOps**. Son approche pragmatique l'a amené à travailler aussi bien sur des infrastructures *on-premise*
qu'en *infonuagique* et en *edge computing*.

Depuis cinq ans, il développe **noumanity**, un studio *DeepTech* qui s'intéresse à des
sujets techniques complexes comme: la maitrise des chaînes d'approvisionnement technologique dans une perspective de souveraineté numérique, l'Intelligence Quantique et la Cryptographie Post-Quantique.
