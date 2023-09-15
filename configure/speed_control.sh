#!/bin/bash
# speed_control.sh

# Get source
cd ~/ros2_ws/src
git clone -b speed_control --single-branch https://github.com/kimhongsuk/avees_clustering_demo_node.git

# Build & Install
cd ~/ros2_ws
colcon build --symlink-install