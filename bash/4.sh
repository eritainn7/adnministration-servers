#!/bin/bash
declare -A satellites=(
    ["Меркурий"]=0
    ["Венера"]=0
    ["Земля"]=1
    ["Марс"]=2
    ["Юпитер"]=95
    ["Сатурн"]=146
    ["Уран"]=27
    ["Нептун"]=14
)

get_satellites() {
    local planet="$1"
    
    if [[ -n "${satellites[$planet]}" ]]; then
        echo "Планета $planet имеет ${satellites[$planet]} спутников"
        return 0
    else
        echo "Ошибка: Планета '$planet' не существует в Солнечной системе" >&2
        return 1
    fi
}

if [ $# -ne 1 ]; then
    echo "Ошибка: Необходимо указать название планеты"
    echo "Использование: $0 <название_планеты>"
    echo "Доступные планеты: Меркурий, Венера, Земля, Марс, Юпитер, Сатурн, Уран, Нептун"
    exit 1
fi

planet_name="$1"

get_satellites "$planet_name"
