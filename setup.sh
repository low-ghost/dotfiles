#!/bin/bash
echo 'super awesome setup script'
while getopts ':i:lr' opt; do
  case $opt in
    i)
      echo 'installing...'
      for arg in $(echo $OPTARG | tr ',' '\n')
      do
        case $arg in
          basic)
            echo 'curl, git, xsel, zsh, cmake, ag'
            sudo apt-get install -y curl git xsel zsh build-essential checkinstall software-properties-common silversearcher-ag
            chsh -s $(which zsh)
            sudo add-apt-repository ppa:george-edison55/cmake-3.x
            sudo apt-get update
            sudo apt-get install -y cmake
            ;;
          omz)
            echo 'oh-my-zsh'
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
            ;;
          tmux)
            echo 'tmux (from repo)'
            cd ~/repo
            git clone https://github.com/tmux/tmux.git
            cd tmux
            sudo apt-get install ncurses-dev libevent-dev
            sh autogen.sh
            sudo ./configure && sudo make
            sudo make install
            sudo cp tmux /usr/bin
            ;;
          neovim)
            echo 'neovim'
            mkdir -p ~/.config/nvim
            mkdir -p ~/.config/vim
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
            curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            ;;
          termite)
            echo 'termite'
            mkdir -p ~/repo
            cd ~/repo
            git clone --recursive https://github.com/thestinger/termite.git
            git clone https://github.com/thestinger/vte-ng.git
            sudo apt-get install -y g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac
            sudo apt-get install -y libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev
            sudo apt-get install -y libxml2-utils gperf
            cd vte-ng && ./autogen.sh && make && sudo make install
            cd ../termite && make && sudo make install
            sudo desktop-file-install termite.desktop
            sudo cp /usr/local/lib/libvte-2.91.a /usr/local/lib/libvte-2.91.la \
              /usr/local/lib/libvte-2.91.so /usr/local/lib/libvte-2.91.so.0 \
              /usr/local/lib/libvte-2.91.so.0.4200.4 /usr/lib
            sudo mkdir -p /lib/terminfo/x
            sudo ln -fs /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
            ;;
          nvm)
            curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
            source ~/.zshrc
            nvm install v5
            nvm alias latest v5
            ;;
          chrome)
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
            sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            sudo apt-get update
            sudo apt-get install google-chrome-stable
            ;;
          :)
            echo "Invalid option"
            exit 1
            ;;
          \?)
            echo "Invalid option"
            exit 1
            ;;
        esac
      done
      ;;
    l)
      echo 'linking...'
      cd ~/repo/dotfiles
      #nvim
      ln -f init.vim ~/.config/nvim/init.vim
      ln -f general.vim ~/.config/vim/general.vim
      ln -f plugins.vim ~/.config/vim/plugins.vim
      ln -f functions.vim ~/.config/vim/functions.vim
      #firefox
      ln -f .vimperatorrc ~/.vimperatorrc
      #zsh and aliases
      ln -f .zshrc ~/.zshrc
      ln -f .aliases ~/.aliases
      ln -f .shellaliases ~/.shellaliases
      ln -f .compdef ~/.compdef
      ln -f .inputrc ~/.inputrc
      #tmux
      ln -f .tmux.conf ~/.tmux.conf
      #xcape
      ln -f .xcaperc ~/.xcaperc
      sudo ln -f xkb/cu /usr/share/X11/xkb/symbols/cu
      #pg
      ln -f .pgsqlrc ~/.pgsqlrc
      ;;
    r)
      echo 'removing links...'
      rm ~/.config/nvim/init.vim
      rm ~/.config/vim/*.vim
      rm ~/.vimperatorrc
      rm ~/.zshrc
      rm ~/.aliases
      rm ~/.inputrc
      rm ~/.tmux.conf
      rm ~/.xcaperc
      sudo rm /usr/share/X11/xkb/symbols/cu
      ;;
  esac
done
