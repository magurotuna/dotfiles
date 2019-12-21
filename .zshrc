# xxxenv
eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(goenv init -)"

# Rust
source $HOME/.cargo/env

# direnv
eval "$(direnv hook zsh)"

# aliases
alias ls='ls -G'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias dc='docker-compose'
alias g='git'
alias gs='git status'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gp='git push origin HEAD'
alias sed='gsed'

# zplugin
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

autoload -U compinit
compinit
