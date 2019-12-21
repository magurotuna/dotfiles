cat <<EOF > ${DOTPATH}/.tmux.conf
set-option -g default-shell $(which zsh)
set-option -g default-command $(which zsh)
set-option -s escape-time 0
EOF
