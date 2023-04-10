Nous nous situons à présent dans le répertoire **```roles```**.
Ce répertoire possède plusieurs dossiers :
- **common**
- **nginx**
- **webapp**

## roles
Le dossier ```TP01/Ansible/roles``` est un répertoire dans lequel on peut stocker des rôles Ansible.

Les rôles sont des ensembles cohérents de tâches, de fichiers de configuration, de templates, etc. qui permettent de déployer et de configurer des composants logiciels spécifiques sur les hôtes gérés par Ansible.

En stockant les rôles dans le répertoire ```TP01/Ansible/roles```, on peut facilement réutiliser ces rôles dans plusieurs playbooks Ansible. Cela permet de simplifier la maintenance et d'assurer la cohérence des configurations entre les différents hôtes et les différents environnements.

## Note : L'intégralité du code ne sera pas commenté car certaines lignes sont redondantes entre les différents roles. Seul ce qui n'a pas déjà été présenté sera commenté.