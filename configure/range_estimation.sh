#!/bin/bash
# range_estimation.sh

# Get source
cd ~/ros2_ws/src
sudo apt-get install ros-foxy-perception-pcl
git clone -b demo --single-branch https://github.com/AveesLab/object_detection_ros2.git

# Build & Install
cd ~/ros2_ws
colcon build --symlink-install