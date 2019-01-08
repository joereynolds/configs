alias vim="nvim"
alias ls="ls --color=auto"
alias lewis="i3lock --color=000000"
alias movescreen="xrandr --output DP-1-1 --above eDP-1"
alias gs="git status"
alias gl="git log --oneline"
alias t="vim ~/Dropbox/Apps/Simpletask/todo.txt"

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

grepblame() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

# Does a thing in each directory
# i.e. `all 'git status'` will run git status in each directiry
all() {
    for directory in ./*; do 
        printf "\033[0;32m----==$directory==----\033[0m\n"
        cd $directory
        $1  
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

source ~/git-prompt.sh
source ~/z.sh
source ~/.private_bashrc

export  PS1='\w$(__git_ps1 " (%s)")\n: '
force_color_prompt=yes

export PATH=~/.composer/vendor/bin:$PATH
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'
export PATH=$PATH:~/Downloads/dasht-2.2.0/bin
export MANPATH=~/Downloads/dasht-2.2.0/man:$MANPATH


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
