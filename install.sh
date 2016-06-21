#!/bin/bash

#Install script for a sane distro (xubuntu, lubuntu, mint etc...)
packages=(
    cmake
    curl
    exuberant-ctags
    python-dev
    rake
    ruby-dev
    vim-gnome
    xbacklight
    php-cs-fixer
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

echo "Git config and clones"
git config --global user.email "joereynolds952@gmail.com"
git config --global user.name "Joe Reynolds"

mkdir -p ~/programs
cd ~/programs
git clone https://github.com/joereynolds/fanbox
git clone https://github.com/joereynolds/life
git clone https://github.com/joereynolds/programming-dump
git clone https://github.com/joereynolds/util.joereynoldsaudio

echo "Creating symlinks"
#Use a loop instead of this grossness
rm ~/.vimrc
ln -s ~/programs/configs/vim/.vimrc ~/.vimrc

rm ~/.ctags
ln -s ~/programs/configs/ctags/.ctags ~/.ctags

rm ~/.bashrc
ln -s ~/programs/configs/bash/.bashrc ~/.bashrc

rm ~/.git-prompt.sh
ln -s ~/programs/configs/git/.git-prompt.sh ~/.git-prompt.sh
