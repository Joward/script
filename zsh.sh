#!/bin/sh

# exit on error
set -e

# Ubuntu
# sudo apt update
# sudo apt install zsh
# chsh -s /usr/bin/zsh

# CentOS
# update Repo

sudo yum install zsh
chsh -s /bin/zsh

echo $SHELL

sh -c "$(wget -O- https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)"

# theme : bira
# plugin : auto-complete
