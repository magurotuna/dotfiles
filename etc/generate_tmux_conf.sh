cat <<EOF > ${DOTPATH}/.tmux.conf
set-option -g default-shell $(which zsh)
set-option -g default-command $(which zsh)
set-option -s escape-time 0

# enable 256 colors
set-option -g default-terminal screen-256color
set -g terminal-overrides 'xterm:colors=256'

# set prefix Ctrl-T
set-option -g prefix C-t
bind-key C-t send-prefix
unbind-key C-b

set-option -g status-position top
set-option -g status-interval 1

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -n C-o select-pane -t :.+
bind | split-window -h
bind - split-window -v

set-option -g pane-base-index 1
set-option -g base-index 1

# enable mouse
set-option -g mouse on

# reload config file
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# vi mode
set-window-option -g mode-keys vi
setw -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection

# connect to clipboard (macOS)
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
EOF
