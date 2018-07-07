#!/bin/bash

BREW_FILE="${DOTFILES_HOME}/etc/brew/Brewfile"

brew_update(){
  info "brew bundle update"
  brew bundle --file=$BREW_FILE && clear "complete brew update"
}

sub_title "Brew Update"
brew_is_not_installed || brew_update