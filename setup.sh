#!/bin/bash

# Guide Advisor - скрипт установки для Linux/Mac

echo "Guide Advisor - Установка"
echo "================================="
echo ""

# Проверка наличия Python
echo "Проверка Python..."
if ! command -v python3 &> /dev/null; then
    echo "ОШИБКА: Python 3 не найден!"
    echo "Установите Python 3.8+ с https://www.python.org/downloads/"
    exit 1
fi
echo "OK: Python найден: $(python3 --version)"

# Проверка наличия pip
echo ""
echo "Проверка pip..."
if ! command -v pip3 &> /dev/null; then
    echo "ОШИБКА: pip не найден!"
    echo "Установите pip: python3 -m ensurepip --upgrade"
    exit 1
fi
echo "OK: pip найден"

# Установка зависимостей
echo ""
echo "Установка зависимостей..."
pip3 install -r requirements.txt

# Проверка успешности
if [ $? -eq 0 ]; then
    echo ""
    echo "Установка завершена успешно!"
    echo ""
    echo "Для запуска программы выполните:"
    echo "   python3 main.py"
    echo ""
    echo "Тестовые аккаунты:"
    echo "   Админ: admin@guide.ru / admin123"
    echo "   Гид:   anna@guide.ru / guide123"
    echo "   Турист: tourist@test.ru / tourist123"
else
    echo ""
    echo "ОШИБКА: Не удалось установить зависимости"
    exit 1
fi