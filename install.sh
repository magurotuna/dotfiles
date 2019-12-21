#!/bin/sh

# You have to execute this script ONLY ONCE.
# This script does the following things:
# 1. Fetch this repo
# 2. Install basic dependencies

set -e

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

if has "yum" || has "apt"; then
    DEPS=$(cat ${DOTPATH}/basic_deps.txt | tr "\n" " ")
    printf "Enter password: "
    read PASSWORD

    if has "yum"; then
        echo "Install basic dependencies by using yum..."
        echo "${PASSWORD}" | sudo -S yum update -y && \
        echo "${PASSWORD}" | sudo -S yum install -y ${DEPS}
    elif has "apt"; then
        echo "Install basic dependencies by using apt..."
        echo "${PASSWORD}" | sudo -S apt update -y && \
        echo "${PASSWORD}" | sudo -S apt install -y ${DEPS}
    else
        echo "Neither yum nor apt is installed, so deps installation skips."
    fi
fi

echo "Installation successfully finished!"
