#!/bin/bash

DIR=$(pwd)
git clone git://sourceware.org/git/valgrind.git
cd $DIR/valgrind
./autogen.sh
./configure --prefix=$(pwd)
make
sudo make install
