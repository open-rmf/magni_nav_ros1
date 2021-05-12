# magni_nav_ros1

Get a ROS1 Navigation Stack up and running on your Magni!

Tested on a Magni running Ubuntu 16.04, ROS1 Kinetic ( Based on the Ubiquity Robotics image ).

## Hardware Setup

We use a `sick_tim571` as LiDAR sensor, but you can use whatever LiDAR setup you want; 
You will have to modify the [launch files](/launch/magni.launch) accordingly. 

## Software Setup
Assuming that you have ROS1 installation on your device, and sourced:
```
sudo apt install python3-catkin tools python-vcstool python-rosdep avahi-daemon
source /opt/ros/kinetic/setup.bash
```

We will begin by installing all necessary dependencies.
```
cd $HOME/catkin_ws

git clone https://github.com/open-rmf/magni_nav_ros1 src/magni_nav_ros1

# Install dependencies
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -yr

catkin build
```

## Edit robot navigation map
Replace the [map files](/maps) with your own navigation map.

## Connect to Magni
On both your workstation and robot, set this in your `~/.bashrc`:
```
export ROS_HOSTNAME=`hostname`.local
```
This will use mdns for robot discovery, which is way more awesome than using ip addresses.

Your workstation will need the following as well ( replace ubiquityrobot with whatever your robot hostname is )
```
export ROS_MASTER_URI=http://ubiquityrobot.local:11311
```

Finally, we can launch a rviz visualization on your workstation
```
rosrun rviz rviz 
```
And open the file `magni.rviz` [here](/param/magni.rviz).
