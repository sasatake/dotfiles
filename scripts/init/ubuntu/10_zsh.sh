#!/bin/bash

readonly ZPLUG_INSTALL_URL=https://raw.githubusercontent.com/zplug/installer/master/installer.zsh


zsh_is_not_installed(){
  ! type zsh > /dev/null
}

zplug_is_not_installed(){
  ! type zplug > /dev/null
}

install_zsh(){
  info "start installing z shell..."
  yes | sudo apt install zsh && clear "zsh is installed by apt"
}

install_zplug(){
  info "start installing zplug..."
  curl -sL --proto-redir -all,https ${ZPLUG_INSTALL_URL} | zsh && clear "zplug is installed"
}

zsh_is_not_login_shell(){
  [ $SHELL != $(which zsh) ]
}

set_zsh_to_login_shell(){
  info "zsh to login shell.please input sudo password..."
  echo $(which zsh) | sudo -k tee -a /etc/shells > /dev/null
  chsh -s $(which zsh)
  clear "$(zsh --version)"
}

sub_title "Check Shell"
zsh_is_not_installed && install_zsh || clear "zsh path is $(which zsh)"
zplug_is_not_installed && install_zplug && clear "zplug is installed"
zsh_is_not_login_shell && set_zsh_to_login_shell || clear "$(zsh --version)"