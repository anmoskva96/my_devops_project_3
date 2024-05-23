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
DATE=$(date +"%d %B %Y %T")

# Получение информации о времени работы системы
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')

# Получение IP-адреса
IP=$(hostname -I | awk '{print $1}')

# Получение информации о сетевой маске
# MASK=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
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

# Вывод информации на экран
echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE UTC $TIMEZONE_OFFSET"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC seconds"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"

