#!/bin/bash
install='false'

while getopts ':i' opt; do
	case $opt in
		i)
			#install neovim
			sudo apt-get install -y software-properties-common
			sudo add-apt-repository ppa:neovim-ppa/unstable
			sudo apt-get update
			sudo apt-get install -y neovim python-dev python-pip python3-dev python3-pip
			pip install neovim
			pip3 install neovim
			sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
			sudo update-alternatives --config vi
			sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
			sudo update-alternatives --config vim
			sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
			sudo update-alternatives --config editor
			;;
	esac
done

#vim
mkdir -p ~/.config/nvim
mkdir -p ~/.config/vim
ln symlinks/init.vim ~/.config/nvim/init.vim
ln symlinks/general.vim ~/.config/vim/general.vim
ln symlinks/plugins.vim ~/.config/vim/plugins.vim
ln symlinks/functions.vim ~/.config/vim/functions.vim

#firefox
ln symlinks/.vimperatorrc ~/.vimperatorrc

#zsh
ln symlinks/.zshrc ~/.zshrc
ln symlinks/.aliases ~/.aliases
ln symlinks/.inputrc ~/.inputrc
