#!/usr/bin/bash

if [ -f "/etc/arch-release" ]; then
    installs/pacman.sh
fi
