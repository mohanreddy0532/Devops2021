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

rm -rf  /usr/share/nginx/html/*
STAT_CHECK $? "Download Frontend"

cd /tmp && unzip -o /tmp/frontend.zip  &>>${LOG_FILE}
STAT_CHECK $? "Extracting FrontEnd contenet"

cd /tmp/frontend-main/static && cp -r * /usr/share/nginx/html/
STAT_CHECK $? "Copying FrontEnd content"

cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT_CHECK $? "Update Nginx Config File"

systemctl enable nginx &>>${LOG_FILE} && systemctl restart nginx &>>${LOG_FILE}
STAT_CHECK $? "Restart NginX"