# xxxenv
eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(goenv init -)"

# Rust
source $HOME/.cargo/env

# Starship
eval "$(starship init zsh)"

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

# Emacs mode (to use Ctrl-F, B, N, P, etc...)
bindkey -e

# zplugin
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice wait'!0'; zplugin load zsh-users/zsh-autosuggestions
zplugin ice wait'!0'; zplugin load zsh-users/zsh-completions
zplugin ice wait'!0'; zplugin load zdharma/fast-syntax-highlighting

autoload -U compinit
compinit

# history fuzzy find
function select_history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}
zle -N select_history
bindkey "^r" select_history

# repository fuzzy find
function select_ghq() {
    local target_dir=$(ghq list -p | fzf --query="$LBUFFER")

    if [ -n "$target_dir" ]; then
    BUFFER="cd ${target_dir}"
    zle accept-line
    fi

    zle reset-prompt
}
zle -N select_ghq
bindkey "^g" select_ghq
