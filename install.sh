# Assumes Manjaro
rm -f ~/.bashrc

sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd -
rm -rf yay-git

yay -S dbeaver
yay -S fd
yay -S flameshot
yay -S fzy
yay -S google-chrome
yay -S i3
yay -S moreutils
yay -S neovim
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
stow bash git i3 nvim dmenu-scripts ssh xdg-dirs -t ~/
cd -

# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
