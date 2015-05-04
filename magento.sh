#!/bin/bash

#Security Enhanced Linux (SELinux) enables CentOS and Ubuntu administrators greater access control 
#over their servers. If you're using SELinux and Apache must initiate a connection to another host, 
#you must run the commands discussed in this section.

#sudo apt-get -y install selinux-utils
#getenforce
#sudo apt-get -y install policycoreutils
#setsebool -P apache2_can_network_connect=1
#reboot

sudo apt-get update

#To configer NTP server:

sudo apt-get -y install ntp

cd /etc
sed -i "s/server 0.*/server 0.us.pool.ntp.org"/ ntp.conf
sed -i "s/server 1.*/server 1.us.pool.ntp.org"/ ntp.conf
sed -i "s/server 2.*/server 2.us.pool.ntp.org"/ ntp.conf
sed -i "s/server 3.*/server 3.us.pool.ntp.org"/ ntp.conf
cd

service ntp restart 

#This script assumes that server already has lamp_stack and phpmyadmin installed 

#Now, we will create a database instant named "magento".

mysql --user=root --password=$1 -e "create database magento"


#Now, we will copy zip version of magento software into /var/www/magento folder.

#It can be downloaded from official magento website.
#Link: https://www.magentocommerce.com/products/downloads/magento/ - download full release generally. 
#Here, zip version is downloaded from above link and would be copied to server through wget command 
#using dropbox link.

#To install unzip package:
sudo apt-get -y install unzip
 
#In www, create a directory named magento. 

cd /var/www
mkdir magento
cd magento 
wget -O magento.zip https://www.dropbox.com/s/ndu8loekuatt0l1/magento-1.9.1.0-2015-02-09-10-10-49.zip%2C%20attachment?dl=1

#wget cpmmand above downloads file from the dropbox link and rename it to magento.zip

#Always remember to change last dl=o to dl=1 while using dropbox link.

#Now we will extract magento.zip file:

unzip magento.zip

#Now, we have to downoload the sample data from official magento site. 
#Link: https://www.magentocommerce.com/products/downloads/magento/

#Here, zip version is downloaded from above link and would be copied to server through wget command 
#using dropbox link.
#In www, create a directory named sample_data. 

cd
cd /var/www
mkdir sample_data
cd sample_data
wget -O sample_data.zip https://www.dropbox.com/s/lq2m73mf2dstqoy/magento-sample-data-1.9.1.0-2015-02-11-07-23-24.zip%2C%20attachment?dl=1

#wget cpmmand above downloads file from the dropbox link and rename it to sample_data.zip

#Always remember to change last dl=o to dl=1 while using dropbox link.

#Now, we will unzip sample_data.zip file.

unzip sample_data.zip

#Copying contents from sample_data's media directory to magento's media directory. 

cd
cd ..
cd /var/www/magento/magento/media
cp -R /var/www/sample_data/magento-sample-data-1.9.1.0/media/* .

##Copying contents from sample_data's skin directory to magento's skin directory. 

cd
cd ..
cd /var/www/magento/magento/skin
cp -R /var/www/sample_data/magento-sample-data-1.9.1.0/skin/* .

#Attaching sample_data's contents to "magento database" or mysql dump

cd
cd ..
cd /var/www/sample_data/magento-sample-data-1.9.1.0
mysql -u root -p $1 magento < /var/www/sample_data/magento-sample-data-1.9.1.0/magento_sample_data_for_1.9.1.0.sql

#Set permissions to all magento files and directories:

cd
cd ..
chmod -R 777 /var/www/magento

#Some additional packages are required to install to support magento:

sudo apt-get -y install php5-curl php5-gd
sudo service apache2 restart



#Magento is installed Now
#In your browser, type IP/magento/magento to setup magento !! 
