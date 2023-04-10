# B3-Cloud-TP02
Dans ce TP02 (techniquement c'est le troisième), nous allons aborder une nouvelle notion, le "cloud-init".
Pour mener à bien ce TP, nous avons ici utilisé une machine Windows hybride Linux (Windows avec WSL).

## Cloud-init :
Cloud-init est un outil open-source largement utilisé pour la personnalisation et la configuration automatique des instances de machines virtuelles (VMs) dans les environnements cloud. Il permet de simplifier l'initialisation des systèmes d'exploitation en fournissant une infrastructure flexible et extensible pour le provisionnement, la configuration de base, la mise à jour et le déploiement d'applications sur les VMs.

Il est capable de récupérer des informations de configuration depuis plusieurs sources, telles que les métadonnées du serveur, les scripts personnalisés, les fichiers de configuration, les images préconfigurées, etc. Il peut également effectuer des tâches de configuration de base, telles que la configuration réseau, la définition des utilisateurs système, la gestion des packages, la configuration SSH, etc.

Cloud-init est également compatible avec une grande variété de systèmes d'exploitation, ainsi qu'avec des fournisseurs de cloud tels que Amazon Web Services, Microsoft Azure, Google Cloud Platform, OpenStack, etc.

## Fichiers .qcow2 :
Il s'agit d'un type de fichier d'image disque utilisé par le logiciel de virtualisation QEMU. C'est un format de fichier qui permet de créer des images de disque virtuelles qui peuvent être utilisées pour exécuter des systèmes d'exploitation et des applications dans des environnements virtualisés. Le format qcow2 offre des fonctionnalités telles que la compression, la déduplication et la prise en charge des instantanés de disque.

## Fichiers .vdi :
Il s'agit d'un format de fichier qui permet de créer des machines virtuelles enregistrées sur le disque dur physique de l'hôte et stocke une image complète du disque virtuel, y compris les partitions, les systèmes de fichiers et les données. Les fichiers .vdi sont compatibles avec plusieurs systèmes d'exploitation invités et peuvent être utilisés pour sauvegarder et déplacer facilement des machines virtuelles entre différents hôtes VirtualBox.

Pour convertir le format .qcow2 en .vdi, on a ici utilisé cette commande :

```$ qemu-img  convert -f qcow2 -O vdi Rocky-9-GenericCloud-Base.latest.x86_64.qcow2 rocky9.vdi```

## user-data :
Le fichier user-data est généralement utilisé pour automatiser la configuration des VMs lorsqu'elles sont créées pour des tâches spécifiques, telles que le déploiement de serveurs Web ou de bases de données. Les instructions contenues dans le fichier user-data peuvent inclure l'installation de logiciels, la configuration de paramètres système, la création d'utilisateurs et de groupes, ou tout autre processus nécessaire pour préparer la machine virtuelle à son utilisation prévue.

## meta-data :
Il s'agit d'un fichier contenant des métadonnées. Les métadonnées contenues dans le fichier meta-data peuvent inclure des informations telles que l'identifiant de l'instance, l'adresse IP, le nom d'hôte, la clé publique SSH et d'autres détails spécifiques.

## Fichiers .iso :
Le fichier .iso est un format courant utilisé dans la création et l'utilisation d'un CD-ROM ou d'un DVD.
Pour créer le fichier .iso à partir des fichiers ```user-data``` et ```meta-data```, nous avons utilisé cette commande :

```$ genisoimage -output cloud-init.iso -volid cidata -joliet -r meta-data user-data```