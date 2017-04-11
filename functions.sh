#!/bin/bash

function installPackages() {

  packages=(
    cmake
    curl
    exuberant-ctags
    git
    npm
    python-dev
    rake
    vim-gnome
    php-codesniffer
    php-cs-fixer
    phpmd
    silversearcher-ag
    tmux
  )

  for package in ${packages[*]}; do
    sudo apt-get install -qq ${package}
  done

  #Remove crap vim and later link it to a good one
  sudo rm -rf /usr/local/bin/vim && sudo ln -s /usr/bin/vim.gnome /usr/local/bin/vim
  
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function configureGit() {
  git config --global user.email "joereynolds952@gmail.com"
  git config --global user.name "Joe Reynolds"
}

function clonePersonalRepos() {

  repositories=(
    Configs
    life
    programming-dump
    util.joereynoldsaudio
  )

  cd ~/programs

  for repository in ${repositories[*]}; do
    git clone https://github.com/joereynolds/${repository}
  done
}

function symlinkConfigs() {

  rm ~/.vimrc
  rm ~/.config/nvim/init.vim
  rm ~/.ctags
  rm ~/.bashrc
  rm ~/.tmux.conf

  ln -s ~/programs/configs/vim/.vimrc ~/.vimrc
  ln -s ~/programs/configs/nvim/init.vim ~/.config/nvim/init.vim
  ln -s ~/programs/configs/ctags/.ctags ~/.ctags
  ln -s ~/programs/configs/bash/.bashrc ~/.bashrc
  ln -s ~/programs/configs/tmux/.tmux.conf ~/.tmux.conf
}
