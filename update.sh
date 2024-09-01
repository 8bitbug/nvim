#!/bin/bash

if cd $(find $HOME -type d -name neovim); then
    git pull origin master
    make clean
    rm -rf build
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build
    cpack -G DEB
    sudo dpkg -i --force-overwrite nvim-linux64.deb
else
    echo "E: Could not find directory neovim"
fi
