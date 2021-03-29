#!/bin/bash

cd $HOME
git clone git://sourceware.org/git/valgrind.git
cd $HOME/valgrind
./autogen.sh
./configure --prefix=$HOME/valgrind
make
sudo make install
echo "export PATH=\$HOME/valgrind/bin:\$PATH" >> ${HOME}/.bashrc
cd $HOME/temp
