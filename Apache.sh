#!/bin/bash

#install apache
sudo apt-get update
sudo apt-get -y install apache2

# -y automatically passes YES when asked during the execution

#That’s it. To check if Apache is installed, direct your browser 
#to your server’s IP address (eg. http://12.34.56.789). 
#The page should display the words “It works!" like this.

#You can run the following command to reveal your server’s IP address.
#ifconfig eth0 | grep inet | awk '{ print $2 }'