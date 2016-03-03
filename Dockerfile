############################################################
# Dockerfile for symfony based project 
# Contains standard(apache php etc) and other usefull tools  (phploy, symfonyinstaller  etc) 
# Based on Ubuntu
# Image without  Database
############################################################
FROM ubuntu:latest

MAINTAINER Michal Glajc (poznet) <michal@glajc.pl>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get install -y 
RUN apt-get -y install wget curl 
RUN apt-get -y install php5-mcrypt apache2 \
	libapache2-mod-php5 \
	php5-mysql \
	php5-gd \
	php5-curl \
	php-pear \
	php-apc \
	php5-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

 
#APACHE
ADD files/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod php5 && a2enmod suexec && a2enmod userdir && a2enmod rewrite && a2enmod ssl && php5enmod mcrypt

ENV APACHE_RUN_USER=www-data \
	APACHE_RUN_GROUP=www-data \
	APACHE_LOG_DIR=/var/log/apache2 \
	APACHE_LOCK_DIR=/var/lock/apache2 \
	APACHE_PID_FILE=/var/run/apache2.pid \
	NODE_ENVIRONMENT=$NODE_ENVIRONMENT

VOLUME  ["/var/www"]
ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
EXPOSE 80 443


 

