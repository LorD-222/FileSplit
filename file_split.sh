#!/bin/bash

# Вывод справки
usage() {
    echo "Использование: $0 [split/join] [имя файла или маска] [размер для split]"
    exit 1
}

# Проверка аргументов и вывод справки
if [ "$#" -lt 2 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    usage
fi

operation=$1
file_mask=$2
size=${3:-25M}

# Функция для проверки существования файла
validate_file() {
    if [ ! -f "$1" ]; then
        echo "Файл $1 не существует."
        exit 2
    fi
}

# Функция разделения файла
split_file() {
    validate_file "$1"
    local file=$1
    local size=$2
    base_name=$(basename "$file")
    echo -n "Разделение файла $file..."
    split -b "$size" -a 2 "$file" "$base_name.part_"
    echo "Файл $file разделен. Размер части: $size."
}

# Функция объединения файлов
join_files() {
    local mask="${1}*"
    local files=$(ls $mask 2> /dev/null)
    
    if [ -z "$files" ]; then
        echo "Файлы по маске $mask не найдены."
        exit 3
    fi
    
    base_name=$(echo "$mask" | awk -F '.part_' '{print $1}')
    echo -n "Объединение файлов..."
    cat $mask > "$base_name"
    echo "Файлы по маске $mask объединены в $base_name."
}

# Выбор операции
case $operation in
    "split")
        split_file "$file_mask" "$size"
        ;;
    "join")
        join_files "$file_mask"
        ;;
    *)
        echo "Неверная операция. Допустимы только 'split' или 'join'."
        exit 1
        ;;
esac
