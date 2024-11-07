#!/usr/bin/env bash

if [ -f ~/.local/share/konsole/my.profile ]; then
    sed -i "s/^DefaultProfile=.*/DefaultProfile=my.profile/" ~/.config/konsolerc
fi
