#!/bin/bash

source components/common.sh

MAX_LENGTH=$(cat ${0}  | grep -v cat | grep STAT_CHECK | awk -F '"' '{print $2}'  | awk '{ print length }'  | sort  | tail -1)


### MongoDB Setup
echo -e "        ------>>>>>> \e[1;35mMongoDB Setup\e[0m <<<<<<------"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG_FILE}
STAT_CHECK $? "Download MongoDB repo"


yum install -y mongodb-org &>>${LOG_FILE}
STAT_CHECK $? "Install MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG_FILE}
STAT_CHECK $? "Update MongoDB Service"

systemctl enable mongod &>>${LOG_FILE} && systemctl restart mongod &>>${LOG_FILE}
STAT_CHECK $? "Start MongoDB Service"

DOWNLOAD mongodb

cd /tmp/mongodb-main
mongo < catalogue.js &>>${LOG_FILE} && mongo < users.js &>>${LOG_FILE}
STAT_CHECK $? "Load Schema"


### Redis Setup
echo -e "        ------>>>>>> \e[1;35mRedis Setup\e[0m <<<<<<------"

curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG_FILE}
STAT_CHECK $? "Download Redis Repo"

yum install redis -y  &>>${LOG_FILE}
STAT_CHECK $? "Install Redis"


sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>${LOG_FILE}
STAT_CHECK $? "Update Redis Config"

systemctl enable redis &>>${LOG_FILE}  && systemctl start redis &>>${LOG_FILE}
STAT_CHECK $? "Update Redis"

### RabbitMQ Setup
echo -e "        ------>>>>>> \e[1;35mRabbitMQ Setup\e[0m <<<<<<------"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG_FILE}
STAT_CHECK $? "Download RabbitMQ Repo"

yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>${LOG_FILE}
STAT_CHECK $? "Install Erlang & RabbitMQ"


systemctl enable rabbitmq-server &>>${LOG_FILE}  && systemctl start rabbitmq-server &>>${LOG_FILE}

rabbitmqctl  list_users | grep roboshop &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  rabbitmqctl add_user roboshop roboshop123 &>>${LOG_FILE}
  STAT_CHECK $? "Create APp User in RabbitMQ"
fi

rabbitmqctl set_user_tags roboshop administrator  &>>${LOG_FILE} && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>${LOG_FILE}
STAT_CHECK $? "Configure APp User Permissions "