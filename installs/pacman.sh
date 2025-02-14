#!/usr/bin/bash


# echo -e "\nY - согласиться"
# echo "n - не согласиться"

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
    fd                 # Замена find
    git                # Система контроля версий
    less               # Просмотр текстовых файлов
    vim                # Мощный текстовый редактор
    nano               # Простой и удобный текстовый редактор
    tree               # Дерево файлов
    htop               # Улучшенный top
    fzf                # Интерфейс командной строки для поиска
    zoxide             # Улучшенная команда cd
    curl               # Инструмент для передачи данных с URL
    tokei              # Подсчет строк, файлов и директорий в проекте
    thefuck            # Утилита для исправления ошибок в командной строке
    lsd                # Альтернативная версия команды ls с цветным выводом
    bat                # Утилита для просмотра файлов с подсветкой синтаксиса
    dog                # Утилита для DNS-запросов
    iproute2           # Утилита для управления сетевыми интерфейсами и маршрутизацией
    ripgrep-all        # Быстрый инструмент для поиска текста
    ncdu               # Утилита для анализа использования дискового пространства
    ranger             # Текстовый файловый менеджер с интерфейсом в стиле Vim
    tmux               # Мультиплексор терминала, позволяющий разделять терминал на панели
    net-tools          # Для работы с сетями
    base-devel         # Базовые инструменты для сборки пакетов Linux
    pyenv              # Простое управление версиями Python
    openssl            # The Open Source toolkit for Secure Sockets Layer and Transport Layer Security
    zlib               # Библиотека реализующая метод сжатия deflate
    xz                 # Библиотека и инструменты командной строки для сжатых файлов XZ и LZMA
    tk                 # Набор инструментов для работы с окнами, используемый с tcl
    ifuse                  # Подключение файловой системы iPhone или iPod Touch
    yt-dlp                 # Скачать видео с YouTube
)

additional_pkgs=(
    chromium               # Браузер
    solanum                # Таймер
    calibre                # Управления электронной библиотекой
    evince                 # Просмотр документов
    gnome-calculator       # Калькулятор
    gnome-disk-utility     # Управление дисками
    keepassxc              # Управление базой данных паролей
    libreoffice-fresh-ru   # Офисный пакет на русском языке
    obsidian               # Управление базой знаний
    qbittorrent            # Торрент клиент
    spectacle              # Захват экрана
    visual-studio-code-bin  # редактор кода visual studio code !aur
    ttf-firacode-nerd  # шрифт fira code с дополнительными иконками
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
    exists=false
    for pkg in "${additional_pkgs[@]}"; do
        if ! pacman -Q "$pkg" &> /dev/null; then
            exists=true
        fi
    done

    if $exists; then
        echo -e "\n------------------------------------------"
        echo -e "Дополнительные пакеты:\n"
        for pkg in "${additional_pkgs[@]}"; do
            if ! pacman -Q "$pkg" &> /dev/null; then
                echo " - $pkg"
            fi
        done
        echo -e "\n------------------------------------------\n"
    fi

    all=false
    for pkg in "${additional_pkgs[@]}"; do

        if ! pacman -Q "$pkg" &> /dev/null; then
            if $all; then
                yay -S "$pkg" --noconfirm
                continue
            fi

            while true
            do
                echo "i - информация о пакете"
                echo -e "a - установить ВСЁ\n"
                read -p "Установить '$pkg'? [Y/n/i/a]: " answer
                if [[ $answer =~ ^(Y|y|yes)$ || -z $answer ]]; then
                    # echo "Установка дополнительного пакета ${pkg}"
                    yay -S "$pkg" --noconfirm
                    break
                elif [[ $answer =~ ^(i)$ ]]; then
                    yay -Si "$pkg"
                elif [[ $answer =~ ^(A|a)$ ]]; then
                    yay -S "$pkg" --noconfirm
                    all=true
                    break
                else
                    break
                fi
            done
        fi
    done

   # Установка расширений для vscode
    if pacman -Q code &> /dev/null; then
        # echo "Установка расширений vscode"
        vscode/install.sh
    fi
fi
