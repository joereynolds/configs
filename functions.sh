#!/bin/bash

addAptRepositories() {
  #spotify
  # 1. Add the Spotify repository signing key to be able to verify downloaded packages
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  # 2. Add the Spotify repository
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

  #php
  sudo add-apt-repository ppa:ondrej/php
}

installPackages(){

  sudo apt-get update

  packages=(
    automake
    cmake
    composer
    curl
    exuberant-ctags
    git
    google-chrome
    libtool
    libtool-bin
    lnav
    newsbeuter
    npm
    python-dev
    rake
    php7.1
    php7.1-curl
    php7.1-mbstring
    php7.1-simplexml
    php-codesniffer
    php-cs-fixer
    phpmd
    python-pip
    python3-pip
    racket
    ruby-dev
    silversearcher-ag
    spotify-client
    tmux
  )

  for package in ${packages[*]}; do
    sudo apt-get install -qq ${package}
  done

  # neovim
  git clone https://github.com/neovim/neovim ~/programs/neovim

  # install vim-plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # install fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}


installNpmPackages() {
    sudo npm install -g jshint
    sudo npm install -g csslint

}

configurePackages() {
  pip install --upgrade pip
}

configureGit() {
  git config --global user.email "joereynolds952@gmail.com"
  git config --global user.name "Joe Reynolds"
}

clonePersonalRepos() {

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

symlinkConfigs() {

  mkdir ~/.config/nvim
  rm ~/.config/nvim/init.vim
  rm ~/.ctags
  rm ~/.bashrc
  rm ~/.tmux.conf

  ln -s ~/programs/configs/nvim/snippets ~/.vim/minisnip
  ln -s ~/programs/configs/nvim/init.vim ~/.config/nvim/init.vim
  ln -s ~/programs/configs/ctags/.ctags ~/.ctags
  ln -s ~/programs/configs/bash/.bashrc ~/.bashrc
  ln -s ~/programs/configs/tmux/.tmux.conf ~/.tmux.conf
}
