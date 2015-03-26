#!/bin/bash

#phpmyadmin installation

#command below installs phpmyadmin:

sudo apt-get -q -y install phpmyadmin apache2-utils

#Variable declared below is the root password for mysql database. 
DBPASSWD="shaun44371!"

#Commands below performs quiet installation of phpmyadmin. 
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
