#!/bin/bash
ids=aws ec2 describe-instances --filters "Name=tag:Name,Values=frontend" | jq .Reservations[].Instances[].InstanceId| sed 's/"//g'
aws ec2 terminate-instances --instance-ids ids