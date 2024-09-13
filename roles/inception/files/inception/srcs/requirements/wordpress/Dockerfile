FROM    debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install unzip curl wget \
    php php-mysql php-fpm php-common php-curl -y

RUN apt-get install default-mysql-client -y

RUN apt-get install mariadb-client -y

RUN mkdir -p /var/run/ && mkdir -p /run/php/

#   The installation of wordpress is done with WP-CLI (https://wp-cli.org/fr/)
#   https://make.wordpress.org/cli/handbook/guides/installing/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

#   Modifying php config files
COPY    ./conf/www.conf /etc/php/7.4/fpm/pool.d/

EXPOSE  9000

# Move the config script in the docker
COPY    ./tools/init_wordpress.sh /tmp/

RUN chmod +x /tmp/init_wordpress.sh

ENTRYPOINT  [ "/tmp/init_wordpress.sh" ]
