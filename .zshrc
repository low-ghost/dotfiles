ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# source $HOME/repo/sandboxd/sandboxd
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ~/.oh-my-zsh/themes/powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode aws)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.aliases
source ~/.secrets
source ~/.nvm/nvm.sh

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
bindkey '\ea' insert-last-word
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" history-beginning-search-backward
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" history-beginning-search-forward

export HISTTIMEFORMAT="%d/%m/%y %T "

NVIM_TUI_ENABLE_TRUE_COLOR=1
TERM=screen-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$HOME/.nvim/plugged/gruvbox/gruvbox_256palette.sh"

# vim_ins_mode="INSERT"
# vim_cmd_mode="NORMAL"
# vim_mode=$vim_ins_mode

# function zle-keymap-select {
#   vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
#   __promptline
#   zle reset-prompt
# }
# zle -N zle-keymap-select

# function zle-line-finish {
#   vim_mode=$vim_ins_mode
# }
# zle -N zle-line-finish

# function TRAPINT() {
#   vim_mode=$vim_ins_mode
#   return $(( 128 + $1 ))
# }

# source ~/.promptline_dark

# nvm use latest > /dev/null

# Add java path
export JAVA_HOME=/opt/java/jdk1.8.0_102
export JRE_HOME=/opt/java/jdk1.8.0._102/jre
export PATH=$PATH:/opt/java/jdk1.8.0_102/bin:/opt/java/jdk1.8.0_102/jre/bin
export PATH=/opt/apache-maven-3.3.9/bin:$PATH

# Add repo bin to path
export PATH=$HOME/repo/dotfiles/bin:$PATH

# Add go path
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Adr tools
export PATH=$PATH:$HOME/repo/adr-tools/src/

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$PYENV_ROOT/bin
export AWS_REGION=us-east-1

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator vi_mode dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext status background_jobs virtualenv pyenv time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_package_name"
POWERLEVEL9K_VI_INSERT_MODE_STRING="I"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="N"
POWERLEVEL9K_DIR_HOME_BACKGROUND='4'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='4'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='4'
# POWERLEVEL9K_DIR_HOME_FOREGROUND='236'
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='236'
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='236'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='66'
# POWERLEVEL9K_VCS_CLEAN_BACKGROUND='119'
# POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214'
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='236'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='3'
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='236'
POWERLEVEL9K_TIME_BACKGROUND='15'

POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='4'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='1'

POWERLEVEL9K_KUBECONTEXT_BACKGROUND='166'
POWERLEVEL9K_KUBECONTEXT_FOREGROUND='236'

# Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
source /usr/share/rvm/scripts/rvm
source <(kubectl completion zsh)
export PATH="$PATH:/usr/share/rvm/bin"


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/low-ghost/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/low-ghost/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/low-ghost/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/low-ghost/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/low-ghost/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /home/low-ghost/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh
[ -s "/home/low-ghost/.jabba/jabba.sh" ] && source "/home/low-ghost/.jabba/jabba.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/low-ghost/.sdkman"
[[ -s "/home/low-ghost/.sdkman/bin/sdkman-init.sh" ]] && source "/home/low-ghost/.sdkman/bin/sdkman-init.sh"
