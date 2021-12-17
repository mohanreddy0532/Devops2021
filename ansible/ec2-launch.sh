#!/bin/bash

#1. Create an SPOT instance
#2. Take that Instance IP & register in DNS

TEMP_ID="lt-0371737b9b36fe546"
TEMP_VER=1

## Check if instance is already ther e

#Below is for Spot-Instance
#aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER} --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" "ResourceType=instance,Tags=[{Key=Name,Value=frontend}]" | jq

aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER}


# Update the DNS record