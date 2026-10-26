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
# nix profile install nixpkgs#stow
# nix profile install nixpkgs#rofi
# nix profile install github:joereynolds/jn

yay -S dbgate
yay -S docker
yay -S docker-compose
yay -S dropbox
yay -S fd
yay -S flameshot
yay -S fzy
yay -S google-chrome
yay -S i3
yay -S kdenlive
yay -S moreutils
yay -S neovim
yay -S keepassxc
yay -S qbittorrent
yay -S picom
yay -S realtime-privileges # used with yabridgectl
yay -S reaper-bin
yay -S ripgrep
yay -S rofi
yay -S simplescreenrecorder
yay -S spotify
yay -S steam
yay -S tiled
yay -S yabridge
yay -S yabridgectl
yay -S z

# Symlink our configs
cd ./dotfiles
stow bash git i3 jn nvim dmenu-scripts ssh ripgrep picom tmux -t ~/
cd -
