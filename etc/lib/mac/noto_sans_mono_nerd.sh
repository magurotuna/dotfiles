#!/bin/bash

set -e

function install_noto_sans_mono_nerd() {
    if ! ls -1 $HOME/Library/Fonts | grep "Noto Sans Mono Light Nerd Font Complete.ttf"; then
        echo "Install Noto Sans Mono (Nerd patched)."
        local TMP_DIR=noto_tmp_$(date +%s)
        local TMP_DIR_PATH="${HOME}/${TMP_DIR}"
        mkdir "${TMP_DIR_PATH}"
        for STYLE in "Bold" "SemiBold" "Medium" "Regular" "Light"; do
            curl -o "${TMP_DIR_PATH}/Noto Sans Mono ${STYLE} Nerd Font Complete.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/2.1.0/patched-fonts/Noto/Sans-Mono/complete/Noto%20Sans%20Mono%20${STYLE}%20Nerd%20Font%20Complete.ttf" -sL
        done
        cp -f ${TMP_DIR_PATH}/*.ttf "${HOME}/Library/Fonts/"
        fc-cache -vf
        rm -rf "${TMP_DIR_PATH}"
    else
        echo "Noto Sans Mono Nerd Font is already installed."
    fi
}

install_noto_sans_mono_nerd
