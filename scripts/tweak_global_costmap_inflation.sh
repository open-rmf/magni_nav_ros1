#!/bin/bash
source /opt/ros/kinetic/setup.bash
rosrun dynamic_reconfigure dynparam set /move_base/global_costmap/inflater_layer inflation_radius $(echo "scale=8; $RANDOM/32768*0.001+.50"|bc)
