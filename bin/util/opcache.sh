#!/usr/bin/env bash

cat > $build_dir/.heroku/php/etc/php/conf.d/010-ext-zend_opcache.ini <<'EOF'
zend_extension=opcache.so
opcache.enable=0
opcache.validate_timestamps=0
opcache.fast_shutdown=0
opcache.memory_consumption=256
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
EOF