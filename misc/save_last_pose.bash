#!/bin/bash


source /opt/ros/kinetic/setup.bash
source /home/ubuntu/catkin_ws/devel/setup.bash

rostopic echo -n1 /amcl_pose > /tmp/last_pose

if [ -f "$HOME/.unlock_magni_save_pose" ]; then
	cp /tmp/last_pose $HOME/last_pose
fi
