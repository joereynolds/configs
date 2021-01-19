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
wget https://raw.githubusercontent.com/rupa/z/master/z.sh
mv ./z.sh ~/z.sh

# Install dbeaver
wget https://github.com/dbeaver/dbeaver/releases/download/7.3.3/dbeaver-ce_7.3.3_amd64.deb
sudo dpkg -i dbeaver-ce_7.3.3_amd64.deb
rm dbeaver-ce_7.3.3_amd64.deb


rm -f ~/.gitconfig ~/.bashrc ~/.config/i3/config ~/.config/nvim/init.vim ~/bin/keys ~/bin/todo

ln -sr ./files/dotfiles/.gitconfig ~/.gitconfig
ln -sr ./files/i3/config ~/.config/i3/config
ln -sr ./files/nvim/init.vim ~/.config/nvim/init.vim
ln -sr ./files/dotfiles/.bashrc ~/.bashrc

ln -sr ./files/dmenu-scripts/keys ~/bin/keys
ln -sr ./files/dmenu-scripts/todo ~/bin/todo

# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
