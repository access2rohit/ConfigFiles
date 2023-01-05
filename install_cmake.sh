#!/bin/bash
export CMAKE_VERSION=3.20.2
sudo apt-get remove cmake -y
sudo apt-get install build-essential libssl-dev
wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz
tar -zxvf cmake-${CMAKE_VERSION}.tar.gz
cd cmake-${CMAKE_VERSION}
 ./bootstrap
make -j $(nproc) && sudo make install
