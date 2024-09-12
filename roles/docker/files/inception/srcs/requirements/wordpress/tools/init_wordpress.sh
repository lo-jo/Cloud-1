#!/bin/sh

cd $WP_PATH_DIR

#   Check if WordPress is installed
echo "=> Checking for WordPress installation..."
if [ ! -f "wp-config.php" ]; then

    sleep 100

    echo "=> Downloading wordpress..."
	wp core download --allow-root

	echo "=> Create config file . . ."
    wp config create --dbname=${BDD_NAME} \
                    --dbuser=${BDD_USER} \
                    --dbpass=${BDD_USER_PASSWORD} \
                    --dbhost=${BDD_HOST} --path=${WP_PATH_DIR} \
                    --allow-root
	echo "=> Done!"

	echo "=> Installing WordPress . . ."
    wp core install --url=${DOMAIN_NAME} \
                    --title=${WP_TITLE} \
                    --admin_user=${WP_ADMIN_USER} \
                    --admin_password=${WP_ADMIN_PASSWORD} \
                    --admin_email=${WP_ADMIN_EMAIL} \
                    --skip-email --allow-root
    echo "=> Done!"

    echo "=> Creating new user ($WP_USER)"
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
                    --user_pass=${WP_USER_PASSWORD} \
                    --role=${WP_USER_ROLE} \
                    --allow-root

    echo "=> Done!"

    echo "=> Activating WordPress theme . . ."
    wp theme activate twentytwentytwo --allow-root
else
    echo "=> WordPress already installed and configured!"
fi

php-fpm7.4 -F -R
