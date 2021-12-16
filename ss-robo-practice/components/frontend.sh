#!/bin/bash

LOG_FILE=/tmp/roboshop.log
rm -rf ${LOG_FILE}

STAT_CHECK() {
 if [ $1 -ne 0 ]; then
   echo -e "\e[1;31m${2} - Failed\e[0m"
   exit 1
 else
    echo -e "\e[1;32m${2}  - SUCCESS\e[0m"
 fi
}

yum install nginx -y &>>${LOG_FILE}
STAT_CHECK  $?  "Nginx Install"

curl -f -s -L -o /tmp/frontend.zip  "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>${LOG_FILE}
STAT_CHECK  $?  "Download frontend"

cd /usr/share/nginx/html
rm -rf *
unzip -o /tmp/frontend.zip  &>>${LOG_FILE}
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf  &>>${LOG_FILE}
systemctl enable nginx
systemctl restart nginx
