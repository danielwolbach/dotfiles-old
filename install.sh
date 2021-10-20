#!/usr/bin/env bash

set -e
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

read -p "Do you want to install the configuration files? [y/N] " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]
then        
    DOTBOT_CONFIG="dotbot.yml"
    DOTBOT_DIR="dotbot"
    DOTBOT_BIN="bin/dotbot"

    cd "${BASEDIR}"
    git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
    git submodule update --init --recursive "${DOTBOT_DIR}"

    "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${DOTBOT_CONFIG}" "${@}"
fi

read -p "Do you want to install missing packages? [y/N] " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ -x "$(command -v paru)" ]]
    then
        paru -S --needed --noconfirm $(cat $BASEDIR/packages/paru)
    elif [[ -x "$(command -v apt)" ]]
    then
        sudo apt install -y $(cat $BASEDIR/packages/apt)
    else
        echo "No supported package manageer found."
    fi
fi
