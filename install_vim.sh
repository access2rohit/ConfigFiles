#!/bin/bash

sudo apt install -y libncurses5-dev \
                    libgtk2.0-dev \
                    libatk1.0-dev \
                    libcairo2-dev \
                    libx11-dev \
                    libxpm-dev \
                    libxt-dev \
                    lua5.2 \
                    liblua5.2-dev

sudo apt remove vim vim-runtime gvim

# Install vim
cd $HOME
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim82

# Install checkinstall for easy uninstallation later
sudo apt install checkinstall
cd $HOME/vim
sudo checkinstall

# Set vim as default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

vi --version
