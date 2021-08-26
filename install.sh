#!/bin/bash

set -eu

# 実行場所のディレクトリを取得
THIS_DIR="$HOME/ghq/github.com/mtgnk/dotfiles"

if [ ! -d "$THIS_DIR" ]; then
  git clone https://github.com/mtgnk/dotfiles.git "$THIS_DIR"
else
  echo "$THIS_DIR already downloaded. Updating..."
  cd "$THIS_DIR"
  git stash
  git checkout master
  git pull origin master
  echo
fi


echo "start setup..."

cd $THIS_DIR

for f in .??*
do
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".aws" ]] && continue
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".ssh" ]] && continue

  if [ -d $f ]; then
    echo "directry:$f"
    mkdir -p "~/$f"
    ln -snfv "$THIS_DIR/$f/" ~/
  else
    echo "file:$f"
    ln -snfv "$THIS_DIR/$f" ~/
  fi

done

