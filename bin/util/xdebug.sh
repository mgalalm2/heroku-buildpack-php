#!/usr/bin/env bash
OUT_PREFIX=$1
wget http://xdebug.org/files/xdebug-2.6.1.tgz
tar -xvzf xdebug-2.6.1.tgz
cd xdebug-2.6.1
phpize
./configure
make
cp modules/xdebug.so /app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303
#echo "zend_extension=/app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so" >> /app/.heroku/php/etc/php/php.ini
cat > ${OUT_PREFIX}/etc/php/conf.d/xdebug.ini-dist <<'EOF'
zend_extension=xdebug.so
;xdebug.remote_autosta rt=0
xdebug.remote_enable=1
;xdebug.default_enable=0
;xdebug.remote_host=docker.for.mac.host.internal
xdebug.remote_host=172.22.0.8
xdebug.remote_port=9001
xdebug.remote_connect_back=1
EOF

