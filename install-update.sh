#!/bin/sh

if [ ! -d '.git' ]; then
  echo "Error: No git repo!"
  exit 0
fi

if [ ! -d '.git/hooks' ]; then
  echo "Error: No hooks in git repo!"
  exit 0
fi

src=vendor/wunderio/code-quality/pre-commit
if [ ! -f "$src" ]; then
  echo "Error: missing $src"
  exit 0
fi

dst=.git/hooks/pre-commit
if [ ! -L "$dst" ]; then
  rm -fv "$dst"
  ln -sv "$src" "$dst"
fi
