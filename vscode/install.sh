#!/usr/bin/env bash


# Установка расширений для vs code
read -p "Install extensions for vscode? (y/n): " answer

if [[ $answer =~ ^[Yy]$ || -z $answer ]]; then
    if command -v code &> /dev/null; then
        cat vscode/extensions.txt | xargs --max-args=1 code --install-extension
    fi
fi
