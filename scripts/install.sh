#!/bin/bash

set -eu

############ vars ################

readonly SPACE=" "

readonly ESC="\e["
readonly ESCEND="m"
readonly STYLE_OFF="${ESC}${ESCEND}"

readonly TEXT_RED="31"
readonly TEXT_GREEN="32"
readonly TEXT_CYAN="36"
readonly TEXT_WHITE="37"
readonly TEXT_BOLD="1"
readonly TEXT_UNDER_LINE="4"

readonly DOTFILES_HOME="${HOME}/.dotfiles"
readonly DOTFILES_URL="https://github.com/sasatake/dotfiles.git"
readonly BREW_PATH_HOME="/usr/local/bin"
readonly BREW_PATH="${BREW_PATH_HOME}/brew"
readonly GIT_PATH="${BREW_PATH_HOME}/git"

############ functions ################

title() {
  TITLE_STYLE="${ESC}${TEXT_WHITE};${TEXT_UNDER_LINE}${ESCEND}"
  printf "\n\n${TITLE_STYLE}%s${STYLE_OFF}\n\n" "$*"
}

info(){
  INFO_PREFIX_STYLE="${ESC}${TEXT_CYAN}${ESCEND}"
  INFO_TEXT_STYLE="${ESC}${TEXT_BOLD}${ESCEND}"
  printf "${INFO_PREFIX_STYLE}info${STYLE_OFF} ${INFO_TEXT_STYLE}%s${STYLE_OFF}\n" "$*"
}

clear(){
  DONE_PREFIX_STYLE="${ESC}${TEXT_GREEN}${ESCEND}"
  DONE_TEXT_STYLE="${ESC}${TEXT_BOLD}${ESCEND}"
  printf "\n${DONE_PREFIX_STYLE}✔${STYLE_OFF}${SPACE}${DONE_TEXT_STYLE}%s${STYLE_OFF}\n" "$*"
}

error(){
  ERROR_PREFIX_STYLE="${ESC}${TEXT_RED}${ESCEND}"
  printf "${ERROR_PREFIX_STYLE}%s${STYLE_OFF}\n" "✖${SPACE}$*" 1>&2
  exit 1
}

is_mac_os(){
  info "uname is $(uname)"
  [ "$(uname)" == 'Darwin' ]
}

brew_is_not_installed(){
  [ ! -x $BREW_PATH ]
}

git_is_not_installed(){
  [ ! -x $GIT_PATH ]
}

dotfiles_not_exist(){
  [ ! -d $DOTFILES_HOME ]
}

install_brew_command(){
  info "brew is not installed"
  info "start installing brew command..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  clear "brew is installed"
}

install_git_command(){
  info "git is not installed by brew"
  info "start installing git command..."
  brew install git
  clear "git is installed by brew"
}

clone_dotfiles(){
  clear "dotfiles not exist"
  info "start cloning dotfiles..."
  git clone ${DOTFILES_URL} ${DOTFILES_HOME}
  clear "finish cloning dotfiles"
}

pull_dotfiles(){
  info "start pulling dotfiles..."
  git -C ${DOTFILES_HOME} pull
  clear "dotfiles is up to date"
}

download(){
  title "Check OS Type"
  is_mac_os && clear "OS is Mac OS" || error "Sorry, this script is only for Mac OS"

  title "Check Brew Command is installed"
  brew_is_not_installed && install_brew_command || clear "brew is already installed"

  title "Check Git Command is installed"
  git_is_not_installed && install_git_command || clear "git is already installed by brew"

  title "Check Dotfiles exist"
  dotfiles_not_exist && clone_dotfiles || clear "dotfiles already exist"

  title "Update Dotfiles"
  pull_dotfiles
}

deploy(){
  title "deploy"
  info "start making symbolic link..."
  for dotfile in `ls -A $DOTFILES_HOME/home/`;do
    ln -sfnv $DOTFILES_HOME/home/$dotfile $HOME/$dotfile
  done
  clear "finish making symbolic link of dotfiles"
}

initialize(){
  title "initialize"
  info "start executing initialize scripts"
  for scirpt in `ls -v $DOTFILES_HOME/scripts/init/*`;do
    source $scirpt
  done
  clear "finish executing initialize scripts"
}

############   main    ################

download && deploy && initialize