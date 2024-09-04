#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install -y cmake ninja-build gettext unzip curl git file

if git clone https://github.com/neovim/neovim.git; then
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    ls
    cd build
    cpack -G DEB
    sudo dpkg -i --force-overwrite nvim-linux64.deb
    echo "I: Installed neovim"
else
    echo "E: Unable to clone repo"
fi
