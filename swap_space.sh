#!/bin/bash

#swap file installation 

#You need to use the dd command to create swap file. 
#The mkswap command is used to set up a Linux swap area on a device or in a file.


#Switch to the root user by typing following command:

#sudo -s

#Type the following command to create 512MB swap file (1024 * 512MB = 524288 block size):

dd if=/dev/zero of=/swapfile1 bs=1024 count=524288

#Sample output should be:

#524288+0 records in
#524288+0 records out
#536870912 bytes (537 MB) copied, 3.23347 s, 166 MB/s

#security of the swap file:

chown root:root /swapfile1
chmod 755 /swapfile1

#Set up a linux swap area:

mkswap /swapfile1

#Enabling the swap file:

swapon /swapfile1

#Update /etc/fstab file
#commands below append following text into fstab file. 

sed -i '$a /swapfile1 none swap sw 0 0' /etc/fstab 


#To verify if swap is activated:

#free -m

#To display swap summary usage:

#swapon -s

#Sample output could be:

#Filename				Type		Size	Used	Priority
#/dev/sda6              partition	4194296	0		0
#/swapfile1             file		524280	0	    -1














