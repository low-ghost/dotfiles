#!/bin/bash
echo "===============installing basic dev tools==============="
apt-get update > /dev/null
echo "===============git==============="
apt-get install git -y > /dev/null
echo "===============vim-nox 'cus of +clipboard and other goodies==============="
apt-get install vim-nox -y > /dev/null
echo "===============python-software-properties, build-essential==============="
apt-get install python-software-properties build-essential -y > /dev/null
echo "===============tmux==============="
apt-get install tmux -y > /dev/null
cp /vagrant/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
echo "===============php repo==============="
add-apt-repository ppa:ondrej/php5 -y > /dev/null
echo "===============update==============="
apt-get update -y > /dev/null
echo "===============curl==============="
apt-get install curl php5-curl -y > /dev/null
echo "===============oh-my-zsh==============="
apt-get install zsh -y > /dev/null
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh 
chsh -s /bin/zsh vagrant
