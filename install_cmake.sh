#!/bin/bash
sudo apt-get remove cmake -y

wget http://www.cmake.org/files/v3.13/cmake-3.13.3.tar.gz
tar xf cmake-3.13.3.tar.gz
cd cmake-3.13.3
./configure
make
sudo make install
