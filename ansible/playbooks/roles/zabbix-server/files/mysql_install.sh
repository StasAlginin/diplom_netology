#!/bin/bash

DB_ROOT_PASSWORD="password"
DB_ZABBIX_PASSWORD="zabbix_password"

# Функция для выполнения команд MySQL
function run_mysql_command() {
    mysql -uroot -p"$DB_ROOT_PASSWORD" -e "$1"
}

# Создание базы данных и пользователя
echo "Создаем базу данных и пользователя для Zabbix..."
run_mysql_command "CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
run_mysql_command "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY '$DB_ZABBIX_PASSWORD';"
run_mysql_command "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
run_mysql_command "SET GLOBAL log_bin_trust_function_creators = 1;"

# Импорт схемы базы данных
echo "Импортируем схему базы данных Zabbix..."
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p"$DB_ZABBIX_PASSWORD" zabbix

# Отключение опции log_bin_trust_function_creators
echo "Отключаем опцию log_bin_trust_function_creators..."
run_mysql_command "SET GLOBAL log_bin_trust_function_creators = 0;"

echo "Выполнение скрипта завершено"