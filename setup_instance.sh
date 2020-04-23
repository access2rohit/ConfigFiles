#!/bin/bash
sudo apt update
sudo apt install -y build-essential ninja-build cmake ccache htop stow zsh zlib1g-dev libffi-dev libssl-dev libbz2-dev libsqlite3-dev libreadline6-dev libjemalloc-dev libopenblas-dev libopencv-dev

mkdir ${HOME}/workspace
cd ${HOME}/workspace
git clone --recursive https://github.com/apache/incubator-mxnet.git

mkdir ${HOME}/temp
cd ${HOME}/temp

wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/bashrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/gitconfig
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/screenrc
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_ocaml_unison.sh
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/mxnet_config


cat bashrc >> ${HOME}/.bashrc
cat gitconfig >> ${HOME}/.gitconfig
cat screenrc >> ${HOME}/.screenrc
cat mxnet_config > ${HOME}/workspace/incubator-mxnet/.git/config

cd ${HOME}
rm -rf ${HOME}/build

bash install_ocaml_unison.sh

cd ${HOME}
echo "SUCCESS! Either 'source ~/.bashrc' or logout and login again for changes to take effect"
