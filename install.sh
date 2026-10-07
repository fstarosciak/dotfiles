#!/usr/bin/env bash
# Podpina pliki z tego repo do $HOME jako symlinki.
# Idempotentny: mozna odpalac wielokrotnie.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# zrodlo w repo -> cel wzgledem $HOME
LINKS=(
  "nvim:.config/nvim"
  "zsh/zshrc:.zshrc"
  "zsh/zprofile:.zprofile"
  "tmux/tmux.conf:.tmux.conf"
)

link() {
  local src="$DOTFILES/$1" dst="$HOME/$2"

  if [ ! -e "$src" ]; then
    echo "  POMIJAM  $1 (brak w repo)"
    return
  fi

  # juz wskazuje gdzie trzeba
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  OK       ~/$2"
    return
  fi

  mkdir -p "$(dirname "$dst")"

  # cos tam jest i nie jest naszym symlinkiem -> backup
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP/$(dirname "$2")"
    mv "$dst" "$BACKUP/$2"
    echo "  BACKUP   ~/$2 -> ${BACKUP/#$HOME/~}/$2"
  fi

  ln -sfn "$src" "$dst"
  echo "  LINK     ~/$2 -> ${src/#$HOME/~}"
}

echo "Instaluje dotfiles z ${DOTFILES/#$HOME/~}"
for entry in "${LINKS[@]}"; do
  link "${entry%%:*}" "${entry##*:}"
done

echo
echo "Gotowe."
[ -d "$BACKUP" ] && echo "Backup starych plikow: ${BACKUP/#$HOME/~}"
exit 0
