alias vim="nvim"
alias ls="ls --color=auto"
alias movescreen="xrandr --output DP-1 --above eDP-1"
alias gs="git status"
alias gl="git log --oneline"

grab() {
    curl -s $1 | pandoc --from=html --to=markdown | glow - -p -w 80
}

fzgb() {
    git checkout $(git branch | tr -d ' *' | fzy)
}

# fuzzy find and open with vim
fzfd() {
    fd --no-ignore $1 | fzy | vim
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

grepblame() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

# Does a thing in each directory
# i.e. `all 'git status'` will run git status in each directory
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

source ~/z.sh
source ~/base16-papercolor-light.sh

export  PS1='\w$(__git_ps1 " (%s)")\n: '
force_color_prompt=yes

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'
export PATH=~/.composer/vendor/bin:$PATH
export PATH="$PATH:/home/joe/bin"
export MANPATH=~/Downloads/dasht-2.2.0/man:$MANPATH
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
