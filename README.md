# QuickAppsServer (QAS) : script to install a few widely used web server apps
This script will performe a few checks (root, OS)
It will work for Ubuntu (16.04 +) & Debian (8 +). Il will NOT work for other OS.

This script will:
1/ Install basic apps (vim, mc, screen, htop, git, curl, ntp, ntpdate, sudo)
2 /Install web apps (Nginx, PHP 7.2-fpm, Mariadb, openssl, memcached)
4/ Install basic security apps (ufw firewall, fail2ban)
5/ Install Letsencrypt certbot
6/ Add and configure a system user (+sudo settings)
7/ Configure /etc/hosts and /etc/hostname
8/ Reboot
