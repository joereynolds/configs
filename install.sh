#!/bin/bash

packages=(
    cmake
    exuberant-ctags
    feh
    obconf
    python-dev
    rake
    ruby-dev
    vim-gnome
    xbacklight
)

echo "Startup script started"

for package in ${packages[*]}; do
    echo "Installing" ${package}
    sudo apt-get install -qq ${package}
done
echo "Packages installed."

echo "Installing Vim plugins started"

echo "Installing Command-T"
git clone https://github.com/wincent/command-t
cd ~/.vim/bundle/command-t
rake make

echo "Installing Syntastic"
git clone https://github.com/scrooloose/syntastic.git

echo "Installing Tagbar"
git clone https://github.com/majutsushi/tagbar

echo "Installing YouCompleteMe"
git clone https://github.com/valloric/youcompleteme
cd youcompleteme
git submodule update --init --recursive
./install.py --clang-completer

