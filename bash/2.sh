#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Ошибка: Необходимо указать путь в качестве аргумента"
    echo "Использование: $0 <путь_к_каталогу>"
    exit 1
fi

target_path="$1"

if [ ! -e "$target_path" ]; then
    echo "Ошибка: Путь '$target_path' не существует"
    exit 1
fi

if [ ! -d "$target_path" ]; then
    echo "Ошибка: '$target_path' не является каталогом"
    exit 1
fi

for dir in "$target_path"/*/; do
    if [ -d "$dir" ]; then
        dir_name=$(basename "$dir")
        
        element_count=$(find "$dir" -maxdepth 1 -mindepth 1 | wc -l)
        
        echo "$element_count" > "$dir_name"
        
        echo "Создан файл: $dir_name (содержит $element_count элементов)"
    fi
done

if [ -z "$(find "$target_path" -maxdepth 1 -type d -not -path "$target_path" -print -quit)" ]; then
    echo "Предупреждение: В каталоге '$target_path' нет подкаталогов"
fi
