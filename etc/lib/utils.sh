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
