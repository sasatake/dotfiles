#!/bin/bash

BREW_FILE="${DOTFILES_HOME}/etc/brew/Brewfile"

brew_update(){
  info "brew bundle update"
  brew bundle --file=$BREW_FILE && clear "complete brew update"
}

title "brew update"
brew_is_not_installed || brew_update