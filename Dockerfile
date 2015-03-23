FROM ubuntu:trusty
MAINTAINER Joey Hipolito <hi@joeyhipolito.me>

# Prepare basic dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=notinteractive apt-get install -yq wget \
# Install php
    php5-cli php5-dev \
# Install zeromq dependencies
    libtool autoconf automake uuid-dev build-essential \
# Install zeromq-php binding dependencies
    pkg-config

# Install zermoq
RUN cd /tmp \
    && wget http://download.zeromq.org/zeromq-4.0.5.tar.gz \
    && tar -zxvf zeromq-4.0.5.tar.gz && cd zeromq-4.0.5 \
    && ./configure && make && make install \
# Intstall zeromq-php bindings
    && wget -O zmq.tar.gz https://github.com/mkoppanen/php-zmq/archive/master.tar.gz \
    && tar -zxvf zmq.tar.gz \
    && cd php-zmq-master \
    && phpize && ./configure && make && make install \
    && echo "extension=zmq.so" > /etc/php5/mods-available/zmq.ini \
    && php5enmod zmq

WORKDIR /usr/src/app]
