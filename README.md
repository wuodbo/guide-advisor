# Guide-Advisor

Десктопное приложение для управления экскурсиями, гидами и туристами. Построено на Python с использованием CustomTkinter и MySQL.

## Возможности

Приложение поддерживает три роли пользователей с разными правами доступа:

**Администратор (ADM)**
- Управление пользователями (гиды, туристы)
- Просмотр и модерация всех экскурсий
- Доступ к отчётам и аналитике (экспорт в PDF и Excel)

**Гид (GUI)**
- Создание и редактирование экскурсий (название, категория, описание, фото)
- Управление расписанием
- Просмотр отзывов и бронирований

**Турист (TUR)**
- Каталог экскурсий с поиском и фильтрацией по категориям
- Бронирование экскурсий
- Персональные рекомендации
- Написание отзывов
- Уведомления

## Технологии

- Python 3.x
- [CustomTkinter](https://github.com/TomSchimansky/CustomTkinter) — GUI
- [PyMySQL](https://pymysql.readthedocs.io/) — подключение к MySQL
- [ReportLab](https://www.reportlab.com/) — генерация PDF-отчётов (опционально)
- [openpyxl](https://openpyxl.readthedocs.io/) — генерация Excel-отчётов (опционально)
- [Pillow](https://pillow.readthedocs.io/) — работа с изображениями (опционально)

## Установка

**1. Клонировать репозиторий**

```bash
git clone https://github.com/wuodbo/guide-advisor
cd guide-advisor
```

**2. Установить зависимости**

```bash
pip install -r requirements.txt
```
**3. Создать базу данных**

Убедитесь, что MySQL-сервер запущен, затем выполните SQL-скрипты:

```bash
mysql -u root -p < schema.sql
mysql -u root -p < seed_data.sql
```

`schema.sql` создаёт базу данных `guideadvisor` и все таблицы. `seed_data.sql` заполняет БД тестовыми пользователями и экскурсиями (опционально).

**4. Настроить подключение к базе данных**

Создайте файл `config.py` в корне проекта:

```python
DB_CONFIG = {
    'host': 'YOUR_HOSTNAME_HERE',
    'user': 'YOUR_USERNAME_HERE',
    'password': 'YOUR_PASSWORD_HERE',
    'database': 'guideadvisor',
    'port': 8889,  # Для MAMP/XAMPP: 8889, для стандартного MySQL: 3306
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor,
}
```

**5. Запустить приложение**

```bash
python main.py
```

## Тестовые аккаунты

| Роль | Email | Пароль |
|------|-------|--------|
| Администратор | admin@guide.ru | admin123 |
| Гид | anna@guide.ru | guide123 |
| Гид | mikhail@guide.ru | guide123 |
| Гид | elena@guide.ru | guide123 |
| Турист | tourist@test.ru | tourist123 |
## Структура БД

| Таблица | Описание |
|---------|----------|
| `users` | Все пользователи системы (ADM / GUI / TUR) |
| `guides` | Профили гидов (специализация, опыт, рейтинг) |
| `excursions` | Экскурсии (категория, описание, фото, статус) |
| `schedules` | Расписание экскурсий |
| `bookings` | Бронирования туристов |
| `reviews` | Отзывы на экскурсии |
| `notifications` | Уведомления пользователей |
| `user_preferences` | Предпочтения и настройки пользователей |
| `user_activity` | Лог активности (просмотры, бронирования) |

## Структура проекта

```
guide-advisor/
├── main.py       # Основной файл приложения
├── config.py     # Конфигурация подключения к БД (создаётся вручную)
└── photos/       # Папка для загруженных фотографий (создаётся автоматически)
```
