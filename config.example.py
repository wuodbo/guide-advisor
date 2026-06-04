# Скопируйте этот файл в config.py и введите свои реальные данные
import pymysql

# Настройки базы данных
DB_CONFIG = {
    'host': 'YOUR_HOSTNAME_HERE',
    'user': 'YOUR_USERNAME_HERE',
    'password': 'YOUR_PASSWORD_HERE',
    'database': 'guide',
    'port': 8889,  # Для MAMP/XAMPP: 8889, для стандартного MySQL: 3306
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor,
}

# Тестовые акканты
TEST_ACCOUNTS = {
    'admin': {
        'email': 'admin@guide.ru',
        'password': 'admin123'
    },
    'guide': {
        'email': 'anna@guide.ru',
        'password': 'guide123'
    },
    'tourist': {
        'email': 'tourist@test.ru',
        'password': 'tourist123'
    }
}
