FROM	debian:bullseye

RUN	apt-get update -y && apt-get upgrade -y

RUN	apt-get install mariadb-server mariadb-client -y

#   Create mysql service directory to store data related to mysql service,
#   such as configuration files, logs, and data files.
#   We do this to help keep the service data organized
#   and separate from other system data, to make it easier to manage and backup.
RUN	mkdir -p /run/mysqld && chown -R mysql:root /run/mysqld

#   Copy the my.cnf file into the directory /etc/mysql/, in the my 50-server.cnf file we specify the port and set
#   bind-address=0.0.0.0 to allow the mariadb server to listen for connections from any IP address, including
#   the IP addresses from other containers and the host machine
COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#   Copy the script in the docker image
COPY    ./tools/init_database.sh /tmp/

#   Make sure that we can execute the script
RUN	chmod +x /tmp/init_database.sh

#   Run MariaDB configuration script as entry point
ENTRYPOINT	[ "/tmp/init_database.sh" ]
