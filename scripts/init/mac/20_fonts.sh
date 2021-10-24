#!/bin/bash

sub_title "Set Ricty Fonts"

cp -f /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ${HOME}/Library/Fonts/ && fc-cache -vf