function has() {
    type "${1:?too few arguments}" &>/dev/null
}

function show_user_shell() {
    if is_mac; then 
        echo $(dscl localhost -read Local/Default/Users/${USER} UserShell | cut -d" " -f2)
    else
        echo $(grep ${USER} /etc/passwd | cut -d: -f7)
    fi
}

function is_mac() {
    [ $(uname) = "Darwin" ]
}

function is_centos() {
    [ -e /etc/redhat-release ]
}

function is_ubuntu() {
    [ -e /etc/lsb-release ]
}

function is_screen_running() {
    [ -n "$STY" ]
}

function is_tmux_running() {
    [ -n "$TMUX" ]
}

function is_screen_or_tmux_running() {
    is_screen_running || is_tmux_running
}

function shell_has_started_interactively() {
    [ -n "$PS1" ]
}

function is_ssh_running() {
    [ -n "$SSH_CONECTION" ]
}
