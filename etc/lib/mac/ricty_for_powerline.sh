#!/bin/bash

function install_ricty_for_powerline() {
    if ! ls -1 $HOME/Library/Fonts | grep "Ricty Regular for Powerline.ttf"; then
        echo "Install Ricty for Powerline."
        brew tap sanemat/font
        brew install ricty --with-powerline
        cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf $HOME/Library/Fonts/
        fc-cache -vf
    else
        echo "Ricty for Powerline is already installed."
    fi
}

install_ricty_for_powerline
