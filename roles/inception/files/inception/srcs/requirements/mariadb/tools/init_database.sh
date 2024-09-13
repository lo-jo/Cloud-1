#!/bin/bash

#   Check if the wordpress database is already created
echo "=> Checking if '$BDD_NAME' database exists . . ."
if [ ! -d "/var/lib/mysql/$BDD_NAME" ]; then

    #   Check if MariaDB is already running
    if ! service mariadb status > /dev/null; then
        echo "=> MariaDB service is not running, starting it . . ."
        service mariadb start
        sleep 2
    else
        echo "=> MariaDB service is already running."
    fi

    echo "=> creating '$BDD_NAME' database . . ."
    # CREATE WORDPRESS DATABASE
    mysql -e "CREATE DATABASE IF NOT EXISTS $BDD_NAME;"

    # CREATE USER
    echo "=> creating user . . ."
    mysql -e "CREATE USER IF NOT EXISTS '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';"

    # PRIVILEGES USER FOR ALL IP ADRESSES
    mysql -e "GRANT ALL PRIVILEGES ON $BDD_NAME.* TO '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';"

    mysql -e "FLUSH PRIVILEGES;"

    # FORCE AUTHENTIFICATION WITH PASSWORD FOR ROOT
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$BDD_ROOT_PASSWORD';"

    mysqladmin -u root -p${BDD_ROOT_PASSWORD} shutdown

    echo "=> MariaDB database and user were created successfully! "

    # Shutdown MariaDB gracefully if it was started in this script
    if [ -f /var/run/mysqld/mysqld.pid ]; then
        echo "=> Shutting down MariaDB..."
        service mariadb stop
        # kill $(cat /var/run/mysqld/mysqld.pid)
        sleep 2
    fi

else
    echo "=> '$BDD_NAME' database exists!"
fi

exec mysqld
