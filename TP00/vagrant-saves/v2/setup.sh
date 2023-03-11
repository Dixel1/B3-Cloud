# init script for Vagrant VMs

# update OS
dnf update -y

# install python
dnf install -y python

# install ansible
dnf install -y ansible

# install sudo
dnf install -y sudo

# désactive SELinux
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

# ajout d'un utilisateur "user"
useradd user1
passwd -f -u user1

# ajout de l'utilisateur sans mot de passe
echo 'user1 ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# install OpenSSH package
dnf install -y openssh-server

# démarre le service OpenSSH
systemctl start sshd

# démarre le service OpenSSH au démarrage
systemctl enable sshd

# configure le firewall pour autoriser le protocol SSH entrant 
firewall-cmd --zone=public --permanent --add-service=ssh

