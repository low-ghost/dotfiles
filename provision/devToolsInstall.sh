#!/bin/bash
echo "installing dev tools"
sudo apt-get update > /dev/null
echo "git"
sudo apt-get install git -y > /dev/null
echo "vim-nox"
sudo apt-get install vim-nox -y > /dev/null
echo "python-software-properties, build-essential"
sudo apt-get install python-software-properties build-essential -y > /dev/null
echo "tmux"
sudo apt-get install tmux -y > /dev/null
echo "php repo"
sudo add-apt-repository ppa:ondrej/php5 -y > /dev/null
echo "update"
sudo apt-get update -y > /dev/null
echo "curl"
sudo apt-get install curl php5-curl -y > /dev/null
