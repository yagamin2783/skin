FROM php:8.4-apache

# PHP拡張インストール
RUN docker-php-ext-install pdo pdo_mysql

# Apache設定
RUN a2enmod rewrite

# 作業ディレクトリ設定
WORKDIR /var/www/html

# アプリケーションファイルコピー
COPY . .

# 権限設定
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
