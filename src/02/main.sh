#!/bin/bash

sudo chmod +x ./info.sh
./info.sh

# Запрос на сохранение данных в файл
read -p "Write data to a file? (Y/N): " answer

if [[ $answer == "Y" || $answer == "y" ]]; then
	# Форматирование текущей даты и времени для имени файла
	FILENAME="$(date +"%d_%m_%y_%H_%M_%S").status"

	# Создание файла и запись информации
	./info.sh > "$FILENAME"

	echo "Data has been written to a file $FILENAME."
else
	echo "You refused to write data to the file."
fi
