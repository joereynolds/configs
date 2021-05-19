# Assumes Manjaro
rm -f ~/.bashrc

sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay-git.git
cd yay
makepkg -si

yay -S dbeaver
yay -S fd
yay -S flameshot
yay -S fzy
yay -S google-chrome
yay -S neovim
yay -S node
yay -S tiled
yay -S ripgrep
yay -S simplescreenrecorder
yay -S spotify
yay -S steam
yay -S stow
yay -S tree
yay -S yabridge
yay -S yabridgectl
yay -S z

# Symlink our configs
cd ./dotfiles
stow bash git i3 nvim dmenu-scripts ssh -t ~/
cd -

# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null

# TODO - 
# packagelist=(
#   arandr 
#   composer 
#   dunst
#   i3-wm 
#   i3lock 
#   i3status 
#   meld 
#   moreutils 
#   pavucontrol 
#   rofi
#   suckless-tools 
#   xclip 
#   xdotool 
# )
