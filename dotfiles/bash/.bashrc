alias vim="nvim"
alias ls="ls --color=auto"
alias de="cd ~/Desktop"
alias gonv="~/Downloads/gonvim/gonvim.sh ."

#git
alias gs="git status"
alias gl="git log --oneline"

#conf aliases
alias conf-dir="cd ~/programs/configs"

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

# Looks through a CSS file given as the first argument.
# Searches through all files that aren't css or scss files
find_unused_css() {

    if [ -z "$1" ]; then
        echo "Please specify a css file i.e. find_unused_css my-css-file.css"
        return 1
    fi

    selectors="$(rg -i ^[#\.] $1 | cut -d' ' -f1 | tr -d \{,.\#)"

    for selector in $selectors; do
        match_count="$(rg -i --iglob='!*.{css,scss}' "$selector" | wc -l)"

        if [ "$match_count" -lt 1 ]; then
          printf "$match_count usages found. \033[0;32m$selector \033[0mcan probably be removed\n"
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

source ~/programs/up/rc.sh
source ~/git-prompt.sh

export  PS1='\w$(__git_ps1 " (%s)")\n: '
force_color_prompt=yes

export PATH=~/.composer/vendor/bin:$PATH
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'
