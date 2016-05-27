FROM php:7-alpine

RUN docker-php-ext-install opcache

RUN mkdir /opcache \
 && echo 'opcache.enable=1' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo 'opcache.enable_cli=1' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo 'opcache.validate_timestamps=0' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo 'opcache.file_cache="/opcache"' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo 'opcache.file_update_protection=0' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo 'opcache.fast_shutdown=1' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo 'opcache.log_verbosity_level=0' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
 && chmod a+x /usr/local/bin/symfony

ENV SYMFONY_ENV=prod
RUN symfony demo /srv \
 && echo 'doctrine: {dbal: {path: "%kernel.root_dir%/data/blog.sqlite"}}' >> /srv/app/config/config_prod.yml \
 && /srv/app/console cache:warmup \
 && find -L /srv -name '*.php' -exec php -l {} \; -exec sh -c ": > {}" \;

CMD php /srv/app/console
