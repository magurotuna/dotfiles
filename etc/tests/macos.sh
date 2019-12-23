#!/usr/bin/env zsh

source $DOTPATH/etc/lib/utils.sh

CLI_APPS="git gsed zsh tmux vim nvim jq ghq fzf exa rg direnv tree starship"

for _APP in $CLI_APPS
do
    if ! has $_APP; then
        echo "$_APP is not installed!"
        exit 1
    fi
done

echo "CLI apps are successfully installed."

GUI_APPS="firefox chrome visual googlejapaneseinput docker alfred slack sourcetree spectacle karabiner-elements alacritty typora 1password chatwork skitch"

for _APP in $GUI_APPS
do
    if ! ls -1 /Applications | grep -qi $_APP; then
        echo "$_APP is not installed!"
        exit 1
    fi
done

echo "GUI apps are successfully installed."
echo "💚💚💚💚 macOS initialization test ALL GREEN!! 💚💚💚💚"
