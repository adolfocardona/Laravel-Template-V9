FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential autoconf \
    libcurl4-openssl-dev \
    libxml2-dev \
    libsqlite3-dev \
    zip \
    unzip \
    git \
    zlib1g-dev \
    libssl-dev \
    libonig-dev

# Instalar extensiones prioritarias (ctype y curl)
RUN docker-php-ext-install -j$(nproc) \
    ctype \
    curl

# Instalar el resto de las extensiones
RUN docker-php-ext-install -j$(nproc) \
    dom \
    fileinfo \
    filter \
    mbstring \
    pdo \
    pdo_mysql \
    xml \
    session \
    pcntl \
    # tokenizer \
    # openssl \
    # hash \
    opcache

# Limpiar el caché de apt para reducir el tamaño de la imagen
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar configuraciones personalizadas de PHP si es necesario
# ADD ./php.ini /usr/local/etc/php/php.ini

RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
