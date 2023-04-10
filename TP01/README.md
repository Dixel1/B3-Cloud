# B3-Cloud-TP01
Dans ce TP nous allons approfondir l'utilisation d'Ansible grâce à la construction de playbooks, l'organisation de dépôt et l'utilisation d'un workflow de travail.
Pour mener à bien ce TP, nous avons ici utilisé une machine Windows hybride Linux (Windows avec WSL).

Pour les notions de présentations Vagrant et Ansible, merci de vous réferer au TP00.
## Le répertoire de travail Ansible rangé
Pourquoi maintenir un répertoire de travail Ansible bien rangé ? Et bien, pour plusieurs raisons, cela :
- **Facilite la maintenance et les mises à jour :** en ayant une structure de répertoire claire et organisée, il est plus facile de naviguer dans le contenu du playbook ou de la tâche, de trouver les fichiers pertinents et de les mettre à jour si nécessaire.
- **Améliore la lisibilité et la compréhension :** une structure de répertoire cohérente et logique facilite la lecture et la compréhension du code par d'autres membres de l'équipe, en particulier pour les projets collaboratifs.
- **Réduit les erreurs et les conflits :** en évitant les noms de fichiers et de répertoires redondants ou mal nommés, on réduit les risques de confusion et d'erreur lors de l'exécution des playbooks.
- **Facilite la gestion des versions :** en organisant le répertoire de travail de manière systématique, il est plus facile de gérer les différentes versions des playbooks et des tâches, en gardant une trace de chaque modification et en conservant l'historique des changements.
## Les variables d'inventaires pour une structure de dépôt Ansible
Les utilités d'utiliser des variables d'inventaire pour une structure de dépôt Ansible sont diverses. En effet, ces variables permettent de stocker des informations spécifiques aux hôtes dans des fichiers séparés, plutôt que d'avoir ces informations réparties dans tout le code d'Ansible (comme dans le TP00). De plus, cela facilite la gestion et la maintenance du code, en particulier pour les projets de grande envergure qui impliquent de nombreux hôtes et configurations.
Une petite liste non exaustive de raisons pour lesquelles adopter une telle structure :
- **Centralisation des informations :** en stockant les informations relatives à chaque hôte (comme les adresses IP, les noms de domaine, les groupes d'hôtes, etc.) dans un fichier de variables d'inventaire dédié, il est plus facile de retrouver ces informations et de les mettre à jour si nécessaire.
- **Personnalisation ciblée :** les variables d'inventaire permettent de personnaliser les configurations et les paramètres pour chaque hôte ou groupe d'hôtes, ce qui est important pour garantir que chaque hôte ait sa configuration spécifique.
- **Séparation des préoccupations :** en séparant les informations relatives aux hôtes des tâches et des playbooks d'Ansible, il est plus facile de comprendre le code et de le maintenir au fil du temps.
- **Réutilisabilité accrue :** en utilisant des variables d'inventaire, on peut réutiliser les mêmes configurations pour plusieurs hôtes ou groupes d'hôtes similaires, ce qui évite la duplication de code et facilite la maintenance.

## Les handlers :
Un handler est une tâche Ansible qui est déclenchée en réponse à un événement généré par une autre tâche. Les handlers sont généralement utilisés pour effectuer des actions de gestion d'état, telles que redémarrer un service ou régénérer une configuration. Les handlers sont définis dans des fichiers séparés et sont référencés dans les tâches correspondantes via le mot-clé "notify". Lorsqu'un événement est signalé par une tâche, tous les handlers correspondants sont exécutés à la fin de l'exécution de la série de tâches.

## Jinja2 :
Un fichier Jinja2 est un modèle utilisé par le moteur de template Jinja2 pour générer des fichiers de configuration dynamiques dans le cadre d'un processus d'automatisation. Les fichiers Jinja2 contiennent du code source qui utilise une syntaxe spécifique pour définir les éléments à remplacer ou à itérer pendant la génération de fichiers.

Les fichiers Jinja2 sont souvent utilisés en conjonction avec des outils d'automatisation tels que Ansible pour générer des fichiers de configuration personnalisés pour des applications telles que Nginx, Apache, MySQL, etc. En utilisant des fichiers Jinja2, il est possible de créer des fichiers de configuration réutilisables et modulaires qui peuvent être facilement adaptés à des environnements spécifiques en utilisant des variables personnalisées.

## Note : Ce TP contient des commentaires dont il ne faut pas tenir comptes (généralement du code mis en commentaire et précisé comme servant pour effectuer des tests).