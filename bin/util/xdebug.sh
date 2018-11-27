 #!/usr/bin/env bash
 install_xdebug_ext() {
 $(which composer) require -d "$build_dir/.heroku/php" -- "heroku-sys/ext-xdebug:*" >> $build_dir/.heroku/php/install.log
 echo "- Xdebug detected, installed ext-xdebug" | indent
}