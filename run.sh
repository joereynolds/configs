sudo apt update
sudo apt install git   
sudo apt install software-properties-common
sudo apt install ansible

ansible-playbook --ask-become-pass -i ./hosts play.yml
