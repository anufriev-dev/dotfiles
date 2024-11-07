#!/usr/bin/env bash

if [[ -f ~/.local/share/konsole/my.profile && -f ~/.config/konsolerc  ]]; then
    sed -i "s/^DefaultProfile=.*/DefaultProfile=my.profile/" ~/.config/konsolerc
fi
