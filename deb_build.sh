#!/bin/bash

log_info() {                                  
    echo "INFO: $1"
}

log_warning() {
    echo "WARNING: $1"
}

log_error() {
    echo "ERROR: $1" >&2
    exit 1
}

build() {
    log_info "Building Neovim..."
    make CMAKE_BUILD_TYPE=RelWithDebInfo || log_error "Build failed."

    cd build || exit
    log_info "Creating .deb package..."
    cpack -G DEB || log_error "Failed to create .deb package."
}

install() {
    log_info "Installing Neovim..."
    sudo dpkg -i --force-overwrite nvim-linux64.deb || log_error "Unable to install the .deb file."
    log_info "Neovim has been installed/updated successfully."
    exit 0
}

set -e

if command -v nvim &> /dev/null; then
    log_info "Neovim is already installed."
    read -p "Do you want to update Neovim? [Y/n] " res

    if [[ "$res" =~ ^[Yy]$ ]]; then
        log_info "Updating Neovim..."
        SOURCE_DIR="/usr/src/neovim"

        if [ -d "$SOURCE_DIR" ]; then
            cd "$SOURCE_DIR" || exit
            log_info "Fetching the latest code..."
            git pull origin master || log_error "Failed to fetch latest code."

            log_info "Building the updated Neovim..."
            build

            install
        else
            log_error "Source directory for Neovim not found."
        fi
    else
        log_info "Skipping Neovim update."
        exit 0
    fi
else
    log_info "Neovim is not installed. Proceeding with installation."
fi

log_info "Updating and upgrading system packages..."
sudo apt-get update || log_error "Failed to update package list."
sudo apt-get upgrade -y || log_error "Failed to upgrade packages."

log_info "Installing required packages..."
sudo apt-get install -y cmake ninja-build gettext unzip curl git file || log_error "Failed to install required packages."

SOURCE_DIR="/usr/src/neovim"

if [ ! -d "$SOURCE_DIR" ]; then
    log_info "Creating source directory..."
    mkdir -p "$HOME/Source"

    log_info "Cloning Neovim repository..."
    git clone https://github.com/neovim/neovim.git "$SOURCE_DIR" || log_error "Unable to clone the repository."
fi

cd "$SOURCE_DIR" || exit
log_info "Fetching the latest code..."
git pull origin master || log_error "Failed to fetch latest code."

log_info "Building Neovim..."
build

log_info "Installing Neovim..."
install
