alias vim="nvim"
alias ls="ls --color=auto"
alias movescreen="xrandr --output DP-1 --above eDP-1"
alias gs="git status"
alias gl="git log --oneline"
alias gn="~/Downloads/Goneovim-0.4.9-linux/goneovim"

cdr() {
    cd $(git rev-parse --show-toplevel)
}

grab() {
    curl -s $1 | pandoc --from=html --to=markdown | glow - -p -s light -w 80
}

fzgb() {
    git checkout $(git branch | tr -d ' *' | fzy)
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

reduce_brightness() {
    brightness=$(echo "$(cat /sys/class/backlight/intel_backlight/brightness) - 1000" | bc)
    echo "Reducing brightness to $brightness"
    sudo bash -c "echo $brightness > /sys/class/backlight/intel_backlight/brightness"
}

increase_brightness() {
    brightness=$(echo "$(cat /sys/class/backlight/intel_backlight/brightness) + 1000" | bc)
    echo "Increasing brightness to $brightness"
    sudo bash -c "echo $brightness > /sys/class/backlight/intel_backlight/brightness"
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
export CLOUDSDK_PYTHON=/usr/bin/python

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joe.reynolds/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/joe.reynolds/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/joe.reynolds/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/joe.reynolds/Downloads/google-cloud-sdk/completion.bash.inc'; fi
