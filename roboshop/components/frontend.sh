#!/bin/bash

# source is nothing but import , like export command
source components/common.sh

yum install nginx -y &>>${LOG_FILE}
STAT_CHECK $? "Nginx Installation"

DOWNLOAD frontend

rm -rf /usr/share/nginx/html/*
STAT_CHECK $? "Remove old HTML Pages"

cd  /tmp/frontend-main/static/ && cp -r * /usr/share/nginx/html/
STAT_CHECK $? "Copying Frontend Content"

cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT_CHECK $? "Update Nginx Config File"

sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' \
       -e '/cart/ s/localhost/cart.roboshop.internal/' \
       -e '/user/ s/localhost/user.roboshop.internal/' \
       -e  '/shipping/ s/localhost/shipping.roboshop.internal/' \
       -e  '/payment/ s/localhost/payment.roboshop.internal/'  /etc/nginx/default.d/roboshop.conf
STAT_CHECK $? "Update Nginx Config File"

systemctl enable nginx &>>${LOG_FILE} && systemctl restart nginx &>>${LOG_FILE}
STAT_CHECK $? "Restart Nginx"
