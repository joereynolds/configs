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

