eval `ssh-agent`

alias vim="nvim"
alias ls="ls --color=auto"
alias gs="git status"
alias r="vim ~/.reminders"

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

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:/home/joe/bin"
export PATH="$PATH:/home/joe/.local/bin"
export PATH=/home/joe/.opencode/bin:$PATH
export PATH=/home/joe/.nimble/bin:$PATH
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export EDITOR=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/home/joe/.git-ai/bin:$PATH" # Added by git-ai installer on Wed Apr 29 03:09:45 PM BST 2026

[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh
[ -f ~/.private-bashrc ] && . ~/.private-bashrc
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export  PS1='\w$(__git_ps1 " (%s)")\n: '
force_color_prompt=yes
