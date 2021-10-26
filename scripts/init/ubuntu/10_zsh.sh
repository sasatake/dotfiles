#!/bin/bash

zsh_is_not_installed(){
  ! type zsh > /dev/null
}

install_zsh(){
  info "start installing z shell..."
  yes | sudo apt install zsh && clear "zsh is installed by apt"
}

zsh_is_not_login_shell(){
  [ -L $(which zsh) ] && [ $SHELL != $(which zsh) ]
}

set_zsh_to_login_shell(){
  info "zsh to login shell.please input sudo password..."
  echo $(which zsh) | sudo -k tee -a /etc/shells > /dev/null
  chsh -s $(which zsh)
  clear "$(zsh --version)"
}

sub_title "Check Shell"
zsh_is_not_installed && install_zsh || clear "zsh path is $(which zsh)"
zsh_is_not_login_shell && set_zsh_to_login_shell || clear "$(zsh --version)"