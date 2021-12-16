#!/bin/bash

source components/common.sh

#Setup MongoDB repos.
## curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
#Install Mongo & Start Service.
## yum install -y mongodb-org
## systemctl enable mongod
## systemctl start mongod
#Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file
#Config file: /etc/mongod.conf
#
#then restart the service
#
## systemctl restart mongod
#Every Database needs the schema to be loaded for the application to work.
#Download the schema and load it.
#
## curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
#
## mongo < catalogue.js
## mongo < users.js
#
#Symbol < will take the input from a file and give that input to the command.

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
STAT_CHECK $? "Download MongoDB Repo"

yum install -y mongodb-org &>>${LOG_FILE}
STAT_CHECK $? "Install MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG_FILE}
STAT_CHECK $? "Update MOngoDB Service"

systemctl enable mongod &>>${LOG_FILE} && systemctl start mongod &>>${LOG_FILE}
STAT_CHECK $? "Enable and Start MongoD"

DOWNLOAD mongodb

cd /tmp/mongodb-main
mongo < catalogue.js &>>${LOG_FILE} && mongo < users.js &>>${LOG_FILE}
STAT_CHECK $? "Load Schema"
