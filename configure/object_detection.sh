#!/bin/bash
# object_detection.sh

# Get source
cd ~/ros2_ws/src
git clone -b demo --single-branch https://github.com/AveesLab/yolo_object_detection_ros2.git
cd yolo_object_detection_ros2/darknet

# Build Dependencies
make -j6

# Build & Install
cd ~/ros2_ws
colcon build --symlink-install