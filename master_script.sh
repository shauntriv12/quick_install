#!/bin/bash

#Swap_space installation
/bin/bash /home/quick_install/swap_space.sh

#LAMP stack installation
#/bin/bash /home/script/lamp_stack_link.sh "Mysql password" 
#Mysql password is new password that user wants to keep foy mysql databases. 
/bin/bash /home/quick_install/lamp_stack_link.sh shaun

#Magento installation
#/bin/bash /home/script/lamp_stack_link.sh "Mysql password"
#Here, user have to enter password that they entered for mysql database, not a new one. 
/bin/bash /home/quick_install/magento.sh shaun



