#!/bin/bash

DIR=$(pwd)
git clone git://sourceware.org/git/valgrind.git
cd $DIR/valgrind
./autogen.sh
./configure --prefix=/usr/local/valgrind
make
sudo make install
echo "export PATH=\$PATH:${DIR}/valgrind/bin" >> ${HOME}/.bashrc
echo "export VALGRIND_LIB=${DIR}/valgrind/lib/valgrind" >> ${HOME}/.bashrc
