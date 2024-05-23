#!/bin/bash

# Функция для настройки цветового форматирования
set_color() {
    local text="$1"
    local bg_color="$2"
    local font_color="$3"
    echo -e "\e[${bg_color};${font_color}m${text}\e[0m"
}

# Проверка наличия дублирующихся значений
check_parameters() {
    local bg_names=$1
    local font_names=$2
    local bg_values=$3
    local font_values=$4

    if [[ $bg_names == $font_names || $bg_values == $font_values ]]; then
        echo "Error: The background color and font color of the same column should not match."
        exit 1
    fi
}

# Установка цветовых переменных на основе входных параметров
set_colors() {
    local bg_names=$1
    local font_names=$2
    local bg_values=$3
    local font_values=$4

    case $bg_names in
    1) bg_names_color="48;5;15" ;;  # White
    2) bg_names_color="48;5;196" ;; # Red
    3) bg_names_color="48;5;46" ;;  # Green
    4) bg_names_color="48;5;27" ;;  # Blue
    5) bg_names_color="48;5;99" ;;  # Purple
    6) bg_names_color="48;5;0" ;;   # Black
    esac

    case $font_names in
    1) font_names_color="38;5;15" ;;  # White
    2) font_names_color="38;5;196" ;; # Red
    3) font_names_color="38;5;46" ;;  # Green
    4) font_names_color="38;5;27" ;;  # Blue
    5) font_names_color="38;5;99" ;;  # Purple
    6) font_names_color="38;5;0" ;;   # Black
    esac

    case $bg_values in
    1) bg_values_color="48;5;15" ;;  # White
    2) bg_values_color="48;5;196" ;; # Red
    3) bg_values_color="48;5;46" ;;  # Green
    4) bg_values_color="48;5;27" ;;  # Blue
    5) bg_values_color="48;5;99" ;;  # Purple
    6) bg_values_color="48;5;0" ;;   # Black
    esac

    case $font_values in
    1) font_values_color="38;5;15" ;;  # White
    2) font_values_color="38;5;196" ;; # Red
    3) font_values_color="38;5;46" ;;  # Green
    4) font_values_color="38;5;27" ;;  # Blue
    5) font_values_color="38;5;99" ;;  # Purple
    6) font_values_color="38;5;0" ;;   # Black
    esac
}

# Проверка количества параметров
if [ $# -ne 4 ]; then
    echo "Error: It is necessary to pass 4 numeric parameters (from 1 to 6)."
    exit 1
fi

# Проверка валидности параметров
for param in "$@"; do
    if ! [[ "$param" =~ ^[1-6]$ ]]; then
        echo "Error: The parameters must be numbers from 1 to 6."
        exit 1
    fi
done

# Извлечение параметров
bg_names=$1
font_names=$2
bg_values=$3
font_values=$4

check_parameters "$bg_names" "$font_names" "$bg_values" "$font_values"

set_colors "$bg_names" "$font_names" "$bg_values" "$font_values"

source info.sh
print_info
