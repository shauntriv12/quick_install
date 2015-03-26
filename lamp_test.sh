#!/bin/bash

#Full server installation scriept

#LAMP stack installation

#If anything goes wrong with execution of file or if encountered errors like 
# "bad interpreter: No such file or directory" , use dos2unix package to convert files into correct format.

#sudo apt-get install dos2unix
#dos2unix "File_name"

#install apache
sudo apt-get update
sudo apt-get -y install apache2

# -y automatically passes YES when asked during the execution

#That’s it. To check if Apache is installed, direct your browser 
#to your server’s IP address (eg. http://12.34.56.789). 
#The page should display the words “It works!" like this.

#You can run the following command to reveal your server’s IP address.
#ifconfig eth0 | grep inet | awk '{ print $2 }'



#MySQL installation

# root password: shaun44371!
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password shaun44371!'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password shaun44371!'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql

#there might be errors like: 
#E: Could not get lock /var/lib/dpkg/lock - open (11 Resource temporarily unavailable)
#E: Unable to lock the administration directory (/var/lib/dpkg/) is another process using it?
#E: dpkg was interrupted, you must manually run 'sudo dpkg --configure -a' to correct the problem.

#to solve, reboot the session.
#Then, input following commands:
#cd /var/lib/dpkg/updates
#sudo rm *
#sudo apt-get update

#MySQL is installed now. To activate :
sudo mysql_install_db

#Finish up by running the MySQL set up script:
# Expect package is used to do this task, so no need to execute command below:
#sudo /usr/bin/mysql_secure_installation

#script below completes mysql execution by answering all the necessary questions:

aptitude -y install expect
 

MYSQL_ROOT_PASSWORD=shaun44371!
 
SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")
 
echo "$SECURE_MYSQL"
 
#aptitude -y purge expect



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