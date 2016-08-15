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
            echo 'curl, git, xsel, zsh, cmake, ag, wmctrl, fonts'
            sudo apt-get install -y curl git xsel zsh build-essential checkinstall software-properties-common silversearcher-ag wmctrl
            chsh -s $(which zsh)
            sudo add-apt-repository ppa:george-edison55/cmake-3.x
            sudo apt-get update
            sudo apt-get install -y cmake
            git clone https://github.com/powerline/fonts ~/repo/fonts
            cd ~/repo/fonts && ./install.sh
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
          tmux)
            echo 'tmux (from repo)'
            cd ~/repo
            git clone https://github.com/tmux/tmux.git
            cd tmux
            sudo apt-get install ncurses-dev libevent-dev autotools-dev automake
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
            ;;
          nvm)
            curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
            source ~/.zshrc
            nvm install v6
            nvm alias latest v6
            ;;
          npm)
            echo 'installing lodash, typescript...'
            npm install -g lodash typescript
            ;;
          rvm)
            gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
            \curl -sSL https://get.rvm.io | bash -s stable --ruby
            ;;
          # check latest download url first, change version in zshrc if necessary and download maven manually
          java)
            sudo mkdir -p /opt/java && cd /opt/java
            sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.tar.gz
            sudo tar -zxvf jdk-8u102-linux-x64.tar.gz	
            cd jdk1.8.0_102/
            sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_102/bin/java 100  
            sudo update-alternatives --config java
            sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_102/bin/javac 100
            sudo update-alternatives --config javac
            sudo update-alternatives --install /usr/bin/jar jar /opt/java/jdk1.8.0_102/bin/jar 100
            sudo update-alternatives --config jar
            sudo update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /opt/java/jdk1.8.0_102/jre/lib/amd64/libnpjp2.so 20000
            cd ~/Downloads
            tar xzvf apache-maven-3.3.9-bin.tar.gz
            sudo mv {,/opt/}apache-maven-3.3.9
            ;;
          # Needs java and mvn
          em)
            echo 'installing ejson, hipchat, dbeaver'
            sudo mkdir -p /opt/ejson
            gem install ejson
            sudo sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list'
            wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -
            sudo apt-get update
            sudo apt-get install hipchat4
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
      #statuslines
      ln -f statuslines/.tmuxline_light ~/.tmuxline_light
      ln -f statuslines/.tmuxline_dark ~/.tmuxline_dark
      ln -f statuslines/.promptline_light ~/.promptline_light
      ln -f statuslines/.promptline_dark ~/.promptline_dark
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
