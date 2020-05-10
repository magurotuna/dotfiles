#!/bin/bash

set -e

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

set_mac_config
