# Ansible NAS
Manjaro playbook on github
pasted into workstation roles



# TO DEPLOY:
Bookstack



## TO BE ADDED:
* syncthing
* ubooquiti
* Chowdown
* System-Cockpit
* Grocy
* Hubzilla
* Inventario
* Pi-hole
* PrivateBin
* Ubooquity
* Watchtower
* WebTrees
* Firefly III
* Grafana
* HealthChecks
* Speedtest
* matrix riot.io /matrix
* rocketchat

* Authelia + SQL DB
* Traefik v2
* autoindex
* phpmyadmin
* jdownloader
* NZBHYDRA
* PhotoShow - Image Gallery
* Picard - Music Library Tagging and Management
* Handbrake - Video Conversion (Transcoding and compression)
* MakeMKV - Video Editing (Ripping from Disks)
* Firefox - Web Broswer
* Glances - System Information
* qDirStat - Directory Statistics
* Guacamole - Remote desktop, SSH, on Telnet on any HTML5 Browser
* StatPing - Status Page & Monitoring Server
* SmokePing - Network latency Monitoring
* VSCode - VSCode Editing



## COOL LINKS:
this is how i should structure the project.
https://github.com/LearnLinuxTV/personal_ansible_desktop_configs


this project is forked from this
https://github.com/davestephens/ansible-nas


https://docs.ansible.com/ansible/latest/user_guide/playbooks.html
https://stackoverflow.com/questions/33155459/ansible-how-to-run-a-play-with-hosts-with-different-passwords
https://stackoverflow.com/questions/33155459/ansible-how-to-run-a-play-with-hosts-with-different-passwords
https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html


How does it work?

As mentioned above, it uses Ansible pull, so some familiarity with that is required. Luckily for you, I have a few videos on my channel that describes how Ansible pull works. Check out the LearnLinuxTV channel, the videos can be found in the Ansible playlist. I use Ansible in "pull-mode" because it handles the dynamic nature of laptops and desktops better. Afterall, they aren't always turned on. And I don't like to maintain multiple things for one purpose, so I have the same repo configuring servers as well.

The folder structure breaks down like this:

local.yml: This is the Playbook that Ansible expects to find by default in pull-mode, think of it as an "index" of sorts that pulls other Playbooks in.

ansible.cfg: Configuration settings for Ansible goes here.

group_vars/: This directory is where I can place variables that will be applied on every system.

host_vars/: Each laptop/desktop/server gets a host_vars file in this folder, named after its hostname. Sets variables specific to that computer.

hosts: This is the inventory file. Even in pull-mode, an inventory file can be used. This is how Ansible knows what group to put a machine in.

playbooks: Additional playbooks that I may want to run, or have triggered.

roles/: This directory contains my base, workstation, and server roles. Every host gets the base role. Then either 'workstation' or 'server', depending on what it is.

roles/base: This role is for every host, regardles of the type of device it is. This role contains things that are intended to be on every host, such as default configs, users, etc.

roles/workstation: After the base role runs on a host, this role runs only on hosts that are designated to be workstations. GUI-specific things, such as GUI apps (Firefox, etc), Flatpaks, wallpaper, etc. Has a folder for the GNOME and MATE desktops.

roles/server: After the base role runs on a host, this role runs only on hosts designated as servers. Monitoring plugins, unattended-updates, server firewall rules, and other server-related things are configured here.

After it's run for the first time manually, this Ansible config creates its own Cronjob for itself on that machine so you never have to run it manually again going forward, and it will track all future commits and run them against all your machines as soon as you commit a change. You can find the playbook for Cron in the base role.


https://jawher.me/wireguard-ansible-systemd-ubuntu/

TODO: when you install docker add user to docker group.



https://gitlab.com/nodiscc/xsrv
https://github.com/debops/debops



$ ansible-galaxy init test-role-1

https://netboot.xyz/docs/docker

https://github.com/m1k1o/neko

https://homechart.app/


TODO: nginxproxymanager

version: '3'
services:
  nginx-proxy-manager:
    image: jlesage/nginx-proxy-manager
    ports:
      - "8181:8181"
      - "8080:8080"
      - "4443:4443"
    volumes:
      - "/docker/appdata/nginx-proxy-manager:/config:rw"


https://old.reddit.com/r/sysadmin/comments/sd6esu/powershell_master_class_lesson_one_passed_300000/
https://old.reddit.com/r/selfhosted/comments/sdcfk9/my_dashboard_after_learning_about_selfhosting/


https://github.com/AlexNabokikh/windows-playbook
https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse#install-openssh-using-powershell
https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse#start-and-configure-openssh-server



required vars:
media_home:
docker_home:


## IDEAS:
https://leucos.github.io/ansible-files-layout#fnref:1



## ANSIBLE VAULT:
ansible-vault create vault.yml
ansible-vault edit vault.yml
ansible-vault decrypt secure.yml
ansible-playbook --ask-vault-pass email.yml
ansible-vault rekey

---
- hosts: localhost
  vars_files: secret.yml
  tasks:
  - name: Sending an email using Ansible
    mail:
      host: smtp.gmail.com
      port: 587
      username: "{{ email_user }}"
      password: "{{ p }}"
      to: "{{ email_to }}"
      subject: Email By Ansible
      body: Test successful
      delegate_to: localhost



TO BE DEPLOYED:

openldap
postgres


linux hosts file
windows hosts file


windows ssh config
linux ssh config


- [ ] make an ansible-ans user and take the uid and guid and add it to all docker apps 


https://ipinfo.io/ can be used to check if you are ireland or not
- [ ] write local ip to container and use cat to check if the ip is the same 


- [ ] pick between manjaro / EndeavourOS / arch with archinstall command and gnome


benefits of KDE:
looks nice



benefits of GNOME:
wayland
multi screen can do different res with wayland



## TODO:
wallpapers
endeavour wallpapers

playbook that does system updates and has roles for each distro with a reboot flag


move esc to caps lock gnome 
change alt tab to be swap windows gnome

fonts
install both from aur
iosevka
source code pro

obsidian fonts



thunderbird accounts
telegram sync
mattermost login
discord login




install endeavour os with gnome maybe i3


## AUR Packages:
downgrade
informant


TODO: for ansible user i should add https://askubuntu.com/questions/192050/how-to-run-sudo-command-with-no-password



TODO: add a script that hardlinks all the audiobooks to the audiobooks folder.





TODO: script that take password for bitwarden from me,
uses that to login to bitwarden get vault pass and unlock ssh keys and move them to all machines.


https://github.com/brunelli/gnome-shell-extension-installer


https://github.com/PeterMosmans/ansible-role-customize-gnome