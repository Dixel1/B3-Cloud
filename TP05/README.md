# B3-Cloud-Final



## Pour commencer :

Ce TP Final reprend une grande partie des notions abordées au long de cette année en B3-Cloud. Nous aborderons donc Ansible, Terraform, Vagrant, et Azure.
## Objectifs :

- Créer un serveur Mumble sous Rocky 9 en utilisant Vagrant et Ansible.
- Créer un serveur Mumble sous Rocky 9 en utilisant Terraform, Ansible et Azure (ici seule la version Rocky 8 a pu être utilisée car Rocky 9 n'était pas disponible).

## Utilisation :
### Avec Vagrant + Ansible :
- Récupérez le projet.
- Installez Vagrant, Virtual Box et Ansible sur votre machine.
- Avec votre terminal, allez dans le répertoire **```.../B3-Cloud-main/TP05/with_vagrant/vagrant```**
- Créez et lancez la machine Rocky 9 en utlisant la commande suivante : **```vagrant up```**
- Avec votre terminal, naviguez dans le répertoire **```.../B3-Cloud-main/TP05/with_vagrant/ansible```**
- Poussez la configuration necessaire à l'installation et au démarrage de la solution Mumble (murmur) avec la commande suivante : **```ansible-playbook -i inventories/vagrant_lab/hosts.ini playbooks/mumble.yml```**
- Vous avez désormais un serveur Mumble fonctionnel, pour vous connecter, installez la solution cliente Mumble en suivant les instructions sur https://www.mumble.info/downloads/ et entrez l'adresse IP de votre VM Vagrant (10.1.1.11) dans le logiciel client.

### Avec Terraform, Azure et Ansible :
- Récupérez le projet.
- Installez Terraform, Ansible et Azure CLI sur votre machine et connectez vous à votre compte Azure depuis votre terminal Azure CLI.
- Avec votre terminal, allez dans le répertoire **```.../B3-Cloud-main/TP05/with_terraform/terraform```**
- Acceptez les termes et conditions légales necessaires à l'utilisation de la machine Rocky au sein d'Azure avec la commande suivante : **```az vm image terms accept --urn erockyenterprisesoftwarefoundationinc1653071250513:rockylinux:free:8.7.20230215```**
- Modifiez dans le fichier **```main.tf```** les champs suivants :
    - **```private_key = file("C:/Users/schaf/.ssh/id_rsa")```** et remplacez le chemin avec le chemin vers votre SSH Private Key.
    - **```public_key = file("C:/Users/schaf/.ssh/id_rsa.pub")```** et remplacez le chemin avec lechemin vers votre SSH Public Key.
- Créez et lancez la VM Rocky 8 dans Azure avec les commandes suivantes :
    - **```terraform init```**
    - **```terraform plan```**
    - **```terraform apply```**
- Avec votre terminal, naviguez jusqu'au répertoire **```.../B3-Cloud-main/TP05/with_terraform/ansible```**
- Modifiez les fichiers :
    - **```with_terraform/ansible/inventories/vagrant_lab/hosts.ini```** en remplaçant l'IP par la Public IP de la VM que vous venez de créer dans Azure.
    - **```with_terraform/ansible/.ssh-config```** en remplaçant l'IP par la Public IP de la VM que vous venez de créer dans Azure.
- Poussez votre configuration Ansible sur la VM Azure en utilisant la commande suivante : **```ansible-playbook -i inventories/vagrant_lab/hosts.ini playbooks/mumble.yml```**
- Vous avez désormais un serveur Mumble fonctionnel, pour vous connecter, installez la solution cliente Mumble en suivant les instructions sur https://www.mumble.info/downloads/ et entrez la Public IP de votre VM Azure dans le logiciel client.

## Impossible de démarrer le murmur.service sur CentOS 8 / Rocky 8 :
Lors du déploiement sur Azure en utilisant Terraform et Ansible, vous risquez de rencontrer un bug empéchant le service murmur de démarrer.
```bash
[Sarvagon@b3-mumble ~]$ sudo journalctl -xe
Apr 29 22:00:14 b3-mumble systemd[1]: murmur.service: Failed with result 'protocol'.
-- Subject: Unit failed
-- Defined-By: systemd
-- Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
-- 
-- The unit murmur.service has entered the 'failed' state with result 'protocol'.
Apr 29 22:00:14 b3-mumble systemd[1]: Failed to start Mumble Server (Murmur).
-- Subject: Unit murmur.service has failed
-- Defined-By: systemd
-- Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
-- 
-- Unit murmur.service has failed.
-- 
-- The result is failed.
```
Je n'ai pas trouvé de documentation fiable concernant ce problème ni comment le résoudre. Ce qui est étonnant, c'est que j'ai utilisé exactement la même configuration Ansible pour la version vagrant avec Rocky 9, et ça fonctionne... J'ai donc comparé les deux versions (machine créée avec vagrant et terraform), la configuration est mise tout pareil dans les deux, avec les mêmes permissions sur tout les fichiers/dossiers (notamment le chemin **```/var/run/murmur/murmur.pid```** indiqué en erreur), les mêmes utilisateurs et groupes, vraiment tout est identique, mais sur Rocky 8 rien à faire. 

Après de multiples recherches, il était conseillé de mettre la ligne PID de mon fichier service en commentaire pour résoudre (parfois) le problème, j'ai essayé et je n'ai plus d'erreur lors de l'execution de la commande **```sudo systemctl start murmur.service```** puisque le service reste en status dead sans erreur de démararge du service (service zombi). 

Même le faire à la main sur une VM Rocky 8 et Rocky 9 pour être sûr de tout faire pareil me fait arriver au même résultat : aucun problème avec Rocky 9 mais Rocky 8 refuse de me démarrer le **```murmur.service```**

J'ai également remarqué que CentOS 8 / Rocky 8 revient régulièrement sur le rapport de cette erreur pour les "self-made systemd services", ce qui m'amène à me demander si Rocky 8 n'en serait pas la cause puisque le problème est absent sur Rocky 9...