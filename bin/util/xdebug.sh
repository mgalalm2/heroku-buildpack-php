 #!/usr/bin/env bash
 install_xdebug_ext() {
 $(which composer) require --update-no-dev -d "$build_dir/.heroku/php" -- "heroku-sys/ext-xdebug:*" >> $build_dir/.heroku/php/install.log 2>&1;
 echo "- Xdebug detected, installed ext-xdebug" | indent
}