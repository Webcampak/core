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

echo "$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "$(date +'%d %B %Y - %k:%M') |             Welcome to Webcampak 3 Installation Script              |"
echo "$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "$(date +'%d %B %Y - %k:%M') /!\             Do not start this script as root                   /!\ "
echo "$(date +'%d %B %Y - %k:%M') /!\             --------------------------------                   /!\ "
echo "$(date +'%d %B %Y - %k:%M') /!\                                                                /!\ "
echo "$(date +'%d %B %Y - %k:%M') /!\     This script has been created to run on a fresh             /!\ "
echo "$(date +'%d %B %Y - %k:%M') /!\     Ubuntu 16.04 server installation.                          /!\ "
echo "$(date +'%d %B %Y - %k:%M') /!\                                                                /!\ "
echo "$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "$(date +'%d %B %Y - %k:%M') "
scriptdirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ "$(whoami)" = "root" ] ; then
	echo "$(date +'%d %B %Y - %k:%M') Warning: Do not run installation script as root, exiting ...."
	exit 0
else
	sysusername=$(whoami)
	echo "$(date +'%d %B %Y - %k:%M') You are currently connected as: $(whoami)"
	cd /home/${sysusername}/
fi

echo "$(date +'%d %B %Y - %k:%M') System: Distribution upgrade"
echo "$(date +'%d %B %Y - %k:%M') #> sudo apt-get update"
sudo apt-get update --assume-yes
echo "$(date +'%d %B %Y - %k:%M') #> sudo apt-get dist-upgrade"
sudo apt-get dist-upgrade --assume-yes

#Missing packages on ubunut 16.04: h264enc
echo "$(date +'%d %B %Y - %k:%M') System: Software and dependencies installation"
sudo apt-get update
echo "$(date +'%d %B %Y - %k:%M') System: Installation of git and source control dependencies"
sudo apt-get install --assume-yes git vim
echo "$(date +'%d %B %Y - %k:%M') System: Installation of python and dependencies"
sudo apt-get install --assume-yes python-imaging python-opencv python-rrdtool python-configobj python-setuptools python-gdata python-psutil python-dateutil python-numpy
echo "$(date +'%d %B %Y - %k:%M') System: Installation of picture processing related tools"
sudo apt-get install --assume-yes imagemagick jpeginfo gphoto2 libjpeg8-dev zlib1g-dev libpuzzle-bin
echo "$(date +'%d %B %Y - %k:%M') System: Installation of necessary tools to create video"
sudo apt-get install --assume-yes imagemagick mpgtx mencoder x264 libav-tools atomicparsley
echo "$(date +'%d %B %Y - %k:%M') System: Apache and PHP installation"
sudo apt-get install --assume-yes apache2 php openssl php-cli libapache2-mod-php php-gd php-gettext php-sqlite3 vsftpd
echo "$(date +'%d %B %Y - %k:%M') System: Misc and utilities"
sudo apt-get install --assume-yes unzip ifstat lftp db5.3-util
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') Webcampak GIT: Cloning GIT repository"
git clone --depth=1 https://github.com/Webcampak/core.git /home/${sysusername}/webcampak
cd /home/${sysusername}/webcampak
git submodule update --init --recursive
echo "$(date +'%d %B %Y - %k:%M') Webcampak GIT: Completed"
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') GRUB: Copy configuration files"
sudo cp /home/${sysusername}/webcampak/install/config/default_grub /etc/default/grub
sudo cp /home/${sysusername}/webcampak/install/config/default_rcS /etc/default/rcS
#sudo cp /home/${sysusername}/webcampak/install/config/ttyS0.conf /etc/init/ttyS0.conf
#echo "$(date +'%d %B %Y - %k:%M') GRUB Serial: sudo start ttyS0"
#sudo start ttyS0
echo "$(date +'%d %B %Y - %k:%M') GRUB: sudo update-grub2"
sudo update-grub2
echo "$(date +'%d %B %Y - %k:%M') GRUB: Configuration completed"
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') Webcampak: System directory creation"
mkdir /home/${sysusername}/webcampak/resources
mkdir /home/${sysusername}/webcampak/resources/cache
mkdir /home/${sysusername}/webcampak/resources/cache/symfony
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
mkdir /home/${sysusername}/webcampak/resources/etc
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') System: Setting up root crontab"
sudo crontab /home/${sysusername}/webcampak/install/config/crontab.root
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') Webcampak: Initialize configuration"
php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console doctrine:schema:update --force
echo "$(date +'%d %B %Y - %k:%M') System: Do you want to pre-create 3 sources ?"
echo "$(date +'%d %B %Y - %k:%M') System: [x]-Exit [y]-Yes [n]-No"
read action
if [ "$action" = "x" ] ; then
    exit;
elif [ "$action" = "y" ] ; then
    php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console wpak:dbinit --preconfigure
elif [ "$action" = "n" ] ; then
    php /home/${sysusername}/webcampak/apps/api/Symfony/3.0/bin/console wpak:dbinit
fi

echo "$(date +'%d %B %Y - %k:%M') System: Permissions and system modifications"
echo "$(date +'%d %B %Y - %k:%M') System: [x]-Exit [s]-Skip [o]-OK"
read action
if [ "$action" = "x" ] ; then
	exit;
elif [ "$action" = "o" ] ; then
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: Open a separate terminal and write down below commands:"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: #> sudo su"
	read
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: Define 'root' password"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: #> passwd"
	read
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: Add ${sysusername} user to www-data group"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: #> vim /etc/group"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: Edit the following line: www-data:x:33:${sysusername}"
	read
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: Modification of sudoers file"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: #> visudo"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:    Add the following line at the end of the file: "
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:       ${sysusername} ALL=(ALL) NOPASSWD: /usr/bin/python /home/webcampak/webcampak/bin/wpak-createlocalftpaccounts.py*"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:       ${sysusername} ALL=(ALL) NOPASSWD: /usr/bin/python /home/webcampak/webcampak/bin/wpak-cronupdatefile.py*"

	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:    Add a blank line, save and exit"
	read
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: Modification of udev file"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action: #> vim /lib/udev/rules.d/50-udev-default.rules"
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:    Replace: "
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:       # libusb device nodes "
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:       SUBSYSTEM==\"usb\", ENV{DEVTYPE}==\"usb_device\", MODE=\"0664\""
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:    With: "
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:       # libusb device nodes "
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:       SUBSYSTEM==\"usb\", ENV{DEVTYPE}==\"usb_device\", MODE=\"0664\", GROUP=\"plugdev\""
	echo "$(date +'%d %B %Y - %k:%M') System: ==> Action:    Save and exit"
	read
	sudo /etc/init.d/udev restart
fi
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

# chmod +x /home/${sysusername}/webcampak/bin/*.py

echo "$(date +'%d %B %Y - %k:%M') Apache: Software configuration"
echo "$(date +'%d %B %Y - %k:%M') Apache: Stopping apache ..."
sudo service apache2 stop
echo "$(date +'%d %B %Y - %k:%M') Apache: Generation of ssl certificates"
sudo make-ssl-cert generate-default-snakeoil --force-overwrite
sudo mkdir /etc/apache2/certs/
sudo mv /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/apache2/certs/cert.pem
sudo mv /etc/ssl/private/ssl-cert-snakeoil.key /etc/apache2/certs/cert.key
sudo cp /home/${sysusername}/webcampak/init/config/webcampak.apache.conf /etc/apache2/sites-available/webcampak.conf
#	sudo cp /home/${sysusername}/webcampak/init/config/webcampak.php5 /etc/apache2/mods-available/php5.conf
sudo a2enmod ssl
sudo a2ensite webcampak
sudo a2dissite 000-default
echo "$(date +'%d %B %Y - %k:%M') Apache: Updating configuration to run apache as: ${sysusername}"
sudo sed -i "s/www-data/${sysusername}/" /etc/apache2/envvars
echo "$(date +'%d %B %Y - %k:%M') Apache: Re-starting apache ..."
sudo service apache2 start
echo "$(date +'%d %B %Y - %k:%M') Apache: Configuration completed"
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"



echo "$(date +'%d %B %Y - %k:%M') Vsftpd: Configuration of vsftpd"
echo "$(date +'%d %B %Y - %k:%M') #> sudo mkdir /etc/vsftpd"
echo "$(date +'%d %B %Y - %k:%M') #> sudo mkdir /etc/vsftpd/vsftpd_user_conf"
echo "$(date +'%d %B %Y - %k:%M') #> sudo cp /home/${sysusername}/webcampak/init/config/vsftpd.conf /etc/vsftpd.conf"
sudo mkdir /etc/vsftpd
sudo mkdir /etc/vsftpd/vsftpd_user_conf
sudo cp /home/${sysusername}/webcampak/init/config/vsftpd.conf /etc/vsftpd.conf
sudo cp /home/${sysusername}/webcampak/init/config/vsftpd.pamd /etc/pam.d/vsftpd
sudo cp /home/${sysusername}/webcampak/init/config/vsftpd-wpresources /etc/vsftpd/vsftpd_user_conf/wpresources
echo "$(date +'%d %B %Y - %k:%M') #> sudo /etc/init.d/vsftpd restart"
sudo service vsftpd restart
if [ -f /lib/x86_64-linux-gnu/security/pam_userdb.so ]; then
        sudo mkdir /lib/security
        sudo ln /lib/x86_64-linux-gnu/security/pam_userdb.so /lib/security/pam_userdb.so
fi
if [ -f /lib/i386-linux-gnu/security/pam_userdb.so ]; then
        sudo mkdir /lib/security
        sudo ln /lib/i386-linux-gnu/security/pam_userdb.so /lib/security/pam_userdb.so
fi

echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') Phidget: Drivers Installation (only if phidget board is installed)"
echo "$(date +'%d %B %Y - %k:%M') Phidget: [x]-Exit [s]-Skip [o]-OK"
read action
if [ "$action" = "x" ] ; then
	exit;
elif [ "$action" = "o" ] ; then
	mkdir /home/${sysusername}/softs/
	cd /home/${sysusername}/softs/
	sudo apt-get install build-essential make libusb-dev
	wget http://www.phidgets.com/downloads/libraries/libphidget_2.1.8.20110615.tar.gz
	tar xfvz libphidget_2.1.8.20110615.tar.gz
	cd libphidget-2.1.8.20110615
	./configure; make;
	sudo make install
	cd /home/${sysusername}/softs/
	wget http://www.phidgets.com/downloads/libraries/PhidgetsPython_2.1.8.20110804.zip
	unzip PhidgetsPython_2.1.8.20110804.zip
	cd PhidgetsPython
	python setup.py build
	sudo python setup.py install
	cd /home/${sysusername}/
	sudo rm /home/${syvsusername}/softs/ -r
fi
echo "$(date +'%d %B %Y - %k:%M') -------------------------------------------------------"

echo "$(date +'%d %B %Y - %k:%M') Installation completed, Default User/Password are: root/webcampak you will be asked to change those at first connection"
echo "$(date +'%d %B %Y - %k:%M') Open your web browser and connect to https://WECAMPAK-IP/"
echo "$(date +'%d %B %Y - %k:%M') Exiting ....."

