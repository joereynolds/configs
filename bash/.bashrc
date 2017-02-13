alias sl=ls

alias gs="git status"
alias grepi="git grep -i -- $1"

#conf aliases
alias conf-vim="vim ~/.vimrc"
alias conf-bash="vim ~/.bashrc"
alias conf-git="vim ~/.gitconfig"
alias conf-dir="cd ~/programs/configs"
alias conf-gtk="vim ~/.config/gtk-3.0/gtk.css"
alias conf-conky="vim ~/.config/conky/conky.conf"
alias conf-openbox="vim ~/.config/openbox/rc.xml"

#neatly format json, requires python
json() {
    python3 -m json.tool $1
}

#Run interactive php shell
psy() {
    ~/programs/psysh
}

export PATH=~/.composer/vendor/bin:$PATH
