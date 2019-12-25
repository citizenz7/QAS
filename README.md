# QuickAppsServer (QAS)
### Script to install a few widely used web server apps
This script will perform a few checks (root, OS).

- It will work for Ubuntu (16.04 +) & Debian (8 +). Il will NOT work for other OS.

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

#### TODO
1. Propose more apps...
2. Install app one by one and chose what to install...
