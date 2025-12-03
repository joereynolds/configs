eval `ssh-agent`

alias vim="nvim"
alias ls="ls --color=auto"
alias gs="git status"
alias xflux="xflux -l 53.19 -g -2.89"

. ~/.private-bashrc

cdr() {
    cd $(git rev-parse --show-toplevel)
}

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

. /usr/share/git/git-prompt.sh

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export  PS1='\w$(__git_ps1 " (%s)")\n: '
force_color_prompt=yes

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'
export PATH=~/.composer/vendor/bin:$PATH
export PATH="$PATH:/home/joe/bin"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
