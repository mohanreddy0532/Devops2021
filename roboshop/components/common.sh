#!/bin/bash
#Common files for Roboshop Application.
LOG_FILE=/tmp/roboshop.log
rm -rf ${LOG_FILE}

#MAX_LEGNTH=$(cat components/*.sh | grep -v -w cat | grep STAT_CHECK | awk -F '"' '{print $2}' | awk '{print length }' | sort | tail -1)
#
#if [ $MAX_LENGTH -lt 24 ];then
#  MAX_LENGTH=24
#fi

MAX_LENGTH=$(cat components/*.sh  | grep -v -w cat | grep STAT_CHECK | awk -F '"' '{print $2}'  | awk '{ print length }'  | sort  | tail -1)

if [ $MAX_LENGTH -lt 24 ];then
  MAX_LENGTH=24
fi


STAT_CHECK() {
  SPACE=""
  LENGTH=$(echo $2 |awk '{print length }' )
  LEFT=$((${MAX_LENGTH}-${LENGTH}))
  while [ $LEFT -gt 0 ]; do
    SPACE=$(echo -n "${SPACE} ")
    LEFT=$((${LEFT}-1))
  done
  if [ $1 -ne 0 ]; then
    echo -e "\e[1m${2}${SPACE} - \e[1;31mFAILED\e[0m"
    exit 1
  else
    echo -e "\e[1m${2}${SPACE} - \e[1;32mSUCCESS\e[0m"
  fi
}

set-hostname -skip-apply ${COMPONENT}

DOWNLOAD() {
  curl -s -L -o /tmp/${1}.zip "https://github.com/roboshop-devops-project/${1}/archive/main.zip" $>>${LOG_FILE}
  STAT_CHECK $? "Download ${1} Code"
  cd /tmp
  unzip -o /tmp/${1}.zip &>>${LOG_FILE}
  STAT_CHECK $? "Extract ${1} Code"
}

NODEJS() {
  components=${1}
  yum install nodejs make gcc-c++ -y &>>${LOG_FILE}
  STAT_CHECK $? "Install NodeJS}"

  id roboshop &>>${LOG_FILE}
  if [$? -ne 0]; then
    useradd roboshop &>>${LOG_FILE}
    STAT_CHECK $? "Add application User"
  fi

  DOWNLOAD ${component}
  rm -rf /home/rooshop/${component} && mkdir -p /home/robshop/${component} && cp -r /tmp/${component}-main/* /home/roboshop/${component} &>>${LOG_FILE}
  STAT_CHECK $? "Copy ${component} Content"

  cd /home/roboshop/${component} && npm install --unsafe-perm &>>${LOG_FILE}
  STAT_CHECK $? "Install NodeJS dependencies"

  chown roboshop:roboshop -R /home/roboshop

  sed -i -e 's/MONGO_DNSNAME/mongo.roboshop.internal/' \
         -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' \
         -e 's/MONGO_ENDPOINT/mongo.roboshop.internal/' \
         -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/${component}/systemd.service .service &>>${LOG_FILE} && mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service  &>>${LOG_FILE}
  STAT_CHECK $? "Update SystemD Config file"

    systemctl daemon-reload &>>${LOG_FILE} && systemctl start ${component} &>>${LOG_FILE} && systemctl enable ${component} &>>${LOG_FILE}
    STAT_CHECK $? "Start ${component} Service"
  }
