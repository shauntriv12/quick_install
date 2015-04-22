#!/bin/bash

#php installation 
sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt

#Commands below adds "index.php" into dir.conf file
cd /etc/apache2/mods-enabled
sed -i "s/Director.*/DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm"/ dir.conf

#Commands below create test instance to check from browser.

cd /var/www
printf "<?php\nphpinfo();\n?>" > info.php

#To restart apache server:
sudo service apache2 restart

#To check, write ip/info.php on browser window.
#php installation is done.  
