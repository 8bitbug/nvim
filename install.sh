#!/bin/bash

if [ -d /usr/bin/nvim ] || [ -d /bin/nvim ]; then
  echo "I: Seems like you already have neovim installed."
  read -p "Q: Want to uninstall neovim via apt? [Y/n] " res

  if [[ "$res" = "Y" || "$res" = "y" ]]; then
    sudo apt-get remove neovim -y
  fi
fi

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y cmake ninja-build gettext unzip curl git file

if git clone https://github.com/neovim/neovim.git; then
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build
    cpack -G DEB
    sudo dpkg -i --force-overwrite nvim-linux64.deb
    echo "I: Installed neovim"
else
    echo "E: Unable to clone repo"
fi
