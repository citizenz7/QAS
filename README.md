# QuickAppsServer (QAS)
### Install a few widely used web server apps and configure the system
This script will perform a few checks (root, OS).

It will work for Ubuntu (16.04 +) & Debian (8 +). Il will NOT work for other OS.

This script will:
1. Install basic apps (vim, mc, screen, htop, git, curl, ntp, ntpdate, sudo)
2. Install web apps (Nginx, PHP 7.2-fpm, Mariadb, openssl, memcached)
3. Install basic security apps (ufw firewall, fail2ban)
4. Install Letsencrypt certbot (from PPA)
5. Add and configure a system user (+sudo settings)
6. Configure /etc/hosts and /etc/hostname
7. Reboot

Answer YES or NO to each 7 questions.

You can not install app separatly at the moment...

### HOW TO INSTALL
1. You need FIRST to reconfigure DASH: 
``dpkg-reconfigure dash``
then answer NO
2. Download the script from Github:
``wget``
3. Make this file executable:
``chmod +x install.sh``
4. Run the file:
``sh install.sh``

#### TODO
1. Propose more apps...
2. Install app one by one and chose what to install...
