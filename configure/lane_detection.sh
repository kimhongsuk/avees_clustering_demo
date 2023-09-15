#!/bin/bash
# lane_detection.sh

# Dependencies of OpenCV (from https://github.com/AveesLab/scale_truck_control_ros2)
# Uninstall old version of OpenCV
sudo apt-get purge  libopencv* python-opencv
sudo find /usr/local/ -name "*opencv*" -exec rm -i {} \;
# Install 4.4.0 version of OpenCV
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install build-essential cmake
sudo apt-get -y install pkg-config
sudo apt-get -y install libjpeg-dev libtiff5-dev libpng-dev
sudo apt-get -y install ffmpeg libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
sudo apt-get -y install libv4l-dev v4l-utils
sudo apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 
sudo apt-get -y install libgtk-3-dev
sudo apt-get -y install mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev
sudo apt-get -y install libatlas-base-dev gfortran libeigen3-dev
sudo apt-get -y install python3-dev python3-numpy
# Download OpenCV 4.4.0 source file
mkdir OpenCV && cd OpenCV
git clone -b 4.4.0 https://github.com/opencv/opencv
git clone -b 4.4.0 https://github.com/opencv/opencv_contrib
cd opencv && mkdir build && cd build
# Build OpenCV 4.4.0
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-D WITH_OPENCL=OFF \
-D WITH_CUDA=ON \
-D CUDA_ARCH_BIN=8.7 \
-D CUDA_ARCH_PTX="" \
-D WITH_CUDNN=ON \
-D WITH_CUBLAS=ON \
-D ENABLE_FAST_MATH=ON \
-D CUDA_FAST_MATH=ON \
-D OPENCV_DNN_CUDA=ON \
-D ENABLE_NEON=ON \
-D WITH_QT=OFF \
-D WITH_OPENMP=ON \
-D WITH_OPENGL=ON \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_GSTREAMER=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D BUILD_TESTS=OFF \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D BUILD_opencv_python3=TRUE \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF \
..
sudo make install -j6

# cv_bridge
cd ~/ros2_ws/src
git clone -b foxy https://github.com/ros-perception/vision_opencv.git
cd vision_opencv/cv_bridge
sed -i 's/find_package(OpenCV 4 QUIET/find_package(OpenCV 4.4 QUIET/g' CMakeLists.txt
cd ~/ros2_ws
colcon build --symlink-install

# Get source
cd ~/ros2_ws/src
git clone -b demo --single-branch https://github.com/AveesLab/lane_detection_ros2.git

# Build & Install
cd ~/ros2_ws
colcon build --symlink-install