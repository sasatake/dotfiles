#!/bin/bash

############ vars ################

ESC="\e["
ESCEND="m"

TEXT_GREEN="32"
TEXT_BOLD="1"

INFO_PREFIX="${ESC}${TEXT_GREEN}${ESCEND}"
INFO_TEXT="${ESC}${TEXT_BOLD}${ESCEND}"
COLOR_OFF="${ESC}${ESCEND}"

DOTFILES_HOME="${HOME}/.dotfiles"
BREW_INSTALLED_PATH="/usr/local/bin"
GIT_PATH="${BREW_INSTALLED_PATH}/git"
ZSH_PATH="${BREW_INSTALLED_PATH}/zsh"

############ functions ################

info(){
    printf "${INFO_PREFIX}info:${COLOR_OFF} ${INFO_TEXT}${1}${COLOR_OFF}\n\n"
}

get_os(){
    uname
}

is_mac_os(){
    [ "$(uname)" == 'Darwin' ]
}

is_not_installed_brew(){
    [ ! -x `command -v brew` ]
}

is_not_installed_git(){
    [ ! -x $GIT_PATH ]
}

is_cloned_dotfiles(){
    [ -d $DOTFILES_HOME ]
}

login_shell_is_brew_zsh(){
    [ -L $ZSH_PATH ] && [ $SHELL != $ZSH_PATH ]
}

install_brew_command(){
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

set_zsh_to_login_shell(){
    echo $ZSH_PATH | sudo -k tee -a /etc/shells > /dev/null
    chsh -s $ZSH_PATH
}

############   main    ################

info `get_os`
is_mac_os || exit

is_not_installed_brew && info "brew is not installed" || info "brew is installed"
is_not_installed_brew && info "start installing brew command" && install_brew_command

is_not_installed_git && info "git is not installed by brew" || info "git is installed by brew"
is_not_installed_git && info "start installing git command" && brew install git

is_cloned_dotfiles && \
git -C $DOTFILES_HOME pull || \
git clone https://github.com/sasatake/dotfiles.git $DOTFILES_HOME

login_shell_is_brew_zsh && \
info "zsh to login shell.please input sudo password." && set_zsh_to_login_shell

ln -s $DOTFILES_HOME/home/.zshenv $HOME/.zshenv