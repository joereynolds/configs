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
)

echo "Startup script started"

for package in ${packages[*]}; do
    echo "Installing" ${package}
    sudo apt-get install -qq ${package}
done
echo "Packages installed."

echo "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


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

echo "Installing Vim-Surround"
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-surround.git

echo "Installing Vimwiki"
cd ~/.vim/bundle
git clone https://github.com/vimwiki/vimwiki

echo "Plugins installed"

echo "Creating symlinks"
ln -s ~/programs/configs/vim/.vimrc ~/.vimrc
ln -s ~/programs/configs/bash/.bashrc ~/.bashrc
ln -s ~/programs/configs/openbox/.themes ~/.themes
ln -s ~/programs/configs/conky/.conky.conf ~/.conky.conf
