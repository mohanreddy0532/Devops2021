##!/bin/bash
##Welcome to RoboShop Project AUTOMATION(Shell Scripting).
#
# #To check user id have root access or not.
# USER_UID=$(id -u)
# if [ ${USER_UID} -ne 0 ]; then
#   echo -e "\e[1;31mYou Should be a ROOT user to run this Program\e[0m"
#   exit
# fi
#
# export COMPONENT=$1
# # -z is component is missing
# if [ -z "$COMPONENT" ]; then
#   echo -e "\e[1;31mComponent Input is Missing\e[0m"
#   exit
# fi
# # -e if file is exits
# if [ ! -e component/${COMPONENT}.sh ]; then
#   echo -e "\e[1;31mGiven component script does not exits\e[0m"
#   exit
# fi
#
# bash components/${COMPONENT}.sh

#!/bin/bash

USER_UID=$(id -u)
if [ ${USER_UID} -ne 0 ]; then
  echo -e "\e[1;31mYou should be a root user to perform this script\e[0m"
  exit
fi

export COMPONENT=$1
if [ -z "$COMPONENT" ]; then
  echo -e "\e[1;31mComponent INput Missing\e[0m"
  exit
fi

if [ ! -e components/${COMPONENT}.sh ]; then
  echo -e "\e[1;31mGiven component script does not exists\e[0m"
  exit
fi

bash components/${COMPONENT}.sh