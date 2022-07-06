#!/bin/bash

# Author : Isak Aasemoen Aardal
# License : MIT
# Script to setup the ip section of .bashrc
# for use with turtlebot3 (And possibly other models)

ipvar=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
hostvar=$(awk '(NR>=4 && NR<=4)' /etc/resolv.conf | cut -c 12-28)

# .bashrc
master_uri="export ROS_MASTER_URI=http://HOST_IP:11311"
master_uri_new="export ROS_MASTER_URI=http://$ipvar:11311"

hostname="export ROS_HOSTNAME=HOST_IP"
hostname_new="export ROS_HOSTNAME=$ipvar"

cp ~/.bashrccopy ~/.bashrc343

awk -F: -v s="$master_uri" -v r="$master_uri_new" '$master_uri==s{$master_uri_new=r}7' ~/.bashrc343 > ~/.bashrc234
awk -F: -v s="$hostname" -v r="$hostname_new" '$hostname==s{$hostname_new=r}7' ~/.bashrc234 > ~/.bashrc

rm ~/.bashrc234 ~/.bashrc343

# ur5_e_moveit_planning_execution_isak.launch
old_ip="  <arg name="tcp_ip" default="IP_ADDR"/>"
new_ip="  <arg name="tcp_ip" default="$ipvar"/>"

old_host="        <arg name="robot_ip" value="ROBOT_IP_ADDR" />"
new_host="        <arg name="robot_ip" value="$hostvar" />"

cp ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/COPY_ur5_e_moveit_planning_execution_isak.launch ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/3x_ur5_e_moveit_planning_execution_isak.launch

awk -F: -v s="$old_ip" -v r="$new_ip" '$old_ip==s{$new_ip=r}7' ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/3x_ur5_e_moveit_planning_execution_isak.launch > ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/2x_ur5_e_moveit_planning_execution_isak.launch
awk -F: -v s="$old_host" -v r="$new_host" '$old_host==s{$new_host=r}7' ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/2x_ur5_e_moveit_planning_execution_isak.launch > ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/ur5_e_moveit_planning_execution_isak.launch

rm ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/3x_ur5_e_moveit_planning_execution_isak.launch ~/catkin_ws/src/fmauch_universal_robot/ur5_e_moveit_config/launch/2x_ur5_e_moveit_planning_execution_isak.launch

# Print IP
echo "IP: $ipvar"
echo "WSL host IP: $hostvar"