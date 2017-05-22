alias ls="ls --color=auto"
alias sl=ls

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

#neatly format json
function json() {
  python3 -m json.tool $1
}

function grepall() {
  for directory in $(ls $1) ;
  do 
    cd "${directory}"
    echo "-------------${directory}-------------"
    git grep -i $2
    echo "--------------------------------------"
    cd - 
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

export PATH=~/.composer/vendor/bin:$PATH
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
