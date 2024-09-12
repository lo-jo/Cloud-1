FROM	debian:bullseye

RUN	apt-get update -y && apt-get upgrade -y

RUN	apt-get install nginx openssl -y

#	Create the key and the certifcate for TSL protocol
#	-x509 refers to the certificate's type
#	-out and -keyout parameters refers to where the certificate will be saved
#	-subj refers to the command response
#	(Country, State, Locality, Organization name, Organizational Unit name, Common Name)
RUN	openssl req \
        -x509 \
        -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42Paris/CN=mflores.42.fr"

RUN	mkdir -p /var/www/html && chmod -R 755 /var/www/html

RUN	chown -R www-data:www-data /var/www/html

#	Copy the nginx configuration file
#	nginx.conf is the main configuration file for the Nginx web server
#	copying a local version of the nginx.conf file to the container
#	you can customize the server's configuration without having to rebuild the image
RUN	mkdir -p /var/run/nginx

COPY	./conf/nginx.conf /etc/nginx/conf.d/

RUN	chmod -R 755 /etc/nginx/conf.d/nginx.conf

#	Expose port 443 (only port allowed) to allow incoming corrections
EXPOSE	443

#	Run nginx with daemon off, i.e. in the foreground since one container only
#	has one service. This is best practice for Docker containers and/or debugging.
CMD	[ "nginx", "-g", "daemon off;" ]
