#!/bin/sh

# You have to execute this script ONLY ONCE.
# This script does the following things:
# 1. Fetch this repo
# 2. Install basic dependencies

DOTPATH=${HOME}/dotfiles
REPO_URL=https://github.com/magurotuna/dotfiles.git
REPO_TARBALL=https://github.com/magurotuna/dotfiles/archive/master.tar.gz

# If DOTPATH already exists, remove this.
if [ -d ${DOTPATH} ]; then
    rm -rf ${DOTPATH}
fi

echo "Start fetching..."
if type "git" > /dev/null 2>&1; then
    git clone --recursive ${REPO_URL} ${DOTPATH}
elif type "curl" > /dev/null 2>&1; then
    curl -L ${REPO_TARBALL} | tar zxv
    mv -f dotfiles-master ${DOTPATH}
elif type "wget" > /dev/null 2>&1; then
    wget -O - ${REPO_TARBALL} | tar zxv
    mv -f dotfiles-master ${DOTPATH}
else
    echo "At least one of git, curl, wget is required."
    exit 1
fi
echo "fetch done."

DEPS=$(cat ${DOTPATH}/basic_deps.txt | tr '\n' '')
if type "yum" > /dev/null 2>&1; then
    echo "Install basic dependencies by using yum..."
    yum update && yum install -y ${DEPS}
elif type "apt" > /dev/null 2>&1; then
    echo "Install basic dependencies by using apt..."
    apt update && apt install -y ${DEPS}
else
    echo "Neither yum nor apt is installed, so deps installation skips."
fi

echo "Finish!"
