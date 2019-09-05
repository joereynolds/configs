# Configs

These are more than just dotfiles, these are everything that I frequently use on a machine.
If you just care about dotfiles, go to ./dotfiles

Made for Ubuntu 18.04

## Installing

Make sure ansible >= 2.0 is installed and then do

```
ansible-playbook --ask-become-pass -i ./hosts play.yml
```

or

```
./run.sh
```

This will clone all my favourite repos, install my dev packages and symlink all my vim stuff.

Enjoy :)
