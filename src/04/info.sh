#!/bin/bash

# Получение информации о хосте
HOSTNAME=$(hostname)

# Получение информации о временной зоне
TIMEZONE=$(timedatectl show --property=Timezone --value)
TIMEZONE_OFFSET=$(date +'%:::z')

# Получение информации о пользователе
USER=$(whoami)

# Получение информации об операционной системе
OS=$(lsb_release -ds)

# Получение информации о текущей дате и времени
DATE=$(date +'%d %b %Y %T')

# Получение информации о времени работы системы
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')

# Получение IP-адреса
IP=$(hostname -I | awk '{print $1}')

# Получение информации о сетевой маске
MASK=$(netstat -rn | awk 'NR==4{print $3}')

# Получение IP шлюза по умолчанию
GATEWAY=$(ip route | awk '/default/ {print $3}')

# Получение информации о памяти
RAM_TOTAL=$(free -b | awk '/Mem:/ {printf "%.3f GB", $2/(1024^3)}')
RAM_USED=$(free -b | awk '/Mem:/ {printf "%.3f GB", $3/(1024^3)}')
RAM_FREE=$(free -b | awk '/Mem:/ {printf "%.3f GB", $4/(1024^3)}')

# Получение информации о корневом разделе
SPACE_ROOT=$(df -BM / | awk '/\// {printf "%.2f MB", $2}')
SPACE_ROOT_USED=$(df -BM / | awk '/\// {printf "%.2f MB", $3}')
SPACE_ROOT_FREE=$(df -BM / | awk '/\// {printf "%.2f MB", $4}')

get_system_info() {
    echo "$(set_color "HOSTNAME" "$bg_names_color" "$font_names_color") = $(set_color "$HOSTNAME" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "TIMEZONE" "$bg_names_color" "$font_names_color") = $(set_color "$TIMEZONE UTC $TIMEZONE_OFFSET" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "USER" "$bg_names_color" "$font_names_color") = $(set_color "$USER" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "OS" "$bg_names_color" "$font_names_color") = $(set_color "$OS" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "DATE" "$bg_names_color" "$font_names_color") = $(set_color "$DATE" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "UPTIME" "$bg_names_color" "$font_names_color") = $(set_color "$UPTIME" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "UPTIME_SEC" "$bg_names_color" "$font_names_color") = $(set_color "$UPTIME_SEC seconds" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "IP" "$bg_names_color" "$font_names_color") = $(set_color "$IP" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "MASK" "$bg_names_color" "$font_names_color") = $(set_color "$MASK" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "GATEWAY" "$bg_names_color" "$font_names_color") = $(set_color "$GATEWAY" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "RAM_TOTAL" "$bg_names_color" "$font_names_color") = $(set_color "$RAM_TOTAL" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "RAM_USED" "$bg_names_color" "$font_names_color") = $(set_color "$RAM_USED" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "RAM_FREE" "$bg_names_color" "$font_names_color") = $(set_color "$RAM_FREE" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "SPACE_ROOT" "$bg_names_color" "$font_names_color") = $(set_color "$SPACE_ROOT" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "SPACE_ROOT_USED" "$bg_names_color" "$font_names_color") = $(set_color "$SPACE_ROOT_USED" "$bg_values_color" "$font_values_color")"
	echo "$(set_color "SPACE_ROOT_FREE" "$bg_names_color" "$font_names_color") = $(set_color "$SPACE_ROOT_FREE" "$bg_values_color" "$font_values_color")"
}