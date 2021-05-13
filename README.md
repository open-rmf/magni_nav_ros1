# magni_nav_ros1

Get a ROS1 Navigation Stack up and running on your Magni!

Tested on a Magni running Ubuntu 16.04, ROS1 Kinetic ( Based on the Ubiquity Robotics image ).

## Hardware Setup

We use a `sick_tim571` as LiDAR sensor, but you can use whatever LiDAR setup you want; 
You will have to modify the [launch files](/launch/magni.launch) accordingly. 

You will also need to install `udev` rules following [here](https://github.com/uos/sick_tim#setting-up-udev-rules).

## Software Setup
Assuming that you have ROS1 installation on your device, and sourced:
```
sudo apt update
sudo systemctl disable NetworkManager-wait-online.service
sudo apt install python-catkin-tools python-vcstool python-rosdep avahi-daemon
source /opt/ros/kinetic/setup.bash
```

We will begin by installing all necessary dependencies.
```
cd $HOME/catkin_ws
rm -r build devel

git clone https://github.com/open-rmf/magni_nav_ros1 src/magni_nav_ros1

# Install dependencies
sudo apt install ros-kinetic-ros-base ros-kinetic-move-base ros-kinetic-dwa-local-planner ros-kinetic-amcl \
  ros-kinetic-map-server ros-kinetic-tf2-web-republisher ros-kinetic-diagnostic-aggregator ros-kinetic-sick-tim \
  ros-kinetic-sick-scan ros-kinetic-teleop-twist-keyboard

catkin build
```

## Connect to Magni
On both your workstation and robot, set this in your `~/.bashrc`:
```
export ROS_HOSTNAME=`hostname`.local
```
This will use mdns for robot discovery, which is way more awesome than using ip addresses.

Your workstation will need the following as well in the `~/.bashrc` ( replace ubiquityrobot with whatever your robot hostname is )
```
export ROS_MASTER_URI=http://ubiquityrobot.local:11311
```

Finally, we can launch a rviz visualization on your workstation
```
# Source your ROS1 distribution
rosrun rviz rviz 
```
And open the file `magni.rviz` [here](/param/magni.rviz).

## Run the magni navigation stack
```
# You should be able to ping the robot from your workstation
ping ubiquityrobot.local

# ssh into the robot
ssh ubuntu@ubiquityrobot.local

# Check for deserialization errors 
sudo systemctl status magni-base.service  # If errors are present, restart this service: sudo systemctl restart magni-base.service

source /opt/ros/kinetic/setup.bash
source $HOME/catkin_ws/devel/setup.bash
roslaunch magni_nav_ros1 magni.launch
```
You should see Rviz update with the robot navigation map.
Keyboard Telop is running on the robot as well, so you can drive the robot around using the ijlm keys. ( The navstack terminal must be in focus )

## Edit robot navigation map
Replace the [map files](/maps) with your own navigation map. We have template files for [`cartographer_ros`](https://google-cartographer-ros.readthedocs.io/en/latest/) in the [cartographer_configs](/cartographer_configs) and [launch](/launch) files.

## Special Thanks ( in no order )
* [Ubiquity Robotics](https://github.com/UbiquityRobotics/) for creating the Magni
* [Morgan Quigley](https://github.com/codebot/) for the cartographer ros configurations
* [CHART](https://github.com/sharp-rmf/) for development time and research 
