# If not running interactively, don't do anything
case $- in
    *i*) exec zsh;;
      *) return;;
esac


# following code is backup

# # If not running interactively, don't do anything
# case $- in
#     *i*) exec fish;;
#       *) return;;
# esac



# # tabtab source for serverless package
# # uninstall by removing these lines or running `tabtab uninstall serverless`
# [ -f /Users/yusuke/.ghq/github.com/magurotuna/kikuchi-map-ftp/node_modules/tabtab/.completions/serverless.bash ] && . /Users/yusuke/.ghq/github.com/magurotuna/kikuchi-map-ftp/node_modules/tabtab/.completions/serverless.bash
# # tabtab source for sls package
# # uninstall by removing these lines or running `tabtab uninstall sls`
# [ -f /Users/yusuke/.ghq/github.com/magurotuna/kikuchi-map-ftp/node_modules/tabtab/.completions/sls.bash ] && . /Users/yusuke/.ghq/github.com/magurotuna/kikuchi-map-ftp/node_modules/tabtab/.completions/sls.bash
# # tabtab source for slss package
# # uninstall by removing these lines or running `tabtab uninstall slss`
# [ -f /Users/yusuke/.config/yarn/global/node_modules/tabtab/.completions/slss.bash ] && . /Users/yusuke/.config/yarn/global/node_modules/tabtab/.completions/slss.bash


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
