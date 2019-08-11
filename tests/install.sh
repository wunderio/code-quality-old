#!/bin/bash

# This script performs code quality checker,
# installing not yet committed code.

set -x
set -e
set -u
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

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

cat composer.json

composer install
