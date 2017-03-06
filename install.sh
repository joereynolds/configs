#!/bin/bash

source ./functions.sh

mkdir -p ~/programs

echo 'Configuring Git'
configureGit()

echo 'Cloning personal repositories'
clonePersonalRepos()

echo 'Installing apt packages'
installPackages()

echo 'Symlinking configs'
symlinkConfigs()