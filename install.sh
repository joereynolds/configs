# Assumes Manjaro
rm -f ~/.bashrc

sudo pacman -Syu
sudo pacman -S --needed base-devel git

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd -
rm -rf yay-git

yay -S dbeaver
yay -S docker
yay -S docker-compose
yay -S dropbox
yay -S fd
yay -S flameshot
yay -S fzy
yay -S google-chrome
yay -S i3
yay -S meld
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
yay -S stow
yay -S tiled
yay -S tree
yay -S yabridge
yay -S yabridgectl
yay -S z

# Symlink our configs
cd ./dotfiles
stow bash git i3 nvim dmenu-scripts ssh ripgrep picom tmux -t ~/
cd -

this_dir=$(pwd)
ln -sf this_dir/dotfiles/remind/.reminders ~/.reminders

# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
