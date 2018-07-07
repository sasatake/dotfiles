#!/bin/bash

readonly ZSH_PATH="${BREW_PATH_HOME}/zsh"

login_shell_is_not_brew_zsh(){
  [ -L $ZSH_PATH ] && [ $SHELL != $ZSH_PATH ]
}

set_zsh_to_login_shell(){
  info "zsh to login shell.please input sudo password."
  echo $ZSH_PATH | sudo -k tee -a /etc/shells > /dev/null
  chsh -s $ZSH_PATH
  clear "$($SHELL --version)"
}

title "Check Shell"
login_shell_is_not_brew_zsh && set_zsh_to_login_shell || clear "$($SHELL --version)"