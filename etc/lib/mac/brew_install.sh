#!/bin/bash

source ../utils.sh

function brew_install() {
    # XCode
    xcode-select --install
    # Install homebrew
    if ! has "brew"; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew update
    brew install git \
                 gnu-sed \
                 zsh \
                 tmux \
                 vim \
                 neovim \
                 jq \
                 ghq \
                 fzf \
                 exa \
                 bat \
                 ripgrep \
                 git-delta \
                 tokei \
                 direnv \
                 tree \
                 starship

    # Install GUI apps via brew cask
    brew install --cask firefox \
                      google-chrome \
                      visual-studio-code \
                      google-japanese-ime \
                      docker \
                      alfred \
                      slack \
                      sourcetree \
                      spectacle \
                      karabiner-elements \
                      alacritty \
                      typora \
                      1password \
                      chatwork \
                      skitch \
                      fontforge
}

brew_install
