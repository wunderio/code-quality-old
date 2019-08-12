#!/bin/sh

set -e
set -u
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

relpath() {
  python -c 'import os.path, sys; print os.path.relpath(sys.argv[1],sys.argv[2])' "$1" "$2"
}

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
# Check if we are executed inside a repo.
if [ ! "$inside_git_repo" ]; then
  echo "Error: No git repo!"
  exit 0
fi

toplevel=$(git rev-parse --show-toplevel)
hooks="$toplevel/.git/hooks"
# Check if hooks dir exists.
if [ ! -d "$hooks" ] ; then
  echo "Error: No hooks in git repo!"
  exit 0
fi

source="$(pwd)/vendor/wunderio/code-quality/pre-commit"
# Check if the actual hook script is there.
if [ ! -f "$source" ]; then
  echo "Error: missing $source"
  exit 0
fi

target="$hooks/pre-commit"
source_rel=$(relpath "$source" "$target")
# If correct link exists, dont mess with it.
if [ -L "$target" ]; then
  source_existing=$(readlink "$target")
  if [ "$source_existing" = "$source_rel" ]; then
    exit 0
  fi
fi

rm -fv "$target"
ln -sv "$source_rel" "$target"
