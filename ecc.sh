#!/bin/bash

stop_instances ()
{
    echo 'Stopping instances:'
    get_instances
    echo $instances
    aws ec2 stop-instances --instance-ids $instances
    describe_instances
}

start_instances ()
{
    echo 'Starting instances:'
    get_instances
    echo $instances
    aws ec2 start-instances --instance-ids $instances
    describe_instances
}

describe_instances ()
{
    aws ec2 describe-instances --filters Name=tag:Name,Values=$nametag* | jq -r '.Reservations | .[] | .Instances | .[] | {name: .Tags|from_entries|select(.Name|startswith('\"${nametag}\"'))|.Name, instance: .InstanceId, ip: .PublicIpAddress, state: .State.Name}'
}
    
get_instances ()
{
    instances=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$nametag*" | jq -r ".Reservations | .[] | .Instances | .[] | .InstanceId")
}

generic_instructions ()
{
    echo "To use; $0 {start|stop|describe} {Name prefix}"
    echo "For example: $0 describe kube_worker"
}
action=$1
nametag=$2

  if [ -z "$2" ]
  then
    echo "No tags supplied. Please provide a prefix for a tag name to start/stop instances"
    generic_instructions
    exit 1
  fi

  case $action in 
    start) start_instances ;;
    stop) stop_instances ;;
    describe) describe_instances ;;
    *) echo "$action is not valid parameter for action; please enter \"start\", \"stop\", or \"describe\"" 
       generic_instructions ;;
  esac

