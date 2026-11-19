#!/usr/bin/env bash


# Установка расширений для vs code
read -p "Установить расширения для vscode? [Y/n]: " answer

if [[ $answer =~ ^(Y|y|yes)$ || -z $answer ]]; then
    if command -v code &> /dev/null; then
        cat vscode/extensions.txt | xargs --max-args=1 code  --install-extension
    fi
fi



# Установка расширений для vscodium
read -p "Установить расширения для vscodium? [Y/n]: " answer

if [[ $answer =~ ^(Y|y|yes)$ || -z $answer ]]; then
    if command -v vscodium &> /dev/null; then
        cat vscode/extensions.txt | xargs --max-args=1 vscodium  --install-extension
    fi
fi