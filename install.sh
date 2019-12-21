#!/bin/sh

# You have to execute this script ONLY ONCE.
# This script does the following things:
# 1. Fetch this repo
# 2. Install basic dependencies

DOTPATH=$(HOME)/dotfiles
REPO_URL=https://github.com/magurotuna/dotfiles.git
REPO_TARBALL=https://github.com/magurotuna/dotfiles/archive/master.tar.gz

echo "Start fetching..."
if has "git"; then
    git clone --recursive $(REPO_URL) $(DOTPATH)
elif has "curl"; then
    curl -L $(REPO_TARBALL) | tar zxv
    mv -f dotfiles-master $(DOTPATH)
elif has "wget"; then
    wget -O - $(REPO_TARBALL) | tar zxv
    mv -f dotfiles-master $(DOTPATH)
else
    die "At least one of git, curl, wget is required."
fi
echo "fetch done."

DEPS=`cat $(DOTPATH)/basic_deps.txt | tr '\n' ''`
if has "yum"; then
    echo "Install basic dependencies by using yum..."
    yum update && yum install -y $(DEPS)
elif has "apt"; then
    echo "Install basic dependencies by using apt..."
    apt update && apt install -y $(DEPS)
else
    echo "Neither yum nor apt is installed, so deps installation skips."
fi

echo "Finish!"
