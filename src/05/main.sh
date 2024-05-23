#!/bin/bash

# Проверка, выполняется ли скрипт с одним параметром
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Путь к каталогу из параметра
directory="$1"

# Проверка на существование каталога
if [ ! -d "$directory" ]; then
    echo "Invalid directory: $directory"
    exit 1
fi

# Запуск таймера
start_time=$(date +%s.%5N)

# Общее число папок, включая вложенные
folder_count=$(find "$directory" -type d | wc -l)

# Топ 5 папок с самым большим весом в порядке убывания (путь и размер)
top_folders=$(du -sh "$directory"*/ 2>/dev/null | sort -hr | head -n 5 | awk -F'\t' 'BEGIN {OFS=" - "} {print NR, $2 ", " $1} END { if (NR < 5) print "etc up to 5" }')

# Общее число файлов
file_count=$(find "$directory" -type f | wc -l)

# Число конфигурационных файлов (с расширением .conf), текстовых файлов, исполняемых файлов, логов (файлов с расширением .log), архивов, символических ссылок
conf_count=$(find "$directory" -type f -name "*.conf" | wc -l)
text_count=$(find "$directory" -type f -name "*.txt" | wc -l)
exe_count=$(find "$directory" -type f -executable | wc -l)
log_count=$(find "$directory" -type f -name "*.log" | wc -l)
archive_count=$(find "$directory" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" \) | wc -l)
symlink_count=$(find "$directory" -type l | wc -l)

# Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип)
top_files=$(find "$directory" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | awk -F '\t' '{split($2, parts, "."); printf "%d - %s, %s, %s\n", NR, $2, $1, parts[length(parts)]} END { if (NR < 10) print "etc up to 10" }')

# Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш)
#top_executables=$(find "$directory" -type f -executable -exec du -ah {} + 2>/dev/null | sort -rh | head -n 10)
top_executables=$(find "$directory" -type f -executable -exec du -sh {} + | sort -rh | head -n 10 | awk '{ "md5sum \"" $2 "\" | cut -d\" \" -f1" | getline hash; print NR " - " $2 ", " $1 ", " hash } END { if (NR < 10) print "etc up to 10" }')

# Время выполнения скрипта
end_time=$(date +%s.%5N)
execution_time=$(echo "$end_time - $start_time" | bc)

# Вывод информации
echo "Total number of folders (including all nested ones) = $folder_count"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_folders"
echo "Total number of files = $file_count"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_count"
echo "Text files = $text_count"
echo "Executable files = $exe_count"
echo "Log files (with the extension .log) = $log_count"
echo "Archive files = $archive_count"
echo "Symbolic links = $symlink_count"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top_files"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$top_executables"
echo "Script execution time (in seconds) = $execution_time"
