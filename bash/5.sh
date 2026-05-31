#!/bin/bash
SOURCE_DIR="/var/log"
OUTPUT_FILE="logs.log"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Ошибка: Каталог $SOURCE_DIR не существует"
    exit 1
fi

if [ ! -r "$SOURCE_DIR" ]; then
    echo "Ошибка: Нет прав на чтение каталога $SOURCE_DIR"
    exit 1
fi

> "$OUTPUT_FILE"

echo "Последние строки .log файлов из $SOURCE_DIR" >> "$OUTPUT_FILE"
echo "Дата: $(date)" >> "$OUTPUT_FILE"
echo "----------------------------------------" >> "$OUTPUT_FILE"

for log_file in "$SOURCE_DIR"/*.log; do
    if [ -f "$log_file" ]; then
        filename=$(basename "$log_file")
        last_line=$(tail -n 1 "$log_file" 2>/dev/null)
        
        echo "Файл: $filename" >> "$OUTPUT_FILE"
        echo "Последняя строка: $last_line" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        
        echo "Обработан: $filename"
    fi
done

echo "Готово! Результат в файле $OUTPUT_FILE"
