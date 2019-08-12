#!/bin/bash

# This script performs code quality checker.

set -x
set -e
set -u
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

usage() {
  echo "Usage: $0 [-k] [-c DIR]"
  echo "  -c DIR - Composer dir."
  echo "  -k     - Keep the test."
  exit 1
}

composer_dir=''
keep=0
while getopts 'kc:' c
do
  case "$c" in
    c) composer_dir="$OPTARG" ;;
    k) keep=1 ;;
    *) usage ;;
  esac
done

if ! command -v jq >/dev/null 2>&1; then
  echo "jq not found."
  echo "Mac: brew install jq"
  echo "Linux: sudo apt-get install jq"
  echo "Linux: sudo yum install jq"
  exit 1
fi

if [ "$keep" -eq 0 ]; then
  trap "rm -rf /tmp/code-quality-test-install.$$.*" EXIT
fi

git_dir=$(mktemp -d /tmp/code-quality-test-install.$$.XXXXXX)

package_dir=$(dirname "${BASH_SOURCE[0]}")/..

if [ -z "$composer_dir" ]; then
  composer_dir="$git_dir"
else
  composer_dir="$git_dir/$composer_dir"
  mkdir -pv "$composer_dir"
fi

cd "$git_dir"
git init

cd "$composer_dir"
composer init \
  --no-interaction \
  --name='wunderio/code-quality-test' \
  --author='Ragnar Kurm <ragnar.kurm@wunder.io>' \
  --stability=dev \
  --type=project \
  --repository='{ "type": "vcs", "url": "git@github.com:wunderio/code-quality.git" }' \
  --require-dev='wunderio/code-quality:dev-master' \

composer_json="$composer_dir/composer.json"
composer_json_tmp="$composer_dir/composer.json.tmp"
jq '.scripts += {
  "post-install-cmd": [ "./vendor/wunderio/code-quality/install-update.sh" ],
  "post-update-cmd": [ "./vendor/wunderio/code-quality/install-update.sh" ]
}' \
< "$composer_json" \
> "$composer_json_tmp"
mv "$composer_json_tmp" composer.json
composer install
composer update

cat "$composer_dir/composer.json"
ls -la \
  "$git_dir" \
  "$git_dir/.git/hooks" \
  "$composer_dir/vendor/wunderio/code-quality"

test -f "$git_dir/.git/hooks/pre-commit"
