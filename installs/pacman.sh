#!/usr/bin/bash


read -p "Запустить установщик pacman? [Y/n]: " answer

if ! [[ $answer =~ ^(Y|y|yes)$ || -z $answer ]]; then
    exit 0
fi

# Обновляем систему
sudo pacman -Syu --noconfirm

# Устанавливаем yay, если он еще не установлен
if ! pacman -Q yay &> /dev/null; then
    sudo pacman -S --needed git base-devel
    mkdir -p ~/opt
    git clone https://aur.archlinux.org/yay.git ~/opt/yay
    cd ~/opt/yay || exit 1
    makepkg -si --noconfirm
    cd ~/opt || exit 1
fi

# Объявляем массивы с пакетами
minimal_pkgs=(
    fd             # Замена find
    git            # Система контроля версий
    less           # Просмотр текстовых файлов
    vim            # Мощный текстовый редактор
    nano           # Простой и удобный текстовый редактор
    tree           # Дерево файлов
    htop           # Улучшенный top
    fzf            # Интерфейс командной строки для поиска
    zoxide         # Улучшенная команда cd
    curl           # Инструмент для передачи данных с URL
    tokei          # Подсчет строк, файлов и директорий в проекте
    thefuck        # Утилита для исправления ошибок в командной строке
    lsd            # Альтернативная версия команды ls с цветным выводом
    bat            # Утилита для просмотра файлов с подсветкой синтаксиса
    dog            # Утилита для DNS-запросов
    iproute2       # Утилита для управления сетевыми интерфейсами и маршрутизацией
    ripgrep-all    # Быстрый инструмент для поиска текста
    ncdu           # Утилита для анализа использования дискового пространства
    ranger         # Текстовый файловый менеджер с интерфейсом в стиле Vim
    tmux           # Мультиплексор терминала, позволяющий разделять терминал на панели
    ttf-firacode-nerd  # шрифт fira code с дополнительными иконками
    net-tools      # Для работы с сетями
)

additional_pkgs=(
    ifuse                  # Подключение файловой системы iPhone или iPod Touch
    yt-dlp                 # Скачать видео с YouTube
    solanum                # Таймер
    calibre                # Управления электронной библиотекой
    gnome-calculator       # Калькулятор
    gnome-disk-utility     # Управление дисками
    keepassxc              # Управление базой данных паролей
    libreoffice-fresh-ru   # Офисный пакет на русском языке
    obsidian               # Управление базой знаний
    qbittorrent            # Торрент клиент
    spectacle              # Захват экрана
)

aur_pkgs=(
    visual-studio-code-bin  # редактор кода visual studio code
)

# Cначала ставим базовые пакеты
for pkg in "${minimal_pkgs[@]}"; do
    if ! pacman -Q "$pkg" &> /dev/null; then
        # echo "Установка базового пакета ${pkg}"
        sudo pacman -S "$pkg" --noconfirm
    fi
done

read -p "Установить дополнительные пакеты? [Y/n]: " answer

if [[ $answer =~ ^(Y|y|yes)$ || -z $answer ]]; then
    for pkg in "${additional_pkgs[@]}"; do
        if ! pacman -Q "$pkg" &> /dev/null; then
            # echo "Установка дополнительного пакета ${pkg}"
            sudo pacman -S "$pkg" --noconfirm
        fi
    done

   # Установка необходимых приложений через yay
    for pkg in "${aur_pkgs[@]}"; do
        if ! pacman -Q "$pkg" &> /dev/null; then
            # echo "Установка пакета ${pkg} через yay"
            yay -S --noconfirm "$pkg"
        fi
    done

   # Установка расширений для vscode
    if pacman -Q code &> /dev/null; then
        # echo "Установка расширений vscode"
        vscode/install.sh
    fi
fi
