#!/bin/bash

mkdir -p ~/programs
mkdir -p ~/code

source ../up/functions.sh
source functions.sh


echo 'Configuring Git'
configureGit

echo 'Cloning personal repositories'
clonePersonalRepos

echo 'Installing apt packages'
addAptRepositories
installPackages
configurePackages
installNpmPackages

echo 'Symlinking configs'
symlinkConfigs
