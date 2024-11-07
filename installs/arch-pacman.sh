#!/usr/bin/bash


# Установка расширений для vs code
read -p "Install all applications for arch-pacman? (y/n): " answer

if ! [[ $answer =~ ^[Yy]$ || -z $answer ]]; then
    exit 0
fi


# Обновляем систему
sudo pacman -Syu --noconfirm


declare -A packages=(
    ["git"]="git"            # Система контроля версий

    ["vim"]="vim"            # Мощный текстовый редактор
    ["nano"]="nano"          # Простой и удобный текстовый редактор

    ["fzf"]="fzf"            # Интерфейс командной строки для поиска
    ["zoxide"]="zoxide"      # Улучшенная команда cd
    ["curl"]="curl"          # Инструмент для передачи данных с URL
    ["tokei"]="tokei"        # Подсчет строк, файлов и директорий в проекте
    ["thefuck"]="fuck"       # Утилита для исправления ошибок в командной строке
    ["lsd"]="lsd"            # Альтернативная версия команды ls с цветным выводом
    ["bat"]="bat"            # Утилита для просмотра файлов с подсветкой синтаксиса
    ["dog"]="dog"            # Утилита для DNS-запросов
    ["iproute2"]="ip"        # Утилита для управления сетевыми интерфейсами и маршрутизацией
    ["ripgrep"]="rg"         # Быстрый инструмент для поиска текста
    ["ncdu"]="ncdu"          # Утилита для анализа использования дискового пространства
    ["ranger"]="ranger"      # Текстовый файловый менеджер с интерфейсом в стиле Vim
    ["tmux"]="tmux"          # Мультиплексор терминала, позволяющий разделять терминал на панели

    ["ttf-firacode-nerd"]="ttf-firacode-nerd" # шрифт fira code с дополнительными иконками
)

# Cначала ставим пакеты из основного репозитория
for app_key in ${!packages[@]}; do
    if ! command -v "${packages[$app_key]}" &> /dev/null; then
        sudo pacman -S "${app_key}" --noconfirm
    fi
done

# Устанавливаем yay, если он еще не установлен
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed git base-devel
    mkdir -p ~/opt
    git clone https://aur.archlinux.org/yay.git ~/opt/yay
    cd ~/opt/yay
    makepkg -si --noconfirm
    cd ~/opt
fi

declare -A aur_pkg=(
    ["visual-studio-code-bin"]="code" # редактор кода visual studio code
)

# Установка необходимых приложений через yay
for app in "${!aur_pkg[@]}"; do
    if ! command -v "${aur_pkg[$app]}" &> /dev/null; then
        yay -S --noconfirm "${app}"
    fi
done
