#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install plugins present in vimrc
vim +PluginInstall +qall

# Compile YCM
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer
