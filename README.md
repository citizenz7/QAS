# QuickAppsServer (QAS)
#### WHAT IS IT?
- It's a very simple and quite basic script to install apps you need to start a web server on Ubuntu or Debian (web server, MySQL server, basic editing apps, basic security apps, etc.)
- This script will perform a few checks (root, OS).
- It will work for Ubuntu (16.04 +) & Debian (8 +). Il will NOT work for other OS.
- It will install a few widely used web server apps and configure the system (hosts, hostname, system user with sudo settings, ...)

This script will:
1. Install basic apps (vim, mc, screen, htop, git, curl, ntp, ntpdate, sudo, dnsutils)
2. Install web apps (Nginx, php-fpm, Mariadb, openssl, memcached)
3. Install basic security apps (ufw firewall, fail2ban)
4. Install Letsencrypt certbot
5. Add and configure a system user (+ sudo settings)
6. Configure /etc/hosts
7. Configure /etc/hostname
8. Reboot

Answer YES or NO to each question.

##### You can not install app separatly at the moment.

#### HOW TO INSTALL
1. You need FIRST to reconfigure DASH: 
``dpkg-reconfigure dash``
and answer **NO**
2. Download the script from Github:
``wget https://raw.githubusercontent.com/citizenz7/QAS/master/install.sh``
3. Make the script executable:
``chmod +x install.sh``
4. Run the file **as root**:
``sh install.sh``

#### TODO
1. Install more apps...
2. Install app one by one (separatly)...
3. Create a specific apps installation process based on the OS (Ubuntu based install + Debian based install)...
4. Create a specific apps installation process based on the OS version (codename)...
