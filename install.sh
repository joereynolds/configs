#!/bin/bash
set -e

# Assumes Manjaro
rm -f ~/.bashrc

sudo pacman -Syu
sudo pacman -S --needed base-devel git

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd -
rm -rf yay-git

# Slowly moving to nix to keep my life interesting
# Games
# nix profile install nixpkgs#wesnoth
# nix profile install nixpkgs#fheroes2

# Software
# nix profile install github:joereynolds/jn

# nix profile install nixpkgs#fd
# nix profile install nixpkgs#flameshot
# nix profile install nixpkgs#kdenlive
# nix profile install nixpkgs#keepassxc
# nix profile install nixpkgs#moreutils
# nix profile install nixpkgs#picom
# nix profile install nixpkgs#ripgrep
# nix profile install nixpkgs#rofi
# nix profile install nixpkgs#simplescreenrecorder
# nix profile install nixpkgs#stow
# nix profile install nixpkgs#tiled
# nix profile install nixpkgs#yabridge
# nix profile install nixpkgs#yabridgectl
# nix profile install nixpkgs#dbgate
# nix profile install nixpkgs#docker
yay -S dropbox
yay -S google-chrome
yay -S i3
yay -S neovim
yay -S qbittorrent
yay -S realtime-privileges # used with yabridgectl
yay -S reaper-bin
yay -S spotify
yay -S steam
yay -S z

# Symlink our configs
cd ./dotfiles
stow bash git i3 jn nvim dmenu-scripts ssh ripgrep picom tmux -t ~/
cd -
