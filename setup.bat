@echo off
title Guide Advisor - Установка

echo =================================
echo    Guide Advisor - Установка
echo =================================
echo.

:: Проверка наличия Python
echo [1/3] Проверка Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo [ОШИБКА] Python не найден!
    echo Установите Python 3.8+ с https://www.python.org/downloads/
    echo Не забудьте отметить "Add Python to PATH" при установке!
    pause
    exit /b 1
)
echo [OK] Python найден: 
python --version
echo.

:: Обновление pip
echo [2/3] Обновление pip...
python -m pip install --upgrade pip >nul 2>&1
echo [OK] pip обновлен
echo.

:: Установка зависимостей
echo [3/3] Установка зависимостей...
pip install -r requirements.txt

if errorlevel 1 (
    echo.
    echo [ОШИБКА] Не удалось установить зависимости
    pause
    exit /b 1
)

echo.
echo =================================
echo    Установка завершена!
echo =================================
echo.
echo Для запуска программы выполните:
echo   python main.py
echo.
echo Тестовые аккаунты:
echo   Админ:  admin@guide.ru / admin123
echo   Гид:    anna@guide.ru / guide123
echo   Турист: tourist@test.ru / tourist123
echo.
pause