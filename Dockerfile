FROM ubuntu:18.04


# RUN sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list
RUN sed 's/kr.archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list

RUN apt-get update

       
RUN apt install -y software-properties-common

RUN add-apt-repository ppa:ondrej/php


RUN apt-get update && \
       apt-get install -y --no-install-recommends apt-utils && \
       apt-get -y install sudo
## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Europe select Berlin" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update && \
    apt-get install -y tzdata
    

RUN apt-get install -y php7.0

RUN apt-get install -y php7.0-curl

RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y vim

# RUN apt-get install -y cron
RUN apt-get install -y gnupg
RUN apt-get install -y mysql-client

RUN apt-get install -y nginx php php7.0-fpm php7.0-mysql php7.0-gd php7.0-xml php7.0-intl phpunit 
RUN apt-get install -y php7.0-mbstring 
RUN apt-get install -y php7.0-zip



RUN mkdir /data

RUN rm -rf /etc/php/7.0/fpm/php.ini
RUN rm -rf /etc/nginx/sites-available/default
RUN rm -rf /etc/php/7.0/fpm/pool.d/www.conf


ADD conf/php.ini /etc/php/7.0/fpm/php.ini
ADD conf/default /etc/nginx/sites-available/default
ADD conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf


ADD check.sh /home/check.sh
ADD add_env.sh /home/add_env.sh


WORKDIR /home

CMD ["/bin/bash", "-c", "source /home/add_env.sh && sh /home/check.sh && /usr/sbin/service php7.0-fpm start && nginx -g 'daemon off;'"]





