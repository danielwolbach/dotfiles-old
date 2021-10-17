#!/usr/bin/env bash

set -e

function apply_configuration_files {
    CONFIG="dotbot.yml"
    DOTBOT_DIR="dotbot"

    DOTBOT_BIN="bin/dotbot"
    BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Get the latest version of Dotbot
    cd "${BASEDIR}"
    git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
    git submodule update --init --recursive "${DOTBOT_DIR}"

    "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
}

function install_packages {
    if [ -x "$(command -v dnf)" ];
    then
        sudo -i -u root bash << EOF
            dnf remove -y gnome-boxes cheese gnome-tour gnome-maps gnome-contacts gnome-weather gnome-font-viewer\
            gnome-characters rhythmbox gedit gnome-clocks *libreoffice* gnome-photos totem eog evince baobab\
            gnome-system-monitor gnome-calculator gnome-disk-utility simple-scan gnome-screenshot yelp gnome-abrt\
            gnome-logs gnome-calendar firefox gnome-software

            dnf update -y

            # Enable RPM Fusion repositories
            dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm\
            https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

            dnf install -y doas bat exa ripgrep fd-find neovim tldr clang gcc meson openssl-devel ffmpeg

            # Install JetBrains Mono Nerd Font
            bash -c "$(curl -sLo- https://git.io/JGksp)"
EOF
    elif [ -x "$(command -v pacman)" ]
    then
        sudo -i -u root bash << EOF
            pacman -Syuu --noconfirm
            pacman -S --noconfirm --needed git base-devel
EOF

        # Install Paru (AUR helper)
        if [ ! -x "$(command -v paru)" ]
        then
            git clone https://aur.archlinux.org/paru.git paru
            cd paru
            makepkg -si
            cd ..
            rm -r paru
        fi

        paru -S --noconfirm --needed doas bat exa ripgrep fd neovim tldr clang gcc meson nerd-fonts-jetbrains-mono
    fi

    # Install Rust toolchain
    if [ ! -d "$HOME/.cargo" ]
    then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
}

apply_configuration_files

read -p "Do you want to install missing packages and remove unncesessary ones? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    install_packages
fi
