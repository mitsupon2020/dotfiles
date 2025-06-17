#!/bin/bash
set -eu

# dotfiles リポジトリの場所
DOTFILES="$HOME/ghq/github.com/mitsupon2020/dotfiles"

if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/mitsupon2020/dotfiles.git "$DOTFILES"
else
  echo "Updating dotfiles…"
  cd "$DOTFILES"
  git stash
  git checkout master
  git pull origin master
fi

cd "$DOTFILES"

for f in .??*; do
  case "$f" in
    .DS_Store|.aws|.git|.ssh|.claude)  # .claude はあとで個別処理するのでスキップ
      continue
      ;;
  esac

  SRC="$DOTFILES/$f"
  DEST="$HOME/$f"

  if [ -d "$SRC" ]; then
    rm -rf "$DEST"
    ln -snfv "$SRC" "$DEST"
  else
    ln -snfv "$SRC" "$DEST"
  fi
done

# ─────────────────────────────────────────────
# ~/.claude/settings.json をコピーする
# ─────────────────────────────────────────────
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"
# リポジトリ側の settings.json を常に上書きコピー
cp -f "$DOTFILES/.claude/settings.json" "$CLAUDE_DIR/settings.json"

echo "Done!"
