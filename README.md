IPsetup is a collection of scripts useful when preparing to connect to ROS robots (only tested on turtlebot 3, but should work for most ROS robots)

**INSTRUCTIONS**
1. Open .bashrc in your home directory (might be hidden, CTRL+H to show/hide hidden files)

2. Look for 
   
   a. export ROS_MASTER_URI=http://"SomeIpAddress":11311
   
   b. export ROS_HOSTNAME="SomeIpAddress
   
   ("SomeIpAddress" can be your ip or some other ip address)
   
3. If you found the lines in step 2 replace them with:
   
   a. export ROS_MASTER_URI=http://HOST_IP:11311
   
   b. export ROS_HOSTNAME=HOST_IP
   
   If not add the lines at the bottom of your .bashrc
   
4. Run init.bash <./init.bash> in terminal (without <>)


**unity_ros_ip_setup.bash**

There is also a file called unity_ros_ip_setup.bash.

This file does the same as the ros_ip_setup.bash file, with the added functionality of also getting the wsl host (windows) ip.

After getting the ips it proceeds to also update the ip field in a specific launch file regarding the ip of the robot.

That last part might not be correct atm, but I have yet to test this while connected to a robot, so if it specifically needs the robot ip you might need to remove that part of the process, and manually set the robot ip