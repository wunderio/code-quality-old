#!/bin/bash

# This script performs code quality checker.

set -x
set -e
set -u
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

if ! command -v jq >/dev/null 2>&1; then
  echo "jq not found."
  echo "Mac: brew install jq"
  echo "Linux: sudo apt-get install jq"
  echo "Linux: sudo yum install jq"
  exit 1
fi

trap "rm -rf /tmp/code-quality-test-install.$$.*" EXIT

install_dir=$(mktemp -d /tmp/code-quality-test-install.$$.XXXXXX)

package_dir=$(dirname "${BASH_SOURCE[0]}")/..

cd "$install_dir"
git init

composer init \
  --no-interaction \
  --name='wunderio/code-quality-test' \
  --author='Ragnar Kurm <ragnar.kurm@wunder.io>' \
  --stability=dev \
  --type=project \
  --repository='{ "type": "vcs", "url": "git@github.com:wunderio/code-quality.git" }' \
  --require-dev='wunderio/code-quality:dev-master' \

composer_json="$install_dir/composer.json"
composer_json_tmp="$install_dir/composer.json.tmp"
jq '.scripts += {
  "post-install-cmd": [ "./vendor/wunderio/code-quality/install-update.sh" ],
  "post-update-cmd": [ "./vendor/wunderio/code-quality/install-update.sh" ]
}' \
< "$composer_json" \
> "$composer_json_tmp"
mv "$composer_json_tmp" composer.json
composer install
composer update

cat composer.json
ls -la . .git/hooks vendor/wunderio/code-quality
