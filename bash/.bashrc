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

grepia () {

  if [ "$1" = "" ]; then
      echo "No arguments supplied for grepia"
      return
  fi

  for directory in ~/code/*/;

  do 
    cd "${directory}"

    if git grep -i $1 >/dev/null
    then
        echo "[$(basename ${directory})]"
        git grep -i "$1"
    fi
    cd - >/dev/null

  done
}

report_unused_functions() {
  # Find the function
  # Remove the ampersands for pass by reference functions
  # Remove everything after and including the ( in the function name
  git grep -Ei '(public|private|protected) function' $1 | awk '{print $4}' | tr -d '&' | cut -f1 -d"(" | while read -r function ; do
      
    match_count="$(git grep -i $function| wc -l)"

    if [ "$match_count" -lt 2 ]; then
      echo "$function can be removed. $match_count match"
    fi
    
  done 
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

