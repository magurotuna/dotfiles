#!/usr/bin/env zsh

source $DOTPATH/etc/lib/utils.sh

if is_mac; then
  # macOS test
  echo "💚 This is macOS."
  echo "💚 Start to check CLI & GUI apps have been installed for sure."
  CLI_APPS="git gsed zsh tmux vim nvim jq ghq fzf exa rg direnv tree starship"

  for _APP in $CLI_APPS
  do
      if ! has $_APP; then
          echo "$_APP is not installed!"
          exit 1
      fi
  done

  echo "💚 CLI apps are successfully installed."

  GUI_APPS="firefox chrome visual googlejapaneseinput docker alfred slack sourcetree spectacle karabiner-elements alacritty typora 1password chatwork skitch"

  for _APP in $GUI_APPS
  do
      if ! ls -1 /Applications | grep -qi $_APP; then
          echo "$_APP is not installed!"
          exit 1
      fi
  done

  echo "💚 GUI apps are successfully installed."
  echo "💚💚💚💚 macOS initialization test ALL GREEN!! 💚💚💚💚"

elif is_ubuntu; then
  # Ubuntu test
  echo "💚 This is Ubuntu."
  echo "💚 Start to check CLI apps have been installed for sure."
  CLI_APPS="git zsh tmux vim nvim jq fzf bat exa rg direnv tree starship"

  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  for _APP in $CLI_APPS
  do
      if ! has $_APP; then
          echo "$_APP is not installed!"
          exit 1
      fi
  done
  echo "💚 CLI apps are successfully installed."
  echo "💚💚💚💚 Ubuntu initialization test ALL GREEN!! 💚💚💚💚"

else
  echo "This OS is not supported..."
  exit 1
fi

