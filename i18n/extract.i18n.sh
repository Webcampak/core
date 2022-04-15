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
#declare -a supportLanguages=("fr_FR.utf8" "en_US.utf8")
declare -a supportLanguages=("fr_FR.utf8" "it_IT.UTF-8")

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') |                 Welcome to Webcampak 3 i18n Script                  |\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\             Do not start this script as root                   /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\             --------------------------------                   /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\                                                                /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\     This script analyze the code base to extract               /!\ \e[0m"
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') /!\     gettext string in preparation of translation               /!\ \e[0m"
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

sudo npm install po2json




echo -e "\e[32m$(date +'%d %B %Y - %k:%M') CLI: Listing all script files\e[0m"
find /home/${sysusername}/webcampak/apps/cli/webcampak/core/ -name *.py > /home/${sysusername}/webcampak/i18n/po/cli-files.txt
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') CLI: Searching within code and building POT file \e[0m"
xgettext -L Python --from-code UTF-8 -f /home/${sysusername}/webcampak/i18n/po/cli-files.txt -o /home/${sysusername}/webcampak/i18n/po/cli.pot
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') CLI: POT file created\e[0m"
rm /home/${sysusername}/webcampak/i18n/po/cli-files.txt

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Desktop: Listing all script files\e[0m"
find /home/${sysusername}/webcampak/apps/ui/Sencha/App6.0/workspace/Desktop/app/ -name *.js > /home/${sysusername}/webcampak/i18n/po/ui-desktop-files.txt
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Desktop: Searching within code and building POT file \e[0m"
xgettext -L Python --from-code UTF-8 -f /home/${sysusername}/webcampak/i18n/po/ui-desktop-files.txt -o /home/${sysusername}/webcampak/i18n/po/ui-desktop.pot #We use Python parser to parse javascript
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Desktop: POT file created\e[0m"
rm /home/${sysusername}/webcampak/i18n/po/ui-desktop-files.txt

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Dashboard: Listing all script files\e[0m"
find /home/${sysusername}/webcampak/apps/ui/Sencha/App6.0/workspace/Dashboard/app/ -name *.js > /home/${sysusername}/webcampak/i18n/po/ui-dashboard-files.txt
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Dashboard: Searching within code and building POT file \e[0m"
xgettext -L Javascript --from-code UTF-8 -f /home/${sysusername}/webcampak/i18n/po/ui-dashboard-files.txt -o /home/${sysusername}/webcampak/i18n/po/ui-dashboard.pot #We use Python parser to parse javascript
echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Dashboard: POT file created\e[0m"
rm /home/${sysusername}/webcampak/i18n/po/ui-dashboard-files.txt

echo -e "\e[32m$(date +'%d %B %Y - %k:%M') Press enter when translation is complete \e[0m"
read translationComplete
## now loop through the above array
for currentLanguage in "${supportLanguages[@]}"
do
    echo -e "\e[32m$(date +'%d %B %Y - %k:%M') UI Desktop: Generating files for language: ${currentLanguage} \e[0m"
    nodejs /home/${sysusername}/node_modules/po2json/bin/po2json /home/${sysusername}/webcampak/i18n/${currentLanguage}/LC_MESSAGES/ui-desktop.po /home/${sysusername}/webcampak/i18n/${currentLanguage}/LC_MESSAGES/ui-desktop.json -d jed1.x
    echo "var jsonLocaleData = " > /home/${sysusername}/webcampak/i18n/${currentLanguage}/LC_MESSAGES/ui-desktop.js
    cat /home/${sysusername}/webcampak/i18n/${currentLanguage}/LC_MESSAGES/ui-desktop.json >> /home/${sysusername}/webcampak/i18n/${currentLanguage}/LC_MESSAGES/ui-desktop.js
    echo ";" >> /home/${sysusername}/webcampak/i18n/${currentLanguage}/LC_MESSAGES/ui-desktop.js
done
