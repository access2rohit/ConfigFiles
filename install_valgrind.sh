#!/bin/bash

DIR=$(pwd)
LOC=/usr/local/valgrind
git clone git://sourceware.org/git/valgrind.git
cd $DIR/valgrind
./autogen.sh
./configure --prefix=${LOC}
make
sudo make install
echo "export PATH=\$PATH:${LOC}/bin" >> ${HOME}/.bashrc
echo "export VALGRIND_LIB=${LOC}/lib/valgrind" >> ${HOME}/.bashrc
