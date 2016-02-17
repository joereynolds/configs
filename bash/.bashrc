source ~/.private_bashrc

#general aliases
alias sl=ls
alias vrc="vim ~/.vimrc"
alias brc="vim ~/.bashrc"
alias fi="find -iname $1"
alias wiki="vim ~/Documents/wiki/main.wiki"

#git aliases
alias gp="git pull"
alias gpu="git push"
alias gf="git fetch"
alias gb="git branch"
alias gc="git commit"
alias gs="git status"
alias gr="git remote -v"
alias gpo="git push origin $1"
alias grepi="git grep -i -- $1"

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
