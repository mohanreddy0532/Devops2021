#!/bin/bash

#To hide log after installation.
LOG_FILE=/tmp/roboshop.log
#Remove Log is already exits
rm -f ${LOG_FILE}

#To check Installatio is success or fail.
STAT_CHECK() {
  #if Exit status 1(fail) -ne 0(success) so its failed.
  if [ $1 -ne 0 ]; then
    echo -e "\e[1;31m${2} - FAILED\e[0m"
    exit 1
  else
    echo -e "\e[1;32m${2} - SUCCESS\e[0m"
  fi
}

#install Nginx
yum install nginx -y
#$? status of last command executed.
STAT_CHECK $? "Nginx Installation"

#Get frontend code and extract.
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zi"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md

#To Start nginx on system reboot
mv localhost.conf /etc/nginx/default.d/roboshop.conf

#To start Nginx and enable service
systemctl enable nginx
systemctl start nginx
