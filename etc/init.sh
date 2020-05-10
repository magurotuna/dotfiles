#!/bin/bash

set -eu

# load utils
source ${DOTPATH}/etc/lib/utils.sh

function install_mac() {
    set +e

    # Install apps via Homebrew
    source ${DOTPATH}/etc/lib/mac/brew_install.sh

    # Make zsh default shell
    local LOGIN_SHELL=$(show_user_shell)
    if [ ${LOGIN_SHELL} != $(which zsh) ]; then
        if ! cat /etc/shells | grep $(which zsh); then
            echo $(which zsh) | sudo tee -a /etc/shells
        fi
        chsh -s $(which zsh)
    else
        echo "Your default shell is already zsh."
    fi

    # Install fonts
    # Ricty for Powerline
    source ${DOTPATH}/etc/lib/mac/ricty_for_powerline.sh
    # Menlo for Powerline
    source ${DOTPATH}/etc/lib/mac/menlo_for_powerline.sh
    # Noto Sans Mono Nerd Font
    source ${DOTPATH}/etc/lib/mac/noto_sans_mono_nerd.sh

    set -e
}

function install_linux() {
    if has "yum"; then
        sudo yum groupinstall -y 'Development Tools' && \
          sudo yum install -y curl file git ruby which
    elif has "apt"; then
        sudo apt update -y && \
          sudo apt install -y build-essential curl file git ruby
    fi

    # Install linuxbrew
    if ! has "brew"; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    fi
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    brew update
    brew install git \
                 zsh \
                 tmux \
                 vim \
                 neovim \
                 jq \
                 fzf \
                 exa \
                 bat \
                 ripgrep \
                 git-delta \
                 direnv \
                 tree \
                 starship
}

function install_lang() {
    set +e
    brew update
    brew install nodenv \
                 pyenv \
                 rbenv \
                 goenv \
                 yarn

    # Rust toolchain
    if ! has "rustup"; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
    set -e
}

function install_zplugin() {
    if [ ! -d $HOME/.zplugin ]; then
        mkdir $HOME/.zplugin
        git clone https://github.com/zdharma/zplugin.git $HOME/.zplugin/bin
    fi
}

function install_vimplug() {
    curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

if is_mac; then
    echo "This is macOS."
    source ${DOTPATH}/etc/lib/mac/system_preferences.sh
    install_mac
elif is_centos; then
    echo "This is Redhat Linux."
    install_linux
elif is_ubuntu; then
    echo "This is Ubuntu."
    install_linux
else
    # TODO: implementation for debian
    echo "This is unknown platform. Abort."
    exit 1
fi

install_lang
install_zplugin
install_vimplug

echo "================================================"
echo "Initialization successfully finished!"
echo "================================================"
