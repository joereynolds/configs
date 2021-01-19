# Assumes Ubuntu 20.04
sudo apt update

sudo apt install \
   arandr \
   composer \
   curl \
   fzy \
   git \ 
   htop \
   i3-wm \
   i3lock \
   i3status \
   kde-spectacle \
   meld \
   moreutils \
   nodejs \
   npm \
   pavucontrol \
   rake \
   simplescreenrecorder \
   suckless-tools \
   xclip \
   xdotool \

sudo snap install --classic ripgrep


# Install and run vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
