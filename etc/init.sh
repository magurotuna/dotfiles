#!/bin/bash

set -eu

# load lib files
source ${DOTPATH}/etc/lib/utils.sh

function set_mac_config() {
    # Common
    defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write NSGlobalDomain AppleAquaColorVariant -int 6
    defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.733333 0.721569";
    defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

    # Finder
    defaults write com.apple.finder AppleShowAllFiles true
    defaults write com.apple.finder FXPreferredViewStyle Nlsv
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    chflags nohidden ~/Library
    killall Finder

    # Enable safari devtool
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

    # Screenshots
    defaults write com.apple.screencapture disable-shadow -bool true # Disable screenshot shadow
    defaults write com.apple.screencapture type -string "png" # Set screenshot type to PNG
    defaults write com.apple.screencapture location ~/Pictures/
    killall SystemUIServer
}

function install_mac() {
    set +e
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
                 ripgrep \
                 direnv \
                 tree \
                 starship
    
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

    # Install GUI apps via brew cask
    brew cask install firefox \
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
                      skitch

    # Install fonts (Ricty for Powerline & Menlo for Powerline)
    if ! ls -1 $HOME/Library/Fonts | grep "Ricty Regular for Powerline.ttf"; then
        echo "Install Ricty for Powerline."
        brew tap sanemat/font
        brew install ricty --with-powerline
        cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf $HOME/Library/Fonts/
        fc-cache -vf
    fi
    
    if ! ls -1 $HOME/Library/Fonts | grep "Menlo for Powerline.ttf"; then
        echo "Install Menlo for Powerline."
        local TMP_DIR=menlo_tmp_$(date +%s)
        git clone https://github.com/abertsch/Menlo-for-Powerline.git ${HOME}/${TMP_DIR}
        cp -f ${HOME}/${TMP_DIR}/Menlo*.ttf ${HOME}/Library/Fonts/
        fc-cache -vf
        rm -rf ${HOME}/${TMP_DIR}
    fi

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
    eval $($HOME/.linuxbrew/bin/brew shellenv)
    brew update
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

if is_mac; then
    echo "This is macOS."
    set_mac_config
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

echo "Initialization successfully finished!"
