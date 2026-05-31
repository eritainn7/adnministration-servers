#!/bin/bash
if [ "$FOO" = "5" ] && [ "$BAR" = "1" ]; then
    echo "Запрещено: FOO=5 и BAR=1" >&2
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Использование: $0 <имя_файла>"
    exit 1
fi

while [ ! -e "$1" ]; do
    sleep 1
done

echo "Файл $1 появился в $(pwd)"
