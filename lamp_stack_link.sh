#!/bin/bash

#Apache installation
/bin/bash /home/quick_install/Apache.sh


#Mysql installation
/bin/bash /home/quick_install/Mysql.sh $1
# "$1" in the command above is Mysql password taken from 1st command line argument.  


#php installation
/bin/bash /home/quick_install/php.sh