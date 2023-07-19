#!/bin/sh

# exit on error
set -e

sudo apt update
sudo apt install zsh

chsh -s /usr/bin/zsh
echo $SHELL