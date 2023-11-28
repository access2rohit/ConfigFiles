#!/bin/bash
# Debug(debug) mode setup: additionally installs python debug mode and valgrind
# over the normal Developer(dev) mode setup
# Python debug build is very slow and valgrid can introduce slowdowns upto 20x
# Hence do not setup Debug mode unless you need it !!

# Sync option installs unison on your machine for code sync
# you still need to configure it on your local PC for sync to work

## Types of setups possible with this script ##
# Developer mode w/o code sync run:
# $ bash setup_instance.sh dev
# Developer mode w/ code sync run:
# $ bash setup_instance.sh dev sync
# Debug mode w/o code sync run:
# $ bash setup_instance.sh debug
# Debug mode w/ code sync run:
# $ bash setup_instance.sh debug sync

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
  echo "Instance being setup in Developer mode"
fi

sudo add-apt-repository ppa:jonathonf/vim -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt remove -y vim vim-runtime gvim neovim
sudo apt install -y build-essential ninja-build cmake ccache htop stow zsh zlib1g-dev libffi-dev libssl-dev libbz2-dev libsqlite3-dev libreadline6-dev libjemalloc-dev libopenblas-dev libopencv-dev valgrind vim python3.10 python3.10-dev


sudo ln -s /usr/bin/python3.10 /usr/local/bin/python
sudo apt install python3.10-distutils
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip --no-cache-dir install pip --upgrade
pip
pip install mypy bandit pydocstyle black isort

# install miniconda for python3.9
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh
bash Miniconda3-py39_23.1.0-1-Linux-x86_64.sh -b

mkdir -p ${HOME}/workspace

mkdir -p ${HOME}/temp
cd ${HOME}/temp

wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/bashrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/gitconfig
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/screenrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/vimrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_vundle.sh
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_cmake.sh

cat bashrc >> ${HOME}/.bashrc
cat gitconfig >> ${HOME}/.gitconfig
cat screenrc >> ${HOME}/.screenrc
cat vimrc >> ${HOME}/.vimrc

# Install unison if setup needs code sync
if [[ $2 == "sync" ]]; then
  echo "Installing unison for code sync"
  wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_ocaml_unison.sh
  bash install_ocaml_unison.sh
fi

bash install_cmake.sh
bash install_vundle.sh

# Install debug tools if instance setup mode is "Debug"
typeset -l $1
if [[ $1 == "debug" ]]; then
  wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_python_debug.sh
  wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_valgrind.sh
  bash install_python_debug.sh
  bash install_valgrind.sh
fi

cd ${HOME}
sudo rm -rf ${HOME}/temp

echo "SUCCESS! Either 'source ~/.bashrc' or logout and login again for changes to take effect"
