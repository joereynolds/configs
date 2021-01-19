# Assumes Ubuntu 20.04
sudo apt update

packagelist=(
  arandr 
  composer 
  curl 
  fzy 
  git  
  htop 
  i3-wm 
  i3lock 
  i3status 
  kde-spectacle 
  meld 
  moreutils 
  nodejs 
  npm 
  pavucontrol 
  simplescreenrecorder 
  stow
  suckless-tools 
  xclip 
  xdotool 
)

sudo apt-get install ${packagelist[@]}

sudo snap install --classic ripgrep

# Install fd
wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
sudo dpkg -i fd_8.2.1_amd64.deb
rm fd_8.2.1_amd64.deb

# Install z
wget -O ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

# Install dbeaver
wget https://github.com/dbeaver/dbeaver/releases/download/7.3.3/dbeaver-ce_7.3.3_amd64.deb
sudo dpkg -i dbeaver-ce_7.3.3_amd64.deb
rm dbeaver-ce_7.3.3_amd64.deb

cd ./dotfiles
stow bash git i3 nvim dmenu-scripts -t ~/
cd -

# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
