cat <<EOF > ${DOTPATH}/.tmux.conf
set-option -g default-shell $(which zsh)
set-option -g default-command $(which zsh)
set-option -s escape-time 0

# enable 256 colors
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# set prefix Ctrl-T
set-option -g prefix C-t
bind-key C-t send-prefix
unbind-key C-b

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -n C-s select-pane -t :.+
bind | split-window -h
bind - split-window -v
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

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

##################
# DESIGN CHANGES #
##################

# status bar
set-option -g status-left-length 90
set-option -g status-right-length 90
set-option -g status-right '[%Y-%m-%d(%a) %H:%M]'
set-option -g status-interval 1
set-option -g status-position top
set-option -g status-justify left
set-option -g status-left ' '
set-option -g status-left-length 10
set-option -g status-bg "colour238"
set-option -g status-fg "colour255"

# base16-gruvbox-dark-pale
# https://github.com/mattdavis90/base16-tmux/blob/master/colors/base16-gruvbox-dark-pale.conf

# default statusbar colors
set-option -g status-style "fg=#949494,bg=#3a3a3a"
# default window title colors
set-window-option -g window-status-style "fg=#949494,bg=default"
# active window title colors
set-window-option -g window-status-current-style "fg=#ffaf00,bg=default"
# pane border
set-option -g pane-border-style "fg=#3a3a3a"
set-option -g pane-active-border-style "fg=#4e4e4e"
# message text
set-option -g message-style "fg=#dab997,bg=#3a3a3a"
# pane number display
set-option -g display-panes-active-colour "#afaf00"
set-option -g display-panes-colour "#ffaf00"
# clock
set-window-option -g clock-mode-colour "#afaf00"
# copy mode highligh
set-window-option -g mode-style "fg=#949494,bg=#4e4e4e"
# bell
set-window-option -g window-status-bell-style "fg=#3a3a3a,bg=#d75f5f"
EOF
