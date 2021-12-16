#!/bin/bash
# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx
#Let's download the HTML content that serves the RoboSHop Project UI and deploy under the Nginx path.

# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#Deploy in Nginx Default Location.

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-master static README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
#Finally restart the service once to effect the changes.

# systemctl restart nginx

STAT_CHECK() {
 if [ $1 -ne 0 ]; then
   echo -e "\e[1;31m${2} - Failed\e[0m"
   exit 1
 else
    echo -e "\e[1;32m${2}  - SUCCESS\e[0m"
 fi
}

yum install nginx -y
STAT_CHECK $? "Nginx Install"

curl -f -s -L -o /tmp/frontend.zip  "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
STAT_CHECK $? "Download frontend"

cd /usr/share/nginx/html
rm -rf *
unzip -o /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx
