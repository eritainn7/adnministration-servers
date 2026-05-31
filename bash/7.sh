#!/bin/bash
echo "Анализ каталогов в PATH:"
echo "========================"

IFS=':' read -ra DIRS <<< "$PATH"

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ] && [ -r "$dir" ]; then
        count=$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)
        printf "%-40s %8d файлов\n" "$dir" "$count"
    elif [ ! -d "$dir" ]; then
        printf "%-40s %8s\n" "$dir" "(не существует)"
    else
        printf "%-40s %8s\n" "$dir" "(нет прав)"
    fi
done
