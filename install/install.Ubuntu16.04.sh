#!/bin/bash
# Copyright 2010-2016 Eurotechnia (support@webcampak.com)
# This file is part of the Webcampak project.
# Webcampak is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License,
# or (at your option) any later version.

# Webcampak is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with Webcampak.
# If not, see http://www.gnu.org/licenses/

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') |             Welcome to Webcampak 3 Installation Script              |\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\             Do not start this script as root                   /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\             --------------------------------                   /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\                                                                /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\     This script has been created to run on a fresh             /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\     Ubuntu 16.04 server installation.                          /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\                                                                /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') "
if [ "$(whoami)" = "root" ] ; then
	echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Warning: Do not run installation script as root, exiting ....\e[0m"
	exit 0
else
	sysusername=$(whoami)
	echo -e "\e[32m$(date +'%d %B %Y - %k:%M') You are currently connected as: $(whoami)\e[0m"
	cd /home/${sysusername}/
fi

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Distribution updated and upgrade\e[0m"
sudo apt-get update --assume-yes
sudo apt-get dist-upgrade --assume-yes

#Missing packages on ubunut 16.04: h264enc
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Software and dependencies installation\e[0m"
sudo apt-get update
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Installation of git and source control dependencies\e[0m"
sudo apt-get install --assume-yes git vim
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Installation of python and dependencies\e[0m"
sudo apt-get install --assume-yes python-imaging python-opencv python-rrdtool python-configobj python-setuptools python-gdata python-psutil python-dateutil python-numpy python-pip librrd-dev virtualenv
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Installation of picture processing related tools\e[0m"
sudo apt-get install --assume-yes imagemagick jpeginfo gphoto2 libjpeg8-dev zlib1g-dev libpuzzle-bin
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Installation of necessary tools to create video\e[0m"
sudo apt-get install --assume-yes mpgtx mencoder x264 libav-tools atomicparsley gpac
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Apache and PHP installation\e[0m"
sudo apt-get install --assume-yes apache2 php openssl php-cli libapache2-mod-php php-gd php-gettext php-sqlite3 vsftpd composer
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Misc and utilities\e[0m"
sudo apt-get install --assume-yes unzip ifstat lftp db5.3-util pwgen gettext npm
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Webcampak GIT: Cloning GIT repository\e[0m"
git clone --depth=1 https://github.com/Webcampak/core.git /home/${sysusername}/webcampak
cd /home/${sysusername}/webcampak
git submodule update --init --recursive
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Webcampak GIT: Completed\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') GRUB: Copy configuration files\e[0m"
sudo cp /home/${sysusername}/webcampak/install/config/default_grub /etc/default/grub
sudo cp /home/${sysusername}/webcampak/install/config/default_rcS /etc/default/rcS
#sudo cp /home/${sysusername}/webcampak/install/config/ttyS0.conf /etc/init/ttyS0.conf
#echo -e "\e[32m$(date +'%d %B %Y - %k:%M') GRUB Serial: sudo start ttyS0"
#sudo start ttyS0
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') GRUB: sudo update-grub2\e[0m"
sudo update-grub2
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') GRUB: Configuration completed\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Webcampak: System directory creation\e[0m"
mkdir /home/${sysusername}/webcampak/resources
mkdir /home/${sysusername}/webcampak/resources/cache
mkdir /home/${sysusername}/webcampak/resources/cache/symfony
mkdir /home/${sysusername}/webcampak/resources/cache/syncreports
mkdir /home/${sysusername}/webcampak/resources/database
mkdir /home/${sysusername}/webcampak/resources/emails
mkdir /home/${sysusername}/webcampak/resources/emails/failed
mkdir /home/${sysusername}/webcampak/resources/emails/queued
mkdir /home/${sysusername}/webcampak/resources/emails/sent
mkdir /home/${sysusername}/webcampak/resources/ftp
mkdir /home/${sysusername}/webcampak/resources/ftp/failed
mkdir /home/${sysusername}/webcampak/resources/ftp/process
mkdir /home/${sysusername}/webcampak/resources/ftp/queued
mkdir /home/${sysusername}/webcampak/resources/ftp/sent
mkdir /home/${sysusername}/webcampak/resources/logs
mkdir /home/${sysusername}/webcampak/resources/logs/symfony
mkdir /home/${sysusername}/webcampak/resources/logs/system
mkdir /home/${sysusername}/webcampak/resources/logs/stats
mkdir /home/${sysusername}/webcampak/resources/etc
mkdir /home/${sysusername}/webcampak/resources/watermark
mkdir /home/${sysusername}/webcampak/resources/audio
mkdir /home/${sysusername}/webcampak/resources/stats/
mkdir /home/${sysusername}/webcampak/resources/stats/consolidated/
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Setting up root crontab\e[0m"
sudo crontab /home/${sysusername}/webcampak/install/config/crontab.root
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Webcampak: Initialize configuration\e[0m"
php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console doctrine:schema:update --force
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Do you want to pre-create 3 sources ?\e[0m"
if [ "$1" == "nopreconfigure" ]; then
	echo -e "\e[32m$(date +'%d %B %Y - %k:%M') No parameter passed, the system will not be preconfigured with sources \e[0m"
	php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console wpak:dbinit
else
	echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Received request to preconfigure webcampak\e[0m"
	php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console wpak:dbinit --preconfigure
fi
# Without sources creation
#php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console wpak:dbinit


echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Webcampak: Installation of the CLI \e[0m"
cd /home/${sysusername}/webcampak/apps/cli/
sudo pip install -r requirements.txt
sudo python setup.py install
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Permissions and system modifications\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Adding user ${sysusername} to group www-data\e[0m"
sudo useradd -G www-data ${sysusername}
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Creating webcampak sudoers file\e[0m"
echo "${sysusername} ALL=(ALL) NOPASSWD: /usr/local/bin/webcampak system*" | sudo tee /etc/sudoers.d/webcampak
echo "${sysusername} ALL=(ALL) NOPASSWD: /sbin/reboot" | sudo tee -a /etc/sudoers.d/webcampak
echo "${sysusername} ALL=(ALL) NOPASSWD: /usr/bin/ifstat" | sudo tee -a /etc/sudoers.d/webcampak
#sudo echo "${sysusername} ALL=(ALL) NOPASSWD: /usr/local/bin/webcampak system*" > /etc/sudoers.d/webcampak
sudo chmod 0440 /etc/sudoers.d/webcampak
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') System: Adding usb to group plugdev\e[0m"
sudo sed -i 's/SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0664".*/SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0664", GROUP="plugdev"/g' /lib/udev/rules.d/50-udev-default.rules
sudo /etc/init.d/udev restart
#TODO: Add Webcampak SSH Public Keys

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Apache: Software configuration\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Apache: Stopping apache ...\e[0m"
sudo service apache2 stop
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Apache: Generation of ssl certificates\e[0m"
sudo make-ssl-cert generate-default-snakeoil --force-overwrite
sudo mkdir /etc/apache2/certs/
sudo mv /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/apache2/certs/cert.pem
sudo mv /etc/ssl/private/ssl-cert-snakeoil.key /etc/apache2/certs/cert.key
sudo cp /home/${sysusername}/webcampak/install/config/webcampak.apache2.conf /etc/apache2/sites-available/webcampak.conf
#	sudo cp /home/${sysusername}/webcampak/init/config/webcampak.php5 /etc/apache2/mods-available/php5.conf
sudo a2enmod ssl
sudo a2ensite webcampak
sudo a2dissite 000-default
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Apache: Updating configuration to run apache as: ${sysusername}\e[0m"
sudo sed -i "s/www-data/${sysusername}/" /etc/apache2/envvars
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Apache: Re-starting apache ...\e[0m"
sudo service apache2 start
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Apache: Configuration completed\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Vsftpd: Configuration of vsftpd\e[0m"
sudo mkdir /etc/vsftpd
sudo mkdir /etc/vsftpd/vsftpd_user_conf
sudo cp /home/${sysusername}/webcampak/install/config/vsftpd.conf /etc/vsftpd.conf
sudo sed -i "s/tmpusername/${sysusername}/" /etc/vsftpd.conf
sudo cp /home/${sysusername}/webcampak/install/config/vsftpd.pamd /etc/pam.d/vsftpd
sudo cp /home/${sysusername}/webcampak/install/config/vsftpd-wpresources /etc/vsftpd/vsftpd_user_conf/wpresources
sudo sed -i "s/tmpusername/${sysusername}/" /etc/vsftpd/vsftpd_user_conf/wpresources
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') #> sudo /etc/init.d/vsftpd restart\e[0m"
sudo service vsftpd restart
if [ -f /lib/x86_64-linux-gnu/security/pam_userdb.so ]; then
    sudo mkdir /lib/security
    sudo ln /lib/x86_64-linux-gnu/security/pam_userdb.so /lib/security/pam_userdb.so
fi
if [ -f /lib/i386-linux-gnu/security/pam_userdb.so ]; then
    sudo mkdir /lib/security
    sudo ln /lib/i386-linux-gnu/security/pam_userdb.so /lib/security/pam_userdb.so
fi
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Phidget: Drivers Installation (only if phidget board is installed)\e[0m"
mkdir /home/${sysusername}/softs/
cd /home/${sysusername}/softs/
sudo apt-get install --assume-yes build-essential make libusb-dev
#wget http://www.phidgets.com/downloads/libraries/libphidget_2.1.8.20110615.tar.gz
#wget http://www.phidgets.com/downloads/libraries/libphidget_2.1.8.20151217.tar.gz
wget https://www.phidgets.com/downloads/phidget21/libraries/linux/libphidget/libphidget_2.1.8.20170607.tar.gz
tar xfvz libphidget_2.1.8.20170607.tar.gz
cd libphidget-2.1.8.20170607
./configure; make;
sudo make install
sudo cp udev/99-phidgets.rules /etc/udev/rules.d
sudo udevadm control --reload
cd /home/${sysusername}/softs/
#wget http://www.phidgets.com/downloads/libraries/PhidgetsPython_2.1.8.20110804.zip
#wget http://www.phidgets.com/downloads/libraries/PhidgetsPython_2.1.8.20151217.zip
wget https://www.phidgets.com/downloads/phidget21/libraries/any/PhidgetsPython/PhidgetsPython_2.1.8.20170607.zip
unzip PhidgetsPython_2.1.8.20170607.zip
cd PhidgetsPython
python setup.py build
sudo python setup.py install
cd /home/${sysusername}/
sudo rm /home/${sysusername}/softs/ -r
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') -------------------------------------------------------\e[0m"

sed -i "s/tmppassword/$(pwgen -1)/" /home/${sysusername}/webcampak/config/config-general.cfg
sed -i "s/ThisTokenIsNotSoSecretChangeIt/$(pwgen -1)/" /home/${sysusername}/webcampak/config/param_general.yml

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Installation completed, Default User/Password are: root/webcampak you will be asked to change those at first connection\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Open your web browser and connect to https://WECAMPAK-IP/\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Exiting .....\e[0m"

