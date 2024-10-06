#!/bin/bash

log_info() {
    echo "INFO: $1"
}

log_warning() {
    echo "WARNING: $1"
}

log_error() {
    echo "ERROR: $1" >&2
}

if command -v nvim &> /dev/null; then
    log_info "Neovim is already installed."
    read -p "Do you want to update Neovim? [Y/n] " res

    if [[ "$res" =~ ^[Yy]$ ]]; then
        log_info "Updating Neovim..."
        SOURCE_DIR="$HOME/Source/src-neovim"

        if [ -d "$SOURCE_DIR" ]; then
            cd "$SOURCE_DIR" || exit
            log_info "Fetching the latest code..."
            git pull origin master

            log_info "Building the updated Neovim..."
            build

            install
        else
            log_error "Source directory for Neovim not found."
            exit 1
        fi
    else
        log_info "Skipping Neovim update."
        exit 0
    fi
else
    log_info "Neovim is not installed. Proceeding with installation."
fi

log_info "Updating and upgrading system packages..."
if ! sudo apt-get update; then
    log_error "Failed to update package list."
    exit 1
fi

if ! sudo apt-get upgrade -y; then
    log_error "Failed to upgrade packages."
    exit 1
fi

log_info "Installing required packages..."
if ! sudo apt-get install -y cmake ninja-build gettext unzip curl git file; then
    log_error "Failed to install required packages."
    exit 1
fi

build() {
    log_info "Building Neovim..."
    make CMAKE_BUILD_TYPE=RelWithDebInfo

    if [ $? -ne 0 ]; then
        log_error "Build failed."
        exit 1
    fi

    cd build || exit
    log_info "Creating .deb package..."
    cpack -G DEB
}

install() {
    log_info "Installing Neovim..."
    if sudo dpkg -i --force-overwrite nvim-linux64.deb; then
        log_info "Neovim has been installed/updated successfully."
        exit 0
    else
        log_error "Unable to install the .deb file."
        exit 1
    fi
}

SOURCE_DIR="$HOME/Source/src-neovim"

if [ ! -d "$SOURCE_DIR" ]; then
    log_info "Creating source directory..."
    mkdir -p "$HOME/Source"
fi

cd "$HOME/Source" || exit

if [ ! -d src-neovim ]; then
    log_info "Cloning Neovim repository..."
    if git clone https://github.com/neovim/neovim.git src-neovim; then
        cd src-neovim || exit
        build
        install
    else
        log_error "Unable to clone the repository."
        exit 1
    fi
else
    cd src-neovim || exit
    log_info "Neovim source directory found."
    
    log_info "Fetching the latest code..."
    git pull origin master

    log_info "Building Neovim..."
    build
    install
fi
