#!/usr/bin/env bash
OUT_PREFIX=$1
echo "-----> Building xdebug..."
curl -L  http://xdebug.org/files/xdebug-2.6.1.tgz | tar -xvzf -
cd xdebug-2.6.1
phpize
./configure
make -s -j 9
cp modules/xdebug.so /app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303
mkdir -p ${OUT_PREFIX}/etc/php/conf.d
cat > $build_dir/.heroku/php/etc/php/conf.d/xdebug.ini <<'EOF'
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_host=docker.for.mac.host.internal
xdebug.remote_port=9001
xdebug.remote_connect_back=1
EOF
