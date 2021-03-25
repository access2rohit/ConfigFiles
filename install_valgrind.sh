#!/bin/bash

git clone git://sourceware.org/git/valgrind.git
cd $HOME/valgrind
./autogen.sh
./configure --prefix=$HOME/valgrind
make
sudo make install
echo "export PATH=\$PATH:\$HOME/valgrind/bin" >> ${HOME}/.bashrc
