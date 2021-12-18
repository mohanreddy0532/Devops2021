##!/bin/bash
#
#COMPONENT=$1
#
#TEMP_ID="lt-0371737b9b36fe546"
#TEMP_VER=1
#ZONE_ID=Z079880618UTU9V8KYVX0
#
##Below is with Spot-Instance and Tag
##aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER} --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" "ResourceType=instance,Tags=[{Key=Name,Value=frontend}]" | jq
##Simple launch
##aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER} | jq
#
### Check if instance is already there or Not #With only instance and Tag
#TERMINATE_INSTANCE() {
###Check if Instance is already there
#aws ec2 terminate-instances --instance-ids --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | sed 's/"//g' | grep -E 'terminated' &>/dev/null
#if [ $? -eq -0 ]; then
#   echo -e "\e[1;33mInstance is already terminated\e[0m"
#else
#   aws ec2 terminate-instances --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"| jq
#fi
##For Spot Instance
##aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER} --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${COMPONENT}}]" "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
#
#sleep 5
#
##IPADDRESS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].PrivateIpAddress | sed 's/"//g' | grep -v null)
##
###Update the DNS record
##sed -e "s/IPADDRESS/${IPADDRESS}/" -e "s/COMPONENT/${COMPONENT}/" record.json >/tmp/record.json
##aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file:///tmp/record.json | jq
#}
#
#if [ "$COMPONENT" == "all" ]; then
#  for comp in frontend mongodb catalogue ; do
#    COMPONENT=$comp
#    TERMINATE_INSTANCE
#  done
#else
#  TERMINATE_INSTANCE
#fi

aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --filters 'Name=tag-value,Values=MYTAG' --output text |
grep stopped |
awk '{print $2}' |
while read line;
do aws ec2 terminate-instances --instance-ids $line
done