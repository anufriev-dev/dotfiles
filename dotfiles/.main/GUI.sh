#!/usr/bin/bash

declare -A packages=(
    ["plasma-systemmonitor"]="plasma-systemmonitor"
)

for app_key in ${!packages[@]}; do
    if ! command -v "${packages[$app_key]}" &> /dev/null; then
        sudo pacman -S "${app_key}" --noconfirm
    fi
done
