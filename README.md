# Configs
My dotfiles and configs



# Moving to ansible

Checking it's up:

```
ansible all -m ping --ask-pass
```

Running the playbook:

```
ansible-playbook --ask-become-pass -i /etc/ansible/hosts play.yml
```
