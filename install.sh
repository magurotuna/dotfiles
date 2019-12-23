#!/bin/sh

# You have to execute this script ONLY ONCE.
# This script does the following things:
# 1. Fetch this repo
# 2. Install basic dependencies

set -eu

DOTPATH=${HOME}/dotfiles
REPO_URL=https://github.com/magurotuna/dotfiles.git
REPO_TARBALL=https://github.com/magurotuna/dotfiles/archive/master.tar.gz

function has() {
    type "${1:?too few arguments}" &>/dev/null
}

# If DOTPATH already exists, remove this.
if [ -d ${DOTPATH} ]; then
    cd ${HOME}
    rm -rf ${DOTPATH}
fi

echo "Start fetching..."
if has "git"; then
    git clone --recursive ${REPO_URL} ${DOTPATH}
elif has "curl"; then
    curl -L ${REPO_TARBALL} | tar zxv
    mv -f dotfiles-master ${DOTPATH}
elif has "wget"; then
    wget -O - ${REPO_TARBALL} | tar zxv
    mv -f dotfiles-master ${DOTPATH}
else
    echo "At least one of git, curl, wget is required."
    exit 1
fi
echo "fetch done."

if [[ $OSTYPE == "linux*" ]]; then
    if has "yum" || has "apt"; then
        DEPS=$(cat ${DOTPATH}/basic_deps.txt | tr "\n" " ")
    
        if has "yum"; then
            if ! has "sudo"; then
                yum update -y && yum install -y sudo
            fi
            echo "Install basic dependencies by using yum..."
            sudo yum update -y && sudo yum install -y ${DEPS}
        elif has "apt"; then
            if ! has "sudo"; then
                apt update -y && apt install -y sudo
            fi
            echo "Install basic dependencies by using apt..."
            sudo apt update -y && sudo apt install -y ${DEPS}
        else
            echo "Neither yum nor apt is installed, so deps installation skips."
        fi
    fi
fi

echo "Installation successfully finished!"
echo "Next step:"
echo "$ cd ~/dotfiles"
echo "$ make deploy"
echo "$ make init"
