#!/bin/bash
echo 'super awesome setup script'
while getopts ':i:lr' opt; do
  case $opt in
    i)
      echo 'installing...'
      for arg in $(echo $OPTARG | tr ',' '\n')
      do
        case $arg in
          # For just the keyboard, run sh ~/repo/dotfiles/setup.sh -i xcape; source ~/repo/dotfiles/.minimal_aliases; xkb;
          all)
            sh ~/repo/dotfiles/setup.sh -i basic,repos,xcape,tmux,rvm,neovim,nvm,js-repl,npm,spotify,docker,docker-compose,omz,sandbox,pyenv,kube
            sh ~/repo/dotfiles/setup.sh -l
            vim +PlugInstall +qall
            zsh
            ;;
          basic)
            echo 'curl, xsel, zsh, cmake, ag, fonts, jq, colors'
            sudo apt-get install -y curl xsel zsh build-essential checkinstall software-properties-common jq
	    # only available from apt-get in ubuntu 18.10+
	    sudo snap install ripgrep --classic
            chsh -s $(which zsh)
            sudo add-apt-repository ppa:george-edison55/cmake-3.x
            sudo apt-get update
            sudo apt-get install -y cmake
            git clone https://github.com/powerline/fonts ~/repo/fonts
            git clone https://github.com/metalelf0/gnome-terminal-colors ~/repo/gnome-terminal-colors
            cd ~/repo/fonts && ./install.sh
            touch ~/.secrets
            ;;
          repos)
            git clone https://github.com/low-ghost/pgx ~/repo/dotfiles/bin/pgx-temp
            cp ~/repo/dotfiles/bin/pgx-temp/* ~/repo/dotfiles/bin/
            rm -rf ~/repo/dotfiles/bin/pgx-temp
            ;;
          omz)
            echo 'oh-my-zsh'
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
            ;;
          xcape)
            sudo apt-get install -y gcc pkg-config libx11-dev libxtst-dev libxi-dev
            git clone https://github.com/alols/xcape.git ~/repo/xcape
            cd ~/repo/xcape
            make
            sudo make install
            ;;
          # -y has problems for docker-engine
          docker)
            sudo apt-get update
            sudo apt-get install -y apt-transport-https ca-certificates linux-image-extra-$(uname -r)
            sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
            sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list'
            sudo apt-get update
            sudo apt-get purge lxc-docker
            apt-cache policy docker-engine
            sudo apt-get install docker-engine
            ;;
          docker-compose)
            sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
            sudo chmod +x /usr/local/bin/docker-compose
            ;;
          # Might have to manually source ~/.tmux.conf or 'prefix I' in tmux to get plugins
          tmux)
            echo 'tmux (from repo)'
            git clone https://github.com/tmux/tmux.git ~/repo/tmux
            cd ~/repo/tmux
            git checkout tags/2.6
            sudo apt-get install ncurses-dev libevent-dev autotools-dev automake
            sh autogen.sh
            sudo ./configure && sudo make
            sudo make install
            sudo cp tmux /usr/bin
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
            ;;
          neovim)
            echo 'neovim'
            mkdir -p ~/.config/nvim
            sudo add-apt-repository ppa:neovim-ppa/unstable
            sudo apt-get update
            sudo apt-get install -y neovim python-dev python-pip python3-dev python3-pip
            sudo pip install neovim
            sudo pip3 install neovim
            sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
            sudo update-alternatives --config vi
            sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
            sudo update-alternatives --config vim
            sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
            sudo update-alternatives --config editor
            curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            gem install neovim
            sudo pip3 install neovim-remote
            pip3 install pylama
            sudo pip3 install --upgrade git+https://github.com/myint/vulture
            ;;
          nvm)
            curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | bash
            source ~/.nvm/nvm.sh
            nvm install 7
            nvm alias latest 7 
            ;;
          js-repl)
            git clone https://github.com/low-ghost/js-repl ~/repo/js-repl
            cd ~/repo/js-repl/standard
            npm install
            ;;
          npm)
            echo 'installing lodash, typescript, eslint...'
            npm install -g lodash typescript eslint tern eslint-plugin-import eslint-plugin-react \
              babel-eslint flow-bin flow-typed flow-vim-quickfix flow-language-server
            ;;
          rvm)
            sudo apt-add-repository -y ppa:rael-gc/rvm
            sudo apt-get update
            sudo apt-get install rvm
            ;;
          # check latest download url first, change version in zshrc if necessary and download maven manually
          java)
            curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
            jabba install 1.9.0-180
            ;;
          pg)
            echo 'installing postgres'
            sudo apt-get install -y postgresql
            # remember to add entries in pgpass and secrets
            touch ~/.pgpass
            chmod 0600 ~/.pgpass
            ;;
          chrome)
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
            sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            sudo apt-get update
            sudo apt-get install -y google-chrome-stable
            ;;
          spotify)
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
            echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
            sudo apt-get update
            sudo apt-get install -y spotify-client
            ;;
          sandbox)
            echo "Installing and linking sandbox"
            git clone https://github.com/benvan/sandboxd ~/repo/sandboxd
            ln -f .sandboxrc ~/.sandboxrc
            ;;
          pyenv)
            echo "Installing pyenv"
            curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
            pyenv update
            ;;
          kube)
            echo "Installing kube"
            sudo snap install kubectl --classic
            ;;
          i3)
            sudo apt-get install i3 i3status dmenu feh
            git clone https://github.com/unix121/i3wm-themer ~/repo/i3wm-themer
            cd ~/repo/i3wm-themer
            cp -r scripts/* /home/$USER/.config/polybar
            ;;
          ipsec)
            sudo apt-get install strongswan strongswan-pki
            sudo apparmor_parser -R /etc/apparmor.d/usr.lib.ipsec.charon
            sudo apparmor_parser -R /etc/apparmor.d/usr.lib.ipsec.stroke
            # cp <file>.crt /etc/ipsec.d/certs/<file>.crt
            # cp <file>.key /etc/ipsec.d/private
            # cp cacert.pem /etc/ipsec.d/cacerts
            #
            # Add `<address> : ECDSA <file>.key` to /etc/ipsec.secrets
            #
            # add config to /etc/ipsec.conf:
            # conn ikev2-<address>
            #     fragmentation=yes
            #     rekey=no
            #     dpdaction=clear
            #     keyexchange=ikev2
            #     compress=no
            #     dpddelay=35s
            #     ike=aes128gcm16-prfsha512-ecp256!
            #     esp=aes128gcm16-ecp256!
            #     right=<address>
            #     rightid=<address>
            #     rightsubnet=0.0.0.0/0
            #     rightauth=pubkey
            #     leftsourceip=%config
            #     leftauth=pubkey
            #     leftcert=<file>.crt
            #     leftfirewall=yes
            #     left=%defaultroute
            #     auto=add
            #
            # sudo ipsec restart
            #
            # use:
            # sudo ipsec up ikev-2-<address>
            # sudo ipsec down ikev-2-<address>
            ;;
          other)
            sudo apt-get install postgresql
            pip install awscli --upgrade --user
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
      #this script
      ln -f setup.sh /usr/bin/dots
      #eslintrc
      ln -f .eslintrc.js ~/.eslintrc.js
      #nvim
      ln -f vim/init.vim ~/.config/nvim/init.vim
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
      #xkb
      ln -f .xcaperc ~/.xcaperc
      sudo ln -f xkb/nc /usr/share/X11/xkb/symbols/nc
      #pg
      ln -f .pgsqlrc ~/.pgsqlrc
      #statuslines
      ln -f statuslines/.tmuxline_light ~/.tmuxline_light
      ln -f statuslines/.tmuxline_dark ~/.tmuxline_dark
      ln -f statuslines/.promptline_light ~/.promptline_light
      ln -f statuslines/.promptline_dark ~/.promptline_dark
      ;;
    r)
      echo 'removing links...'
      rm ~/.config/nvim/init.vim
      rm /usr/bin/dots
      rm ~/.eslintrc.js
      rm ~/.vimperatorrc
      rm ~/.zshrc
      rm ~/.aliases
      rm ~/.inputrc
      rm ~/.tmux.conf
      rm ~/.xcaperc
      rm ~/.promptline_dark
      rm ~/.promptline_light
      rm ~/.tmuxline_light
      rm ~/.tmuxline_dark
      sudo rm /usr/share/X11/xkb/symbols/cu
      ;;
  esac
done
