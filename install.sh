#!/bin/bash

#################################################################################
# QuickAppsServer (QAS)
# For Ubuntu (16.04 +) && Debian (8 +)
# 1/Install basic apps
# 2/Create system user
# 3/Install web apps: Nginx, PHP 7.2-fpm, Mariadb (MySQL)
# 4/Install basic security apps
# 5/Configure /etc/hosts and /etc/hostname
# 6/Reboot
# Copyleft 2019 - Olivier Prieur "citizenz" - citizenz7@protonmail.com
# Blog: https://www.citizenz.info
# License: GPL v3 (https://www.gnu.org/licenses/quick-guide-gplv3.en.html)
#################################################################################

#Script Console Colors
black=$(tput setaf 0); red=$(tput setaf 1); green=$(tput setaf 2); yellow=$(tput setaf 3);
blue=$(tput setaf 4); magenta=$(tput setaf 5); cyan=$(tput setaf 6); white=$(tput setaf 7);
on_red=$(tput setab 1); on_green=$(tput setab 2); on_yellow=$(tput setab 3); on_blue=$(tput setab 4);
on_magenta=$(tput setab 5); on_cyan=$(tput setab 6); on_white=$(tput setab 7); bold=$(tput bold);
dim=$(tput dim); underline=$(tput smul); reset_underline=$(tput rmul); standout=$(tput smso);
reset_standout=$(tput rmso); normal=$(tput sgr0); alert=${white}${on_red}; title=${standout};
sub_title=${bold}${yellow}; repo_title=${black}${on_green}; message_title=${white}${on_magenta}

#################################################################################
# various checks
#################################################################################
#check if Ubuntu or Debian
DISTRO=$(lsb_release -is)
RELEASE=$(lsb_release -rs)
CODENAME=$(lsb_release -cs)
SETNAME=$(lsb_release -rc)

echo
echo "${repo_title}                                                             ${normal} "
echo "${repo_title} ${bold}${white}QuickAppsServer Installation (QAS)                          ${normal} "
echo "${repo_title}                                                             ${normal} "
echo "${title} URL: https://github.com/citizenz7/QAS                       ${normal} "
echo "${title}                                                             ${normal} "
echo "${title} Welcome!                                                    ${normal} "
echo "${title} QuickAppsServer works with Ubuntu 16.04+ and Debian 8+ OS.  ${normal} "
echo "${title} The script will perform some checks then install a few apps ${normal} "
echo "${title} and reboot the server.                                      ${normal} "
echo "${title}                                                             ${normal} "
echo "${message_title}                                                             ${normal} "
echo "${message_title} ${bold}${white}Please answer a few short questions. Let's go!              ${normal} "
echo "${message_title}                                                             ${normal} "
echo
echo "${green}Checking distribution ...${normal}"
if [ ! -x  /usr/bin/lsb_release ]; then
  echo "It looks like you are running $DISTRO, which is not supported by QuickAppsServer."
  echo "Exiting..."
  exit 1
fi

echo "$(lsb_release -a)"

if [[ ! $DISTRO =~ ^(Ubuntu|Debian)$ ]]; then
  echo "$DISTRO: ${alert} It looks like you are running $DISTRO, which is not supported by QuickAppsServer :/ ${normal} "
  echo "Exiting..."
  exit 1
fi
echo
if [[ ! $CODENAME =~ ^(focal|xenial|eoan|disco|bionic|cosmic|artful|zesty|yakkety|buster|stretch|jessie)$ ]]; then
  echo "$CODENAME: ${alert} It looks like you are running $DISTRO $RELEASE '$CODENAME', which is not supported by QuickAppsServer :/ ${normal} "
  echo "Exiting..."
  exit 1
fi

#check if root
if [ "$EUID" -ne 0 ]; then 
  echo "${alert}${bold} ERROR!                                                      ${normal} "
  echo "${alert}${bold} --> Please run this script as root!                         ${normal} "
  echo "${alert}${bold} --> Exiting!                                                ${normal} "
  echo
  exit 1
fi

echo "The script will now update & upgrade the system and then will install a few important apps."
echo "Some questions will be asked after this."
echo "Please be patient."
echo

#################################################################################
# Make a pause before installing...
#################################################################################
read -n 1 -s -r -p "Press any key to continue"

#################################################################################
# update, upgrade, install, configure,... reboot
#################################################################################
#update & upgrade system
apt-get update
apt-get upgrade -y
apt-get autoremove

#install important apps... if not yet installed
#same for Debian & Ubuntu
apt-get install sudo dnsutils

#install basic apps ?
echo -n 'Do you want to install basic apps (mc, screen, htop, vim, curl, git, ntp, ntpdate, dos2unix, zip, unzip)? (y|n)'
read apps
if [[ $apps =~ ^(y|Y|yes|YES)$ ]]; then
	apt-get install -y mc screen htop vim-nox curl git ntp ntpdate dos2unix zip unzip
fi

#install web apps ?
echo -n 'Do you want to install web apps (nginx, mariadb-server, php-fpm, php-mysql, openssl, memcached, php-memcache)? (y|n)'
read appsweb
if [[ $appsweb =~ ^(y|Y|yes|YES)$ ]]; then
	apt install -y nginx mariadb-server php-fpm php-mysql openssl memcached php-memcache
fi

#install security apps ?
echo -n 'Do you want to install security apps (ufw firewall, fail2ban)? (y|n)'
read appssecurity
if [[ $appssecurity =~ ^(y|Y|yes|YES)$ ]]; then
	apt install -y ufw fail2ban 
fi

#install cerbot (letsencrypt) ?
echo -n 'Do you want to install HTTPS certificat Letsencrypt (cerbot)? (y|n)'
read letsencrypt
if [[ $letsencrypt =~ ^(y|Y|yes|YES)$ ]]; then
	apt install -y python3-acme python3-certbot python3-mock python3-openssl python3-pkg-resources python3-pyparsing python3-zope.interface
	apt install -y python3-certbot-nginx
fi

#add a system user
echo -n 'Do you want to add a system user? (y|n)'
read user
if [[ $user =~ ^(y|Y|yes|YES)$ ]]; then
	# Script to add a user to Linux system
	read -p "Enter username: " username
	read -p "Enter password: " password
	read -p "Enter password (again): " password2

	egrep "^$username" /etc/passwd >/dev/null

	if [ $? -eq 0 ]; then
		echo "$username already exists! Exiting!"
		exit 1
	else
		# check if passwords match and if not ask again
		while [ "$password" != "$password2" ];
		do
			echo 
			echo "Password mismatch. Please try again"
			read -p "Enter password: " password
			echo
			read -p "Enter password (again): " password2
		done

		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -s /bin/bash -p $pass $username
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
	# Add user to sudo group?
	echo -n 'Do you want to add the user to sudo group? (y|n)'
	read sudo
	if [[ $sudo =~ ^(y|Y|yes|YES)$ ]]; then
		adduser $username sudo
	fi
fi

#setting /etc/hosts
echo -n 'Do you want to configure /etc/hosts? (y|n)'
read hosts
if [[ $hosts =~ ^(y|Y|yes|YES)$ ]]; then
	read -p "Enter hostname FQDN (ex: serv1.example.com): " fqdn
	IP=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
	echo -e "127.0.0.1 localhost.localdomain localhost\n\n$IP ${fqdn}">/etc/hosts
fi

#setting /etc/hostname
echo -n 'Do you want to configure /etc/hostname? (y|n)'
read hostname
if [[ $hostname =~ ^(y|Y|yes|YES)$ ]]; then
	read -p "Enter hostname FQDN (ex: serv1.example.com): " fqdn
	#hostnamectl set-hostname $fqdn
	echo "${fqdn}">/etc/hostname
fi

#then reboot if ok
echo -n 'Do you want to reboot the server now? (y|n)'
read reboot
if [[ $reboot =~ ^(y|Y|yes|YES)$ ]]; then
	reboot
else
	exit 0
fi
