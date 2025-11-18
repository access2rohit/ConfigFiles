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

sudo apt update
sudo apt upgrade

mkdir -p ${HOME}/workspace/

mkdir -p ${HOME}/temp
cd ${HOME}/temp

wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/bashrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/gitconfig
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/screenrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/vimrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_vundle.sh

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

sudo apt install -y \
  python3-mypy \
  python3-bandit \
  python3-pydocstyle \
  python3-black \
  python3-isort
sudo apt install -y --upgrade nvitop bpytop
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
