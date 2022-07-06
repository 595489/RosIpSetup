#!/bin/bash

# Author : Isak Aasemoen Aardal
# License : MIT
# Script to setup the ip section of .bashrc
# for use with turtlebot3 (And possibly other models)

ipvar=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')

# bashrc
master_uri="export ROS_MASTER_URI=http://HOST_IP:11311"
master_uri_new="export ROS_MASTER_URI=http://$ipvar:11311"

hostname="export ROS_HOSTNAME=HOST_IP"
hostname_new="export ROS_HOSTNAME=$ipvar"

cp ~/.bashrccopy ~/.bashrc343

awk -F: -v s="$master_uri" -v r="$master_uri_new" '$master_uri==s{$master_uri_new=r}7' ~/.bashrc343 > ~/.bashrc234
awk -F: -v s="$hostname" -v r="$hostname_new" '$hostname==s{$hostname_new=r}7' ~/.bashrc234 > ~/.bashrc

rm ~/.bashrc234 ~/.bashrc343

# Print IP
echo $ipvar