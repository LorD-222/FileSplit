# File Split and Join Utility

## Описание
Этот скрипт на Bash позволяет разделять большие файлы на меньшие части и объединять их обратно. Подходит для работы с любыми типами файлов.

## Зависимости
- `split`
- `awk`
- `cat`

## Использование
Чтобы использовать скрипт, выполните одну из следующих команд:

### Разделение файла
Для разделения файла на части используйте команду `split`:
```bash
./file_split.sh split [имя файла] [размер части]
```

- `[имя файла]` - полное имя файла, который нужно разделить.
- `[размер части]` - размер каждой части в байтах (по умолчанию 25M).

Пример:
```bash
./file_split.sh split example.txt 5M
```

### Объединение файлов
Для объединения файлов в исходный файл используйте команду `join`:
```bash
./file_split.sh join [маска файлов]
```

- `[маска файлов]` - маска для частей файла, которые нужно объединить.

Пример:
```bash
./file_split.sh join example.txt.part_
```
