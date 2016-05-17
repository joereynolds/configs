#!/bin/bash

packages=(
    cmake
    conky
    exuberant-ctags
    feh
    obconf
    openbox
    python-dev
    rake
    ruby-dev
    vim-gnome
    xbacklight
    silversearch-ag
)

echo "Startup script started"

sudo rm -rf /usr/local/bin/vim #Remove crap vim and later link it to the good one
for package in ${packages[*]}; do
    echo "Installing" ${package}
    sudo apt-get install -qq ${package}
done
ln -s /usr/bin/vim.gnome /usr/local/bin/vim
echo "Packages installed."

echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Configuring vim plugins"

echo "Command-T"
cd ~/.vim/plugged/command-t
rake make

echo "YouCompleteMe"
cd ~/.vim/plugged/youcompleteme
git submodule update --init --recursive
./install.py --clang-completer

echo "Plugins configured"

echo "Creating symlinks"
ln -s ~/programs/configs/vim/.vimrc ~/.vimrc
ln -s ~/programs/configs/ctags/.ctags ~/.ctags
ln -s ~/programs/configs/bash/.bashrc ~/.bashrc
ln -s ~/programs/configs/openbox/.themes ~/.themes
ln -s ~/programs/configs/conky/.conky.conf ~/.conky.conf
ln -s ~/programs/configs/git/.git-prompt.sh ~/.git-prompt-sh
