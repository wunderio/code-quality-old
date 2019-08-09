#!/bin/sh

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

if [ ! "$inside_git_repo" ]; then
  echo "Error: No git repo!"
  exit 0
fi

if [ ! -d "$(git rev-parse --show-toplevel)/.git/hooks" ] ; then
  echo "Error: No hooks in git repo!"
  exit 0
fi

src="$(pwd)/vendor/wunderio/code-quality/pre-commit"
if [ ! -f "$src" ]; then
  echo "Error: missing $src"
  exit 0
fi


dst="$(git rev-parse --show-toplevel)/.git/hooks/pre-commit"

if [ ! -f "$dst" ]; then
  rm -fv "$dst"
  ln -sv "$src" "$dst"
fi
