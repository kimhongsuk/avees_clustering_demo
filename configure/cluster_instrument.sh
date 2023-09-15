#!/bin/bash
# cluster_instrument.sh

# Get source
cd ~/ros2_ws/src
git clone -b cluster_instrument --single-branch https://github.com/kimhongsuk/avees_clustering_demo_node.git

# Build & Install
cd ~/ros2_ws
colcon build --symlink-install