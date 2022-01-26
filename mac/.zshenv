# alias nvim=lvim
# git {
gbcur() {
  git rev-parse --abbrev-ref HEAD
}

gb_to_issue() {
  ticket=`echo $1 | sed 's:^\([[:alnum:]]*\)/.*:\1:'`
  # really not sure why \U wasn't working in sed
  if [[ "$ticket" == "chore" ]]; then
    echo "print '$ticket'.capitalize()" | python
  else
    echo "print '$ticket'.upper()" | python
  fi
}

gitissue() {
  gb_to_issue `gbcur`
}

club() {
  open https://app.clubhouse.io/quotapath/story/$(gitissue | cut -c 3-)
}

# git unadd: remove file from
gun() { git reset HEAD $@ ;}
_gitunadd_completion() {
  git diff --cached --name-only --diff-filter=A
}
_gitunadd () {
  compadd -S '' `_gitunadd_completion`
}

alias -g ggpullqp='git pull quotapath "$(git_current_branch)"'
alias -g ggg='git pull quotapath "$(git_current_branch)"'
alias -g grssd='git restore -s develop'

# }
# docker {
alias dc='docker-compose'
dstopall() { docker stop $(docker ps -a -q) }
# }
. "$HOME/.cargo/env"
