#!/bin/bash

# Функция для настройки цветового форматирования
set_color() {
  local text="$1"
  local bg_color="$2"
  local font_color="$3"
  echo -e "\e[${bg_color};${font_color}m${text}\e[0m"
}

# Чтение конфигурационного файла
read_config_file() {
  if [ -f "config.conf" ]; then
    source "config.conf"
  else
    echo "Error: config.conf file not found."
    exit 1
  fi
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

# Проверка валидности параметров
validation_check() {
  for param in "$@"; do
    if ! [[ "$param" =~ ^[1-6]$ ]]; then
      echo "Error: The parameters must be numbers from 1 to 6."
      exit 1
    fi
  done
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

process_variables() {
  if [[ -n "$column1_background" && -n "$column1_font_color" && -n "$column2_background" && -n "$column2_font_color" ]]; then

    check_parameters "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"
    validation_check "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"
    set_colors "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"

    # Вывод информации о системе
    source info.sh
    get_system_info

    local color_names=("white" "red" "green" "blue" "purple" "black")

    local column1_bg_name="${color_names[column1_background - 1]}"
    local column1_font_name="${color_names[column1_font_color - 1]}"
    local column2_bg_name="${color_names[column2_background - 1]}"
    local column2_font_name="${color_names[column2_font_color - 1]}"

    echo
    echo "Column 1 background = $column1_background ($column1_bg_name)"
    echo "Column 1 font color = $column1_font_color ($column1_font_name)"
    echo "Column 2 background = $column2_background ($column2_bg_name)"
    echo "Column 2 font color = $column2_font_color ($column2_font_name)"

  else
    local column1_background=1
    local column1_font_color=2
    local column2_background=1
    local column2_font_color=2

    check_parameters "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"
    validation_check "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"
    set_colors "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"

    # Вывод информации о системе
    source info.sh
    get_system_info

    local color_names=("white" "red" "green" "blue" "purple" "black")

    local column1_bg_name="${color_names[column1_background - 1]}"
    local column1_font_name="${color_names[column1_font_color - 1]}"
    local column2_bg_name="${color_names[column2_background - 1]}"
    local column2_font_name="${color_names[column2_font_color - 1]}"

    echo
    echo "Column 1 background = default ($column1_bg_name)"
    echo "Column 1 font color = default ($column1_font_name)"
    echo "Column 2 background = default ($column2_bg_name)"
    echo "Column 2 font color = default ($column2_font_name)"
  fi
}

# Чтение конфигурационного файла
read_config_file

process_variables
