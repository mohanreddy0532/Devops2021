#!/bin/bash

#Source will import the commands in common.
source components/common.sh


yum install nginx -y &>>${LOG_FILE}
STAT_CHECK  $?  "Nginx Install"

DOWNLOAD frontend

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