#!/bin/bash

VSCODE_FILE_DIR="$DOTFILES_HOME/etc/vscode/"
VSCODE_HOME="$HOME/Library/Application Support/Code/User"

sub_title "Linking vscode setting files"
info "start making symbolic link..."
for setting in `ls -A $VSCODE_FILE_DIR`;do
  ln -sfnv "$VSCODE_FILE_DIR/$setting" "$VSCODE_HOME/$setting"
done
clear "finish making symbolic link of vscode settings"
