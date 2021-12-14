#!/bin/bash

LOG_FILE=/tmp/roboshop.log
rm -rf ${LOG_FILE}

MAX_LENGTH=$(cat components/*.sh | grep -v -w cat | grep STAT_CHECK | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)

if [ $MAX_LENGTH -lt 24 ];then
  MAX_LENGTH=24
fi

STAT_CHECK() {
  SPACE=""
  LENGTH=$(echo $2 |awk '{ print lenght }' )
  LEFT=$((${MAX_LENGTH}-${LENGTH}))
  while [ $LEFT -gt 0 ];do
    SPACE=$(echo -n "${SPACE} ")
    LEFT=$((${LEFT}-1))
  done
  if [ $1 -ne 0 ];then
    echo -e "\e[1m${2}${SPACE} - \e[1;31mFAILED\e[0m"
    exit 1
  else
    echo -e "\e[1m${2}${SPACE} - \e[1;31mSUCCESS\e[0m"
  fi
}

set-hostname -skip-apply ${COMPONENT}

SYSTEM_SETUP() {
  chown roboshop:roboshop -R /home/roboshop
  sed -i -e 's/MONGO_DNSNAME/mongod.roboshop.internal/'  \
         -e 's/REDIS_ENDPOINT/redis.roboshop.internal/'  \
         -e 's/MONGO_ENDPOINT/mongod.roboshop.internal/' \
         -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' \
         -e  's/CARTENDPOINT/cart.roboshop.internal/' \
         -e  's/DBHOST/mysql.roboshop.internal/' \
         -e  's/CARTHOST/cart.roboshop.internal/' \
         -e  's/USERHOST/user.roboshop.internal/' \
         -e  's/AMQPHOST/rabbitmq.roboshop.internal/' \
         -e  's/RABBITMQ-IP/rabbitmq.roboshop.internal/' /home/roboshop/${component}/systemd.service &>>${LOG_FILE} && mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service &>>${LOG_FILE}
  STAT_CHECK $? "Update SystemD Congif file"

systemctl daemon-reload &>>${LOG_FILE} && systemctl restart ${component} &>>${LOG_FILE} && systemctl enable ${component} &>>${LOG_FILE}
STAT_CHECK $? "Start ${component} Service"
}
APP_USER_SETUP() {
  id roboshop &>>${LOG_FILE}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG_FILE}
    STAT_CHECK $? "Add Application User"
  fi

  DOWNLOAD() {component}
 }

DOWNLOAD() {
  curl -s -L -o /tmp/{1}.zip "https://github.com/roboshop-devops-project/${1}/archive/main.zip" &>>${LOG_FILE}
  STAT_CHECK $? "Download ${1} Code"
  cd /tmp
  unzip -o /tmp/${1}.zip &>>${LOG_FILE}
  STAT_CHECK $? "Extract ${1} Code"
  if [ ! -z "${component}" ]; then
    rm -rf /home/roboshop/${component} && mkdir -p /home/roboshop/${component} && cp -r /tmp/${component}-main/* /home/roboshop/${component} &>>${LOG_FILE}
    STAT_CHECK $? "Compy ${component} Content"
  fi
}

NODEJS() {
  component=${1}
  yum install nodejs make gcc-c++ -y &>>${LOG_FILE}
  STAT_CHECK $? "Install NodeJS "

  APP_USER_SETUP

  cd /home/roboshop/${component} && npm --unsafe-perm &>>${LOG_FILE}
  STAT_CHECK $? "Install NodeJS dependencies"

  SYSTEMD_SETUP
}

JAVA() {
  component=${1}
  yum install maven -y &>>${LOG_FILE}
  STAT_CHECK $? "Installing Maven"

  APP_USER_SETUP

  cd /home/roboshop/${component} && mvn package &>>${LOG_FILE} && mv target/${component}-1.0.jar ${component}.jar &>>${LOG_FILE}
  STAT_CHECK $? "Compliance Java Code"

  SYSTEMD_SETUP
}

PYTHON() {
  component=${1}
  yum install python36 gcc pyhton-devel -y &>>${LOG_FILE}
  STAT_CHECK $? "Installing Python"

  APP_USER_SETUP

  cd /home/roboshop/${component} && pip3 install -r requirements.txt &>>${LOG_FILE}
    STAT_CHECK $? "Install Python Dependencies"

    SYSTEMD_SETUP
}

GOLANG() {
  component=${1}
  yum install golang -y &>>{LOG_FILE}
  STAT_CHECK $? "Installing GoLang"

  APP_USER_SETUP

  cd /home/roboshop/${component} && go mod init dispatch &>>${LOG_FILE} && go get &>>${LOG_FILE} && go build &>>${LOG_FILE}
  STAT_CHECK $? "Installing GoLang dependencies & compile"

  SYSTEM_SETUP
}




