#!/bin/sh

if [ ! -d '.git' ] && [ ! -d '../.git' ]; then
  echo "Error: No git repo!"
  exit 0
fi

if [ ! -d '.git/hooks' ] && [ ! -d '../.git/hooks' ]; then
  echo "Error: No hooks in git repo!"
  exit 0
fi

src=vendor/wunderio/code-quality/pre-commit
if [ ! -f "$src" ]; then
  echo "Error: missing $src"
  exit 0
fi


dst=.git/hooks/pre-commit
if [ -d '../.git' ]; then
  dst=../.git/hooks/pre-commit
fi

if [ ! -f "$dst" ]; then
  rm -fv "$dst"
  cp "$src" "$dst"
fi
