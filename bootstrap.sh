# #!/bin/bash


# OUTPUT=$(lsb_release -i | cut -f 2-)

# if [ "$OUTPUT" = "ManjaroLinux" ]; then
#     echo "MANJARO"
#     sudo pacman -S openssh vim ansible
# else
# 	if [ "$OUTPUT" = "Ubuntu" ]; then
#     		echo "Ubuntu"
#             sudo apt install vim openssh ansible
#     fi
# fi
# # sudo systemctl status sshd.service
# sudo systemctl enable sshd.service
# sudo systemctl start sshd.service


# curl https://github.com/haak.keys | tee -a ~/.ssh/authorized_keys

# //TODO: disable root login
# //TODO: disable password login via ssh
#  xorg-xsettings will make vidia much better
# ssh $1@$2 "sudo apt -y update && sudo apt -y upgrade && sudo apt -y install ansible"
# ssh-copy-id -i ~/.ssh/id_rsa ubuntu@192.168.178.99
# TODO: copy key to new machine



# !/bin/bash

# script to be run on plain machine to bootstrap the machine

# set -e

# Detect OS
# if grep -qs "ubuntu" /etc/os-release; then
#     os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
# else
#     echo "This installer seems to be running on an unsupported distribution.
#     Supported distros are Ubuntu 20.04 and 22.04"
#     exit
# fi

# Check if the user is root or not
if [[ $EUID -ne 0 ]]; then
    SUDO='sudo -H -E'
else
    SUDO=''
fi


# Detect OS
if grep -qs "ID=manjaro" /etc/os-release; then
    echo "Manjaro"
fi

if grep -qs "ID=endeavouros" /etc/os-release; then
    echo "EndeavourOS"
fi


if grep -qs "ID_LIKE=arch" /etc/os-release; then
    echo "os is like arch"
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm openssh
fi

if grep -qs "ID_LIKE=debian" /etc/os-release; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo spt install -y openssh-server
fi



# sudo systemctl status sshd.service
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

curl https://github.com/haak.keys >> ~/.ssh/authorized_keys

# # curl to variable
# KEY=$(curl https://github.com/haak.keys)
# # echo $KEY >> ~/.ssh/authorized_keys


# #!/bin/bash
# echo $KEY | ssh "$@" 'mkdir -pm 0700 ~/.ssh &&
#     while read -r ktype key comment; do
#         if ! (grep -Fw "$ktype $key" ~/.ssh/authorized_keys | grep -qsvF "^#"); then
#             echo "$ktype $key $comment" >> ~/.ssh/authorized_keys
#         fi
#     done'

# cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys.bak
# cat ~/.ssh/authorized_keys | sort -u > ~/.ssh/authorized_keys

sort ~/.ssh/authorized_keys | uniq > ~/.ssh/authorized_keys.uniq
mv ~/.ssh/authorized_keys{.uniq,}


# disable password authentication
ssh_filename="/etc/ssh/sshd_config"
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' $ssh_filename

# disable root login
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' $ssh_filename

# restart sshd service
sudo systemctl restart sshd.service

if grep -qs "ID_LIKE=arch" /etc/os-release; then
    echo "Manjaro"
    sudo pacman -S --noconfirm ansible
fi

if grep -qs "ID_LIKE=debian" /etc/os-release; then
    sudo spt install -y ansible
fi

# Clone the Ansible playbook
# [ -d "$HOME/ansible-easy-vpn" ] || git clone https://github.com/notthebee/ansible-easy-vpn

# [ -d "$HOME/ansible-nas" ] || git clone https://github.com/haak/ansible-nas
# cd $HOME/ansible-nas && ansible-galaxy install -r requirements.yml

# clear
# echo "Welcome to ansible-easy-vpn!"
# echo
# echo "This script is interactive"
# echo "If you prefer to fill in the inventory.yml file manually,"
# echo "press [Ctrl+C] to quit this script"
# echo
# echo "Enter your desired UNIX username"
# read -p "Username: " username
# until [[ "$username" =~ ^[a-z0-9]*$ ]]; do
#     echo "Invalid username"
#     echo "Make sure the username only contains lowercase letters and numbers"
#     read -p "Username: " username
# done


# echo
# echo
# echo "Enter the path for where you want to store docker containers"
# echo "This should be ssd storage ideally"
# echo
# read -p "storage path" ssd_storage_path
# # until [[ "$root_host" =~ ^(/[^/ ]*)+/?$ ]]; do
# #   echo "Invalid domain name"
# #   read -p "Domain name: " root_host
# # done

# echo
# echo
# echo "Enter the path for where you want to store media"
# echo "This should be large storage ideally"
# echo
# read -p "media storage path" media_storage_path





# until [[ "$root_host" =~ ^(/[^/ ]*)+/?$ ]]; do
#   echo "Invalid domain name"
#   read -p "Domain name: " root_host
# done

# sed -i "s/username: .*/username: ${username}/g" $HOME/ansible-easy-vpn/inventory.yml

# echo
# echo "Enter your user password"
# echo "This password will be used for Authelia login, administrative access and SSH login"
# read -s -p "Password: " user_password
# until [[ "${#user_password}" -lt 60 ]]; do
#   echo
#   echo "The password is too long"
#   echo "OpenSSH does not support passwords longer than 72 characters"
#   read -s -p "Password: " user_password
# done
# echo
# read -s -p "Repeat password: " user_password2
# echo
# until [[ "$user_password" == "$user_password2" ]]; do
#   echo
#   echo "The passwords don't match"
#   read -s -p "Password: " user_password
#   echo
#   read -s -p "Repeat password: " user_password2
# done


# echo
# echo
# echo "Enter your domain name"
# echo "The domain name should already resolve to the IP address of your server"
# echo
# read -p "Domain name: " root_host
# until [[ "$root_host" =~ ^[a-z0-9\.]*$ ]]; do
#   echo "Invalid domain name"
#   read -p "Domain name: " root_host
# done

# public_ip=$(curl -s ipinfo.io/ip)
# domain_ip=$(dig +short ${root_host})

# until [[ $domain_ip =~ $public_ip ]]; do
#   echo
#   echo "The domain $root_host does not resolve to the public IP of this server ($public_ip)"
#   read -p "Domain name: " root_host
#   public_ip=$(curl -s ipinfo.io/ip)
#   domain_ip=$(dig +short ${root_host})
#   echo
# done


# sed -i "s/root_host: .*/root_host: ${root_host}/g" $HOME/ansible-easy-vpn/inventory.yml

# echo
# echo "Would you like to use an existing SSH key?"
# echo "Press 'n' if you want to generate a new SSH key pair"
# echo
# read -p "Use existing SSH key? [y/N]: " new_ssh_key_pair
# until [[ "$new_ssh_key_pair" =~ ^[yYnN]*$ ]]; do
# 				echo "$new_ssh_key_pair: invalid selection."
# 				read -p "[y/N]: " new_ssh_key_pair
# done
# sed -i "s/enable_ssh_keygen: .*/enable_ssh_keygen: true/g" $HOME/ansible-easy-vpn/inventory.yml

# if [[ "$new_ssh_key_pair" =~ ^[yY]$ ]]; then
#   echo
#   read -p "Please enter your SSH public key: " ssh_key_pair

#   # sed will crash if the SSH key is multi-line
#   sed -i "s/# ssh_public_key: .*/ssh_public_key: ${ssh_key_pair}/g" $HOME/ansible-easy-vpn/inventory.yml || echo "Fixing the sed error..." && echo "    ssh_public_key: ${ssh_key_pair}" >> $HOME/ansible-easy-vpn/inventory.yml
# fi

# echo
# echo "Would you like to set up the e-mail functionality?"
# echo "It will be used to confirm the 2FA setup and restore the password in case you forget it"
# echo
# echo "This is optional"
# echo
# read -p "Set up e-mail? [y/N]: " email_setup
# until [[ "$email_setup" =~ ^[yYnN]*$ ]]; do
# 				echo "$email_setup: invalid selection."
# 				read -p "[y/N]: " email_setup
# done

# if [[ "$email_setup" =~ ^[yY]$ ]]; then
#   echo
#   read -p "SMTP server: " email_smtp_host
#   until [[ "$email_smtp_host" =~ ^[a-z0-9\.]*$ ]]; do
#     echo "Invalid SMTP server"
#     read -p "SMTP server: " email_smtp_host
#   done
#   echo
#   read -p "SMTP port [465]: " email_smtp_port
#   if [ -z ${email_smtp_port} ]; then
#     email_smtp_port="465"
#   fi
#   echo
#   read -p "SMTP login: " email_login
#   echo
#   read -s -p "SMTP password: " email_password
#   until [[ ! -z "$email_password" ]]; do
#     echo "The password is empty"
#     read -s -p "SMTP password: " email_password
#   done
#   echo
#   echo
#   read -p "'From' e-mail [${email_login}]: " email
#   if [ -z ${email} ]; then
#     email=$email_login
#   fi

#   sed -i "s/email_smtp_host: .*/email_smtp_host: ${email_smtp_host}/g" $HOME/ansible-easy-vpn/inventory.yml
#   sed -i "s/email_smtp_port: .*/email_smtp_port: ${email_smtp_port}/g" $HOME/ansible-easy-vpn/inventory.yml
#   sed -i "s/email_login: .*/email_login: ${email_login}/g" $HOME/ansible-easy-vpn/inventory.yml
#   sed -i "s/email: .*/email: ${email}/g" $HOME/ansible-easy-vpn/inventory.yml
# fi


# # Set secure permissions for the Vault file
# touch $HOME/ansible-easy-vpn/secret.yml
# chmod 600 $HOME/ansible-easy-vpn/secret.yml

# if [ -z ${email_password+x} ]; then
#   echo
# else
#   echo "email_password: ${email_password}" >> $HOME/ansible-easy-vpn/secret.yml
# fi

# echo "user_password: ${user_password}" >> $HOME/ansible-easy-vpn/secret.yml

# jwt_secret=$(openssl rand -hex 23)
# session_secret=$(openssl rand -hex 23)
# storage_encryption_key=$(openssl rand -hex 23)

# echo "jwt_secret: ${jwt_secret}" >> $HOME/ansible-easy-vpn/secret.yml
# echo "session_secret: ${session_secret}" >> $HOME/ansible-easy-vpn/secret.yml
# echo "storage_encryption_key: ${storage_encryption_key}" >> $HOME/ansible-easy-vpn/secret.yml

# echo
# echo "Encrypting the variables"
# ansible-vault encrypt $HOME/ansible-easy-vpn/secret.yml

# echo
# echo "Success!"
# read -p "Would you like to run the playbook now? [y/N]: " launch_playbook
# until [[ "$launch_playbook" =~ ^[yYnN]*$ ]]; do
# 				echo "$launch_playbook: invalid selection."
# 				read -p "[y/N]: " launch_playbook
# done

# if [[ "$launch_playbook" =~ ^[yY]$ ]]; then
#   cd $HOME/ansible-easy-vpn && ansible-playbook run.yml
# else
#   echo "You can run the playbook by executing the following command"
#   echo "cd ${HOME}/ansible-easy-vpn && ansible-playbook run.yml"
#   exit
# fi


# TEAMVIEWER:

# systemctl enable teamviewerd --now



# is this a work machine:

echo "Is this a work machine?"
read -p "y/n: " work_machine
until [[ "$work_machine" =~ ^[yYnN]*$ ]]; do
    echo "$work_machine: invalid selection."
    read -p "y/n: " work_machine
done

echo work_machine=$work_machine

# TODO: +work setup vpn
# TODO: +work +home setup code 
# TODO; +work +home setup docker



echo "Is this a laptop?"
read -p "y/n: " laptop
until [[ "$laptop" =~ ^[yYnN]*$ ]]; do
    echo "$laptop: invalid selection."
    read -p "y/n: " laptop
done

echo "Is this a desktop?"
read -p "y/n: " desktop
until [[ "$desktop" =~ ^[yYnN]*$ ]]; do
    echo "$desktop: invalid selection."
    read -p "y/n: " desktop
done

echo "Is this a server?"
read -p "y/n: " server
until [[ "$server" =~ ^[yYnN]*$ ]]; do
    echo "$server: invalid selection."
    read -p "y/n: " server
done

echo "Is this a virtual machine?"
read -p "y/n: " virtual_machine
until [[ "$virtual_machine" =~ ^[yYnN]*$ ]]; do
    echo "$virtual_machine: invalid selection."
    read -p "y/n: " virtual_machine
done






