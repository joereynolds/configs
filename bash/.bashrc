#general aliases
alias sl=ls
alias vrc="vim ~/.vimrc"
alias brc="vim ~/.bashrc"
alias shutdown="sudo shutdown -h now"
alias wiki="vim ~/Documents/wiki/main.wiki"
alias aperr="cat /var/log/apache2/error.log"
alias learn="vim ~/Documents/txt/things-to-learn"
alias rgetd="cd /var/www/html/reap-get.com/public_html/starterkit"

#git aliases
alias gp="git pull"
alias gpu="git push"
alias gf="git fetch"
alias ga="git add -p"
alias gb="git branch"
alias gc="git commit"
alias gs="git status"
alias gr="git remote -v"
alias gpo="git push origin $1"
alias grepi="git grep -i -- $1"

#conf aliases
alias conf-vim="vim ~/.vimrc"
alias conf-bash="vim ~/.bashrc"
alias conf-git="vim ~/.gitconfig"
alias conf-gtk="vim ~/.config/gtk-3.0/gtk.css"
alias conf-conky="vim ~/.config/conky/conky.conf"
alias conf-openbox="vim ~/.config/openbox/rc.xml"

#Funny story. I originally called this 'fi' as shorthand
#but that conflicted with the 'fi' keyword to signal
#the end of an if statement. That means that I lost
#all of my tab completion and cost me a few hours
#in scratching my head. Oh the joys of
#being an idiot...
alias get="find -iname $1"
alias gets="find -iname *$1*"

#Delete a git branch both locally and remotely
delbranch() {
    git push origin --delete $1;
    git push upstream --delete $1;
}

#Clear the local memcached
clearcache() {
    sudo service memcached restart
}

#neatly format xml, requires xmllint
xml(){
    xmllint $1 --format - | less
}

#Returns the value of an xml node if it exists
#Returns $3 results or 10 if not specified
#examples
#    xmlfind property.xml cweblink 5
#    xmlfind property.xml cweblink
xmlfind() {
    xml $1 | grep $2 | head -n${3:-10}
}

#neatly format json, requires python
json(){
    python3 -m json.tool $1
}

#Run interactive php shell
psy() {
    ~/programs/psysh
}

#Run interactive php shell with a file
psyf() {
    ~/programs/psysh $1
}

#Run a local server in the current directory
serve() {
    sudo php -S localhost:999
}

# start up reap-get locally
rget() {
    echo "reap-get now available on port 666"
    cd /var/www/html/reap-get.com/public_html/starterkit
    sudo php -S localhost:666
}

# Starts up ncmpcpp, removes the tcp
# port on 6600 since it conflicts with mpd
music() {
    sudo fuser -k 6600/tcp
    mpd
    ncmpcpp
}

# Start JRA locally
jra() {
    echo "jra now available on port 667"
    cd /var/www/html/joe-reynolds-audio
    sudo php -S localhost:667
}

testconf() {
    echo "This will refresh the live site's cache. Are you sure you want to run this?[y/n]"

    read input
    if [ "$input" == "y" ]
    then
        echo "Ran successfully"
    else
        echo "Process aborted"
    fi
}

#knowledgeable cow
echo 'What is' `shuf -n 1 ~/Documents/txt/things-to-learn`? | cowsay

#work sensitive rc not for prying eyes
source ~/.private_bashrc

# show a date on the right hand side
rightprompt() {
    printf "%*s" $COLUMNS "$(date +%T) ";
}

#A simpler prompt
source ~/.git-prompt.sh
PS1="\033[0;32m\$(__git_ps1)\n\[\033[0;32m\]\$(tput sc; rightprompt; tput rc)\033[0;31m:: \033[0;34m\W \033[0;31m:: \033[0;30m"
export PS1
