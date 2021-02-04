#!/bin/bash
sudo apt update
sudo apt install -y build-essential ninja-build cmake ccache htop stow zsh zlib1g-dev libffi-dev libssl-dev libbz2-dev libsqlite3-dev libreadline6-dev libjemalloc-dev libopenblas-dev libopencv-dev

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
wget https://raw.githubusercontent.com/access2rohit/ConfigFiles/master/install_ocaml_unison.sh

cat bashrc >> ${HOME}/.bashrc
cat gitconfig >> ${HOME}/.gitconfig
cat screenrc >> ${HOME}/.screenrc
cat vimrc >> ${HOME}/.vimrc
cat mxnet_config > ${HOME}/workspace/incubator-mxnet/.git/config
bash install_vundle.sh
bash install_ocaml_unison.sh
bash install_cmake.sh

cd ${HOME}
rm -rf ${HOME}/temp

# Setup Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install plugins present in vimrc
vim +PluginInstall +qal

# Create conda ENV names pytest for running tests with `pytest`
conda create -n pytest python=3.6 numpy scikit-learn contextvars requests -y


echo "SUCCESS! Either 'source ~/.bashrc' or logout and login again for changes to take effect"
