FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential autoconf \
    libcurl4-openssl-dev \
    libxml2-dev \
    libsqlite3-dev \
    libonig-dev \
    zlib1g-dev \
    libssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libwebp-dev \
    libgmp-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    procps

# Instalar extensiones prioritarias
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

# Instalar extensiones prioritarias (ctype y curl)
RUN docker-php-ext-install -j$(nproc) \
    gd \
    ctype \
    curl \
    dom \
    fileinfo \
    filter \
    gmp \
    mbstring \
    pdo \
    pdo_mysql \
    session \
    pcntl \
    xml \
    zip \
    # tokenizer \
    # openssl \
    # hash \
    opcache

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Copiar configuraciones personalizadas de PHP si es necesario
# ADD ./php.ini /usr/local/etc/php/php.ini

# Limpiar el caché de apt para reducir el tamaño de la imagen
RUN apt-get clean && rm -rf /var/lib/apt/lists/*