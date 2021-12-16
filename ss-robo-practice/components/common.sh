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

set-hostname -skip-apply ${COMPONENT}
