sudo apt update
sudo apt install git   
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

ansible-playbook --ask-become-pass -i ./hosts play.yml
