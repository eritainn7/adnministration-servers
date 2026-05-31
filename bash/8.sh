#!/bin/bash
values=$(env | grep -E '^LC_' | cut -d'=' -f2- | sort -u)

unique_count=$(echo "$values" | grep -v '^$' | wc -l)

if [ $unique_count -le 1 ]; then
    echo "OK: Все LC_* переменные имеют одинаковое значение"
    exit 0
else
    echo "ОШИБКА: Найдены разные значения LC_* переменных:"
    env | grep -E '^LC_' | while IFS='=' read -r var val; do
        echo "  $var = $val"
    done
    exit 1
fi
