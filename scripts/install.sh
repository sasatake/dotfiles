#!/bin/bash

set -eu

############ vars ################

readonly SPACE=" "

readonly ESC="\e["
readonly ESCEND="m"
readonly STYLE_OFF="${ESC}${ESCEND}"

readonly TEXT_RED="31"
readonly TEXT_GREEN="32"
readonly TEXT_MAGENTA="35"
readonly TEXT_CYAN="36"
readonly TEXT_WHITE="37"
readonly TEXT_BOLD="1"
readonly TEXT_UNDER_LINE="4"

readonly DOTFILES_HOME="${HOME}/.dotfiles"
readonly DOTFILES_URL="https://github.com/sasatake/dotfiles.git"
readonly BREW_PATH_HOME="/usr/local/bin"
readonly BREW_PATH="${BREW_PATH_HOME}/brew"
readonly GIT_PATH="${BREW_PATH_HOME}/git"
readonly OS_RELEASE_FILE="/etc/os-release"

############ functions ################

new_line(){
  printf "\n"
}

title() {
  TITLE_STYLE="${ESC}${TEXT_MAGENTA};${TEXT_UNDER_LINE};${TEXT_BOLD}${ESCEND}"
  printf "\n\n${TITLE_STYLE}%s${STYLE_OFF}\n\n" "■ $*"
}

sub_title() {
  SUB_TITLE_STYLE="${ESC}${TEXT_CYAN};${TEXT_UNDER_LINE};${TEXT_BOLD}${ESCEND}"
  printf "\n${SUB_TITLE_STYLE}%s${STYLE_OFF}\n\n" "$*"
}

info(){
  INFO_PREFIX_STYLE="${ESC}${TEXT_CYAN}${ESCEND}"
  INFO_TEXT_STYLE="${ESC}${TEXT_BOLD}${ESCEND}"
  printf "${INFO_PREFIX_STYLE}info${STYLE_OFF} ${INFO_TEXT_STYLE}%s${STYLE_OFF}\n" "$*"
}

clear(){
  DONE_PREFIX_STYLE="${ESC}${TEXT_GREEN}${ESCEND}"
  DONE_TEXT_STYLE="${ESC}${TEXT_BOLD}${ESCEND}"
  printf "${DONE_PREFIX_STYLE}✔${STYLE_OFF}${SPACE}${DONE_TEXT_STYLE}%s${STYLE_OFF}\n" "$*"
}

error(){
  ERROR_PREFIX_STYLE="${ESC}${TEXT_RED}${ESCEND}"
  printf "${ERROR_PREFIX_STYLE}%s${STYLE_OFF}\n" "✖${SPACE}$*" 1>&2
  exit 1
}

is_mac_os(){
  [ "$(uname)" == 'Darwin' ]
}

is_ubuntu(){
  [ "$(uname)" == 'Linux' ] && grep 'Ubuntu' ${OS_RELEASE_FILE} > /dev/null
}

brew_is_not_installed(){
  [ ! -x $BREW_PATH ]
}

git_is_not_installed(){
  ! type git > /dev/null
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

install_git_command_by_brew(){
  info "git is not installed by brew"
  info "start installing git command..."
  brew install git
  clear "git is installed by brew"
}

install_git_command_by_apt(){
  info "git is not installed by apt"
  info "start installing git command..."
  yes | sudo apt install git
  clear "git is installed by apt"
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

download_for_mac(){
  sub_title "Check Brew Command is installed"
  brew_is_not_installed && install_brew_command || clear "brew is already installed"
  sub_title "Check Git Command is installed"
  git_is_not_installed && install_git_command_by_brew || clear "git is already installed by brew"
  sub_title "Check Dotfiles exist"
  dotfiles_not_exist && clone_dotfiles || clear "dotfiles already exist"
}

download_for_ubuntu(){
  sub_title "Check Git Command is installed"
  git_is_not_installed && install_git_command_by_apt || clear "git is already installed"
  sub_title "Check Dotfiles exist"
  dotfiles_not_exist && clone_dotfiles || clear "dotfiles already exist"
}

############ main functions ################

download(){
  title "Download"
  sub_title "Check OS Type"
  if is_mac_os ; then
    clear "OS is Mac OS"
    download_for_mac
  elif is_ubuntu ; then
    clear "OS is Ubuntu OS"
    download_for_ubuntu
  else
    error "Sorry, this script is not suitable this OS."
  fi
}

deploy(){
  title "Deploy"

  sub_title "Update Dotfiles"
  pull_dotfiles

  sub_title "Linking Dotfiles"
  info "start making symbolic link..."
  for dotfile in `ls -A $DOTFILES_HOME/home/`;do
    ln -sfnv $DOTFILES_HOME/home/$dotfile $HOME/$dotfile
  done
  clear "finish making symbolic link of dotfiles"
}

initialize(){
  title "Initialize"
  info "start executing initialize scripts..."
  os=$(if is_mac_os; then echo 'mac'; elif is_ubuntu; then echo 'ubuntu'; else echo 'ubuntu'; fi)
  for scirpt in `ls -v $DOTFILES_HOME/scripts/init/${os}/*`;do
    source $scirpt
  done
  new_line
  clear "finish executing initialize scripts"
  new_line
}

############   main    ################

case "${1:-''}" in
  "update") deploy && initialize ;;
  "deploy") deploy ;;
  * ) download && deploy && initialize ;;
esac
