#!/bin/bash

USER_UID=$(id -u)
if [ ${USER_UID} -ne 0]; then
  echo -e "\e[1;31mYou Should be a root user to perform this script\e[0m"
  exit
fi

export COMPONENT=$1
if [ -z "$COMPONENT" ]; then
  echo -e "\e[1;5;31mComponent Input Missing\e[0m"
  exit
fi

if [ -e component/${COMPONENT}.sh ]; then
  echo -e "\e[1;31mGiven component doesn't exist\e[0m"
  exit
fi

bash component/${COMPONENT}.sh




