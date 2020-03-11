FROM ubuntu:18.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

ENV MYSQL_USER radius
ENV MYSQL_PASSWORD dalodbpass
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE radius

ENV TZ  Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
 && apt-get install -y --fix-missing \
                apache2 \
                apt-utils \
                autoconf \
                autogen \
                automake \
                build-essential \
                cron \
                freeradius \
                freeradius-common \
                freeradius-config \
                freeradius-mysql \
                freeradius-utils \
                git \
                gnutls-bin \
                gperf \
                iptables \
                lcov \
                libapache2-mod-php \
                libev-dev \
                libgnutls28-dev \
                libhttp-parser-dev \
                libkrb5-dev \
                liblockfile-bin \
                liblz4-dev \
                libmysqlclient-dev \
                libnl-route-3-dev \
                liboath-dev \
                libopts25-dev \
                libpam0g-dev \
                libpcl1-dev \
                libprotobuf-c1 \
                libreadline-dev \
                libseccomp-dev \
                libtalloc-dev \
                libwrap0-dev \
                mariadb-client \
                nettle-dev \
                net-tools \
                nuttcp \
                php \
                php-common \
                php-curl \
                php-db \
                php-gd \
                php-mail \
                php-mail-mime \
                php-mysql \
                php-pear \
                pkg-config \
                supervisor \
                unzip \
                wget \
                xz-utils \
                vim \
                protobuf-c-compiler \
                libradcli4 \
                libradcli-dev \
                libprotobuf-c* \
                ruby-ronn \
                iproute2 \
                iputils-ping \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && pear install -a DB \
 && pear install -a Mail \
 && pear install -a Mail_Mime

ENV DALO_VERSION 1.1-2

RUN wget https://github.com/lirantal/daloradius/archive/"$DALO_VERSION".zip \
 && unzip "$DALO_VERSION".zip \
 && rm "$DALO_VERSION".zip \
 && mv daloradius-"$DALO_VERSION" /var/www/html/daloradius \
 && chown -R www-data:www-data /var/www/html/daloradius \
 && chmod 644 /var/www/html/daloradius/library/daloradius.conf.php

# configuration ocserv
RUN mkdir -p /temp && cd /temp \
    && git clone https://gitlab.com/openconnect/ocserv.git \
    && cd ocserv \
    && sh autogen.sh \
    && ./configure --prefix=/usr --sysconfdir=/etc --with-local-talloc \
    && make && make install \
    && cd / && rm -rf /temp


COPY supervisor.conf /etc/
COPY supervisor-apache2.conf /etc/supervisor/conf.d/apache2.conf
COPY supervisor-freeradius.conf /etc/supervisor/conf.d/freeradius.conf
COPY supervisor-ocserv.conf /etc/supervisor/conf.d/ocserv.conf

COPY freeradius-default-site /etc/freeradius/3.0/sites-available/default

COPY init.sh /cbs/

CMD ["sh", "/cbs/init.sh"]
