FROM php:8.3-apache

# パッケージと必要なツールのインストール
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    && rm -rf /var/lib/apt/lists/*

# PHP拡張のインストール（Laravel用）
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    mbstring \
    zip \
    exif \
    pcntl \
    gd

# Apache設定
RUN a2enmod rewrite

# 作業ディレクトリ設定
WORKDIR /var/www/html

# 権限設定（事前に実行）
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

# Apache起動
CMD ["apache2-foreground"]
