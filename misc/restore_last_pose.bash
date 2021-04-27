#!/bin/bash


source /opt/ros/kinetic/setup.bash
source /home/ubuntu/catkin_ws/devel/setup.bash

rostopic echo -n1 /tf # Waits for tf to start publishing
rostopic pub --once /initialpose geometry_msgs/PoseWithCovarianceStamped """header:
  seq: 1
  stamp:
    secs: 1602139034
    nsecs: 964688329
  frame_id: "map"
pose:
  pose:
    position:
      x: `cat $HOME/last_pose | grep x -m 1 | cut -c 10-`
      y: `cat $HOME/last_pose | grep y -m 1 | cut -c 10-`
      z: 0.0
    orientation:
      x: `cat $HOME/last_pose | grep x | tail -n1 | cut -c 10-`
      y: `cat $HOME/last_pose | grep y | tail -n1 | cut -c 10-`
      z: `cat $HOME/last_pose | grep z | tail -n1 | cut -c 10-`
      w: `cat $HOME/last_pose | grep w | tail -n1 | cut -c 10-`
  covariance: [0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.06853892326654787]"""

touch /home/ubuntu/.unlock_magni_save_pose
