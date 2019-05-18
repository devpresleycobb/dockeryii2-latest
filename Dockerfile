FROM ubuntu:18.04

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt install apache2 -y curl -y software-properties-common -y && \
add-apt-repository ppa:ondrej/php && \
apt-get update && \
apt-get install php7.3 -y && \
apt-get install php-pear -y php7.3-curl -y php7.3-dev -y php7.3-gd -y php7.3-mbstring -y php7.3-zip -y php7.3-mysql -y php7.3-xml -y && \
update-alternatives --set php /usr/bin/php7.3

WORKDIR /var/www/html
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer create-project --prefer-dist yiisoft/yii2-app-basic yii2

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
WORKDIR /var/www/html/yii2
RUN composer global require fxp/composer-asset-plugin
RUN apt-get install git -y
RUN git init
RUN git config user.name "Yii2"
RUN git config user.email ""
RUN git remote add origin https://github.com/devpresleycobb/yii2.git