#!/bin/bash
install='false'

while getopts ':i' opt; do
	case $opt in
		i)
			#install necessities
			sudo apt-get install -y curl git
			mkdir -p ~/repo
			cd repo
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
			
			#install termite
			git clone --recursive https://github.com/thestinger/termite.git
			git clone https://github.com/thestinger/vte-ng.git
			sudo apt-get install -y g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf
			cd vte-ng && ./autogen.sh && make && sudo make install
			cd ../termite && make && sudo make install
			sudo desktop-file-install termite.desktop
			sudo cp /usr/local/lib/libvte-2.91.a /usr/local/lib/libvte-2.91.la \
			/usr/local/lib/libvte-2.91.so /usr/local/lib/libvte-2.91.so.0 \
			/usr/local/lib/libvte-2.91.so.0.4200.4 /usr/lib
			sudo mkdir -p /lib/terminfo/x; sudo ln -s \
			/usr/local/share/terminfo/x/xterm-termite \
			/lib/terminfo/x/xterm-termite
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
