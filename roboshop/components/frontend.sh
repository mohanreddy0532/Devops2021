#!/bin/bash

# source is nothing but import , like export command
source components/common.sh

#To Set up out put lenngth waste one.
MAX_LENGTH=$(cat ${0}  | grep -v cat | grep STAT_CHECK | awk -F '"' '{print $2}'  | awk '{ print length }'  | sort  | tail -1)

yum install nginx -y &>>${LOG_FILE}
STAT_CHECK $? "Nginx Installation"

DOWNLOAD frontend

rm -rf /usr/share/nginx/html/*
STAT_CHECK $? "Remove old HTML Pages"

cd  /tmp/frontend-main/static/ && cp -r * /usr/share/nginx/html/
STAT_CHECK $? "Copying Frontend Content"

cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT_CHECK $? "Update Nginx Config File"

systemctl enable nginx &>>${LOG_FILE} && systemctl restart nginx &>>${LOG_FILE}
STAT_CHECK $? "Restart Nginx"