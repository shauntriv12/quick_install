#!/bin/bash


#MySQL installation

#root password variable:

#command below takes 1st command line argument as root password and assignes it to MYSQL_ROOT_PASSWORD variable.
MYSQL_ROOT_PASSWORD=$1

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
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