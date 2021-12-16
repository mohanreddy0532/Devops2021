#!/bin/bash

LOG_FILE=/tmp/roboshop.log
rm -rf ${LOG_FILE}

STAT_CHECK() {
 if [ $1 -ne 0 ]; then
   echo -e "\e[1m${2} - \e[5;31mFailed\e[0m"
   exit 1
 else
    echo -e "\e[1m${2}  - \e[5;32mSUCCESS\e[0m"
 fi
}

set-hostname -skip-apply ${COMPONENT}

DOWNLOAD() {
  curl -f -s -L -o /tmp/${1}.zip  "https://github.com/roboshop-devops-project/${1}/archive/main.zip" &>>${LOG_FILE}
  STAT_CHECK $? "Download ${1} Code"

  cd /tmp && unzip -o /tmp/${1}.zip  &>>${LOG_FILE}
  STAT_CHECK $? "Extracting ${1} code"

}