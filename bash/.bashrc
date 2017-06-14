alias vim="nvim"
alias ls="ls --color=auto"
alias sl="ls"

#git
alias gh="git checkout"
alias gs="git status"
alias gl="git log --oneline"
alias gb="git branch"
alias gp="git push"
alias gc="git commit"
alias grepi="git grep -i -- $1"

#conf aliases
alias conf-vim="vim ~/.vimrc"
alias conf-bash="vim ~/.bashrc"
alias conf-git="vim ~/.gitconfig"
alias conf-dir="cd ~/programs/configs"
alias conf-gtk="vim ~/.config/gtk-3.0/gtk.css"
alias conf-conky="vim ~/.config/conky/conky.conf"
alias conf-openbox="vim ~/.config/openbox/rc.xml"

#docker
alias dcu="docker-compose up"

#neatly format json
json() {
  python3 -m json.tool $1
}

grepall() {
  for directory in $(ls $1) ;
  do 
    cd "${directory}"
    echo "-------------${directory}-------------"
    git grep -i $2
    echo "--------------------------------------"
    cd - 
  done
}

# fb - checkout git branch
fb() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}


# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

force_color_prompt=yes

source ~/programs/up/rc.sh

export PATH=~/.composer/vendor/bin:$PATH
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'

