#!/bin/bash

function install_menlo_for_powerline() {
    if ! ls -1 $HOME/Library/Fonts | grep "Menlo for Powerline.ttf"; then
        echo "Install Menlo for Powerline."
        local TMP_DIR=menlo_tmp_$(date +%s)
        git clone https://github.com/abertsch/Menlo-for-Powerline.git ${HOME}/${TMP_DIR}
        cp -f ${HOME}/${TMP_DIR}/Menlo*.ttf ${HOME}/Library/Fonts/
        fc-cache -vf
        rm -rf ${HOME}/${TMP_DIR}
    else
        echo "Menlo for Powerline is already installed."
    fi
}

install_menlo_for_powerline
