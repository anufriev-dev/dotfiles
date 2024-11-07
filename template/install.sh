#!/usr/bin/env bash

if [ ! -f ~/.config/git/config_local ]; then
    cp template/git_config_local.template git/config_local
fi
