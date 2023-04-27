# init script for Vagrant VMs

# update OS
dnf update -y

# install python
dnf install -y python

# install ansible
dnf install -y ansible

# install bzip2
dnf install -y bzip2

# install sudo
dnf install -y sudo

# désactive SELinux
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

# ajout d'un utilisateur "user" & "murmur" + groupe
useradd user1
passwd -f -u user1
groupadd -r murmur
useradd -r -g murmur -m -d /var/lib/murmur -s /sbin/nologin murmur
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

# création dossier .ssh et ajout de la public key 
mkdir /home/user1/.ssh
touch /home/user1/.ssh/authorized_keys 
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDa1jE+jVEMvAp7PIX6UHnf6ZGIo8Ba6NRlDp1qTYbxlAewod/qjERYlIspUupbng8bly3UnYfUfGNAIyutonEmX2K89rOumCtyAEl2CbcB1Yjuc9uUB9sRf0C6/TVZ5GaRWeuiGpSOo7FTSz4lH1hcH63TN0uvL4x7uS4yu9DLl4WXOzd81iYyzcnOTXsWYCiwyzRwhFeB/NJp+WlmdrGuu4ZYd4BBCtkUfUmjwTr3p6JhItpCzplo7Mm6iUPsNtvF1uPUn42r3XpE7YPP9ZhDtnuKr2U1DdpIXSGeK7yUehpDc6atJ4VZUFn0RO1ZMUlrXUDiPmUi7GSFU6cHaeZdPuBosilBHJnunyrF5a7PBpHueQtMQkQBVecT0XqRLYYt7m2lEbhBpUuwbXSoR3UUPtFBQKpfee8kcbP09WJ48fQHRxO51PjAmyyICwcmK5Y+ijdQmzO840G5l8+Xl2p6leX3Y6ywqd0/xBZNPKxUAToikXIW+rPUmq9KrHigPno4d2xlNXxyRJ3kirpqztMu7AV0z/nQ5bVcHJwn2a+wt8KcCoiOFD2X0fsXURUsv2Z5yn+zzwaul2F8FDHp9VliO3EJrD600fzH8pM/dFVZ5OEYRwrmzIJqJo8KSxsVbWdY+HPzPjHNBGg4S9j2DXz2NHKbizmTxlJJyfQjLn2ETQ== schaf@DESKTOP-AEJ9M2Q' > /home/user1/.ssh/authorized_keys

# configuration des permissions du dossier ".ssh" et du dossier sous-jacent "authorized_keys"
chown -R user1:user1 /home/user1/.ssh
chmod 700 /home/user1/.ssh
chmod 600 /home/user1/.ssh/authorized_keys
