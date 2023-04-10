# B3-Cloud-TP00
Dans ce premier TP, nous abordons les notions de Vagrant et Ansible. Pour mener à bien ce TP, nous avons ici utilisé une machine Windows hybride Linux (Windows avec WSL). 

## Vagrant
### Qu'est-ce que Vagrant ?
Vagrant est un logiciel libre et open-source pour la création et la configuration des environnements de développement virtuels. Il peut être considéré comme un wrapper autour de logiciels de virtualisation comme VirtualBox. 

En gros, nous pouvons spécifier la configuration d’une machine virtuelle dans un simple fichier de configuration et Vagrant crée la même machine virtuelle en utilisant une seule commande simple.
### VagrantFile :
"Vagrantfile" est un fichier de configuration pour Vagrant. Il est écrit en langage Ruby et décrit les exigences et les configurations de la machine virtuelle que l'on souhaite créer avec Vagrant. Le "Vagrantfile" définit des paramètres tels que le système d’exploitation de la machine virtuelle, la quantité de mémoire et de CPU allouée à la machine virtuelle, les dossiers partagés entre la machine hôte et la machine virtuelle, et les scripts de provisionnement à exécuter lors de la création de la machine virtuelle (ici le script de provisionnement est "setup.sh").
### setup.sh :
Le fichier "setup.sh" est un script shell utilisé pour la provision de la machine virtuelle. Le provisionneur Shell de Vagrant vous permet de télécharger et d’exécuter un script à l’intérieur de la machine instanciée par notre Vagrantfile.
### Commandes de bases :
Voici quelques commandes basiques pour démarrer, arreter et détruire votre machine créée avec Vagrant :
```shell
#Démarre votre machine (ou la créée si cela n'est pas fait)
$ vagrant up

#Arrête votre machine (sans la détruire)
$ vagrant halt

#Détruit votre machine
$ vagrant destroy -f
```
## Ansible
### Qu'est-ce que Ansible ?
Ansible est un outil d’automatisation informatique. Il peut configurer des systèmes, déployer des logiciels et orchestrer des tâches informatiques plus avancées telles que des déploiements continus ou des mises à jour progressives sans temps d’arrêt.
### ansible.cfg
ansible.cfg est un fichier de configuration pour Ansible. Il permet de définir des paramètres de configuration Ansible. Par exemple, dans ce TP, la section ```[ssh_connection]``` définit les paramètres de connexion SSH pour Ansible. La ligne ```ssh_args = -F ./.ssh-config``` indique à Ansible d’utiliser le fichier ".ssh-config" dans le répertoire courant comme fichier de configuration pour les connexions SSH. Cela signifie que lorsqu’Ansible se connecte à des hôtes distants via SSH, il utilisera les paramètres définis dans ce fichier de configuration.
### hosts.ini
Il s'agit d'un fichier d’inventaire. Il permet de décrire les hôtes et les groupes d’hôtes que vous souhaitez gérer avec Ansible. Le fichier d’inventaire peut être écrit dans différents formats, y compris INI et YAML. Dans le format INI, les hôtes sont listés sous des en-têtes de section qui représentent des groupes d’hôtes. Par exemple :
```ini
[tp1]
10.1.1.11
10.1.1.12

[web]
10.1.1.11

[db]
10.1.1.12
```
## Note : Ce TP contient des commentaires dont il ne faut pas tenir comptes (généralement du code mis en commentaire et précisé comme servant pour effectuer des tests).