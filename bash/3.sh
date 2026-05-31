#!/bin/bash
for file in "$@"; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        lines=$(wc -l < "$file")
        echo "$file: $lines"
    elif [ ! -e "$file" ]; then
        echo "Ошибка: Файл '$file' не существует" >&2
    else
        echo "Ошибка: '$file' не является файлом или нет прав на чтение" >&2
    fi
done