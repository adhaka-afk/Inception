FROM alpine:3.19

ARG DB_NAME \
    DB_USER \
    DB_PASS

# Installing necessary packages and PHP extensions
RUN apk update && apk upgrade && apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    php-json \
    php-curl \
    php-dom \
    php-exif \
    php-fileinfo \
    php-mbstring \
    php-openssl \
    php-xml \
    php-zip \
    wget \
    unzip && \
    rm -f /var/cache/apk/*

# Configuring PHP-FPM
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php82/php-fpm.d/www.conf

# Setting the working directory
WORKDIR /var/www

# Downloading and extracting WordPress
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

# Copying and running the WordPress configuration script
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

# Starting PHP-FPM
CMD ["/usr/sbin/php-fpm82", "-F"]
