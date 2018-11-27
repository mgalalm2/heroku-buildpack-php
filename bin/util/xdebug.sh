#!/usr/bin/env bash
OUT_PREFIX=$1

source $(dirname $BASH_SOURCE)/../../_util/include/manifest.sh
dep_formula=${0#$WORKSPACE_DIR/}
dep_name=$(basename $BASH_SOURCE)
dep_version=${dep_formula##*"/${dep_name}-"}
dep_package=ext-${dep_name}-${dep_version}
series=7.1
dep_manifest=${dep_package}_php-$series.composer.json
dep_url=http://xdebug.org/files/xdebug-2.6.1.tgz
wget $dep_url
tar -xvzf xdebug-2.6.1.tgz
cd xdebug-2.6.1
phpize
./configure
make
cp modules/xdebug.so /app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303
#echo "zend_extension=/app/.heroku/php/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so" >> /app/.heroku/php/etc/php/php.ini
mkdir -p ${OUT_PREFIX}/etc/php/conf.d
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



MANIFEST_REQUIRE="${MANIFEST_REQUIRE:-"{\"heroku-sys/php\":\"${series}.*\"}"}"
MANIFEST_CONFLICT="${MANIFEST_CONFLICT:-"{\"heroku-sys/hhvm\":\"*\"}"}"
MANIFEST_REPLACE="${MANIFEST_REPLACE:-"{}"}"
MANIFEST_PROVIDE="${MANIFEST_PROVIDE:-"{}"}"
MANIFEST_EXTRA="${MANIFEST_EXTRA:-"{\"config\":\"etc/php/conf.d/newrelic.ini-dist\",\"profile\":\"bin/profile.newrelic.sh\"}"}"

python $(dirname $BASH_SOURCE)/../../_util/include/manifest.py "heroku-sys-php-extension" "heroku-sys/ext-${dep_name}" "$dep_version" "${dep_formula}.tar.gz" "$MANIFEST_REQUIRE" "$MANIFEST_CONFLICT" "$MANIFEST_REPLACE" "$MANIFEST_PROVIDE" "$MANIFEST_EXTRA" > $dep_manifest

print_or_export_manifest_cmd "$(generate_manifest_cmd "$dep_manifest")"