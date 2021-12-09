#!/bin/bash
#Welcome to RoboShop Project AUTOMATION(Shell Scripting).

USER_ID = $(id -u)
 if [${USER_ID} -ne 0 ]; then
   echo -e "\e[1;31mYou Should be a ROOT user to run this Program\e[0m"
   exit
 fi

 COMPONENT = $1
 if [-z "$COMPONENT"]; then
   echo -e "\e[1,31mComponent input is Missing\e[0m"
   exit
 fi

 if [! -e components/${COMPONENTS}.sh]; then
   echo -e "\e[1;31mGiven component script does not exits\e[0m"
   exit
 fi