#!/usr/bin/env bash
wget http://xdebug.org/files/xdebug-2.6.1.tgz
tar -xvzf xdebug-2.6.1.tgz
cd xdebug-2.6.1
phpize
./configure
make
cp modules/xdebug.so /app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303
echo "zend_extension=/app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so" >> /app/.heroku/php/etc/php/php.ini