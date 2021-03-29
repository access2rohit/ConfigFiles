#!/bin/bash
# Debug(debug) mode setup: additionally installs python debug mode and valgrind
# over the normal Developer(dev) mode setup
# Python debug build is very slow and valgrid can introduce slowdowns upto 20x
# Hence do not setup Debug mode unless you need it !!

# Sync option installs unison on your machine for code sync
# you still need to configure it on your local PC for sync to work

## Types of setups possible with this script ##
# Developer mode w/o code sync run:
# $ bash setup_instance.ch dev
# Developer mode w/ code sync run:
# $ bash setup_instance.ch dev sync
# Debug mode w/o code sync run:
# $ bash setup_instance.ch debug
# Debug mode w/ code sync run:
# $ bash setup_instance.ch debug sync

##
## Author: access2rohit(srivastava.141@osu.edu)
##

set -eo pipefail

typeset -l $1
typeset -l $2
if [[ -z $1 ]]; then
  echo "You must specify instance setup mode 'dev' or 'debug'"
  return
elif [[ $1 == "debug" ]]; then
  echo "Instance being setup in Debug mode"
else
  echo "Instance type not sepecified setting up in Developer mode by default"
fi

sudo add-apt-repository ppa:jonathonf/vim -y
sudo apt update
sudo apt remove -y vim vim-runtime gvim
sudo apt install -y build-essential ninja-build cmake ccache htop stow zsh zlib1g-dev libffi-dev libssl-dev libbz2-dev libsqlite3-dev libreadline6-dev libjemalloc-dev libopenblas-dev libopencv-dev valgrind vim

# Removes conflictings openBLAS libraries and updates default BLAS to point to newly install openBLAS from previous step
sudo update-alternatives --remove-all liblapack.so-x86_64-linux-gnu
sudo update-alternatives --remove-all liblapack.so.3-x86_64-linux-gnu
sudo update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so libblas.so-x86_64-linux-gnu /usr/local/lib/libopenblas.a 41 --slave /usr/lib/x86_64-linux-gnu/liblapack.so liblapack.so-x86_64-linux-gnu /usr/local/lib/libopenblas.so.0
sudo update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so.3 libblas.so.3-x86_64-linux-gnu /usr/local/lib/libopenblas.so.0 41 --slave /usr/lib/x86_64-linux-gnu/liblapack.so.3 liblapack.so.3-x86_64-linux-gnu /usr/local/lib/libopenblas.so.0

mkdir ${HOME}/workspace
cd ${HOME}/workspace
git clone --recursive https://github.com/apache/incubator-mxnet.git
cp ${HOME}/workspace/incubator-mxnet/config/linux_gpu.cmake ${HOME}/workspace/incubator-mxnet/config.cmake

mkdir ${HOME}/temp
cd ${HOME}/temp

wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/bashrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/gitconfig
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/screenrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/mxnet_config
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/vimrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_vundle.sh
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_cmake.sh

cat bashrc >> ${HOME}/.bashrc
cat gitconfig >> ${HOME}/.gitconfig
cat screenrc >> ${HOME}/.screenrc
cat vimrc >> ${HOME}/.vimrc
cat mxnet_config > ${HOME}/workspace/incubator-mxnet/.git/config

# Install unison if setup needs code sync
if [[ $2 == "sync" ]]; then
  echo "Installing unison for code sync"
  wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_ocaml_unison.sh
  bash install_ocaml_unison.sh
fi
bash install_vundle.sh
bash install_cmake.sh

# Install debug tools if instance setup mode is "Debug"
typeset -l $1
if [[ $1 == "debug" ]]; then
  wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_python_debug.sh
  wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_valgrind.sh
  bash install_python_debug.sh
  bash install_valgrind.sh
fi

cd ${HOME}
rm -rf ${HOME}/temp

echo "SUCCESS! Either 'source ~/.bashrc' or logout and login again for changes to take effect"
