# Assumes Ubuntu 20.04

# Ubuntu likes to have its own .bashrc file (rudely) present, remove it.
rm -f ~/.bashrc

packagelist=(
  arandr 
  composer 
  curl 
  dunst
  ffmpeg
  flameshot
  fzy 
  git  
  gparted
  htop 
  i3-wm 
  i3lock 
  i3status 
  meld 
  moreutils 
  nodejs 
  npm 
  pavucontrol 
  rofi
  simplescreenrecorder 
  stow
  suckless-tools 
  tree
  vlc
  xclip 
  xdotool 
)

sudo apt-add-repository ppa:maarten-baert/simplescreenrecorder
sudo apt-get update

sudo apt-get install ${packagelist[@]}

sudo snap install --classic ripgrep
sudo snap install spotify

# Install fd
wget -O /tmp/fd.deb https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
sudo dpkg -i /tmp/fd.deb

# Install dbeaver
wget -O /tmp/dbeaver.deb https://github.com/dbeaver/dbeaver/releases/download/7.3.3/dbeaver-ce_7.3.3_amd64.deb
sudo dpkg -i dbeaver.deb

# Install z
wget -O ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

# Install neovim
wget -O /usr/local/bin/nvim https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
chmod a+x /usr/local/bin/nvim

# Symlink our configs
cd ./dotfiles
stow bash git i3 nvim dmenu-scripts ssh -t ~/
cd -

# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
