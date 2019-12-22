cat <<EOF > ${DOTPATH}/.tmux.conf
set-option -g default-shell $(which zsh)
set-option -g default-command $(which zsh)
set-option -s escape-time 0

# enable 256 colors
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# status bar
set-option -g status-left-length 90
set-option -g status-right-length 90
set-option -g status-left '#H:[#P]'
set-option -g status-right '#(wifi) #(battery --tmux) [%Y-%m-%d(%a) %H:%M]'
set-option -g status-interval 1
set-option -g status-position top
set-option -g status-justify centre
set-option -g status-bg "colour238"
set-option -g status-fg "colour255"

# set prefix Ctrl-T
set-option -g prefix C-t
bind-key C-t send-prefix
unbind-key C-b

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
