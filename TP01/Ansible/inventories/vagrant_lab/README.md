Nous nous situons dans le répertoire **vagrant_lab**.
Ce répertoire contient 2 dossiers différents :
- **group_vars**
- **host_vars**

## group_vars :
Le chemin ```/Ansible/inventories/vagrant_lab/group_vars``` correspond à un répertoire qui contient des fichiers de variables de groupe pour l'inventaire Ansible "vagrant_lab".

Dans Ansible, les groupes d'hôtes peuvent avoir des variables associées appelées "variables de groupe". Ces variables sont stockées dans des fichiers spécifiques (ici ```ynov.yml```) appelés "fichiers de variables de groupe".

Les fichiers de variables de groupe contiennent des valeurs de variables qui seront appliquées à tous les hôtes de ce groupe en particulier. Ils permettent donc de personnaliser la configuration de l'ensemble des hôtes appartenant à un groupe donné de manière cohérente et efficace.

## host_vars :
Le chemin ```/Ansible/inventories/vagrant_lab/host_vars``` correspond à un répertoire qui contient des fichiers de variables d'hôte pour l'inventaire Ansible "vagrant_lab".

Dans Ansible, les variables peuvent être définies au niveau de chaque hôte à travers les "variables d'hôte". Ces variables sont stockées dans des fichiers spécifiques (par exemple ici ```node1.tp2.cloud.yml```) appelés "fichiers de variables d'hôte".

Les fichiers de variables d'hôte contiennent des valeurs de variables qui seront appliquées uniquement à l'hôte associé à ce fichier de variables. Ils permettent donc de personnaliser la configuration de chaque hôte individuellement.