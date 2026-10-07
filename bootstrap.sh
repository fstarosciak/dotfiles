#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
REPO="${REPO:-https://github.com/CHANGE-ME/dotfiles.git}"

info() { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }

# --- 1. pakiety ---------------------------------------------------
PKGS=(neovim git ripgrep fd tmux fzf gh lazygit go python3 node)

case "$(uname -s)" in
  Darwin)
    if ! command -v brew >/dev/null 2>&1; then
      info "Instaluje Homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [ -x "$p" ] && eval "$("$p" shellenv)"
      done
    fi
    info "Instaluje pakiety przez brew"
    brew install "${PKGS[@]}" || true
    ;;
  Linux)
    if command -v apt-get >/dev/null 2>&1; then
      info "Instaluje pakiety przez apt"
      sudo apt-get update -qq
      sudo apt-get install -y neovim git ripgrep fd-find tmux fzf golang python3 nodejs curl unzip || true
    elif command -v dnf >/dev/null 2>&1; then
      info "Instaluje pakiety przez dnf"
      sudo dnf install -y neovim git ripgrep fd-find tmux fzf golang python3 nodejs curl unzip || true
    else
      echo "Nieznany menedzer pakietow -- zainstaluj recznie: ${PKGS[*]}"
    fi
    ;;
esac

# --- 2. oh-my-zsh -------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Instaluje oh-my-zsh"
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- 3. TPM -------------------------------------------------------
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  info "Instaluje TPM (menedzer wtyczek tmuxa)"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- 4. repo ------------------------------------------------------
if [ ! -d "$DOTFILES" ]; then
  info "Klonuje dotfiles do $DOTFILES"
  git clone "$REPO" "$DOTFILES"
fi

# --- 5. symlinki --------------------------------------------------
info "Podpinam symlinki"
bash "$DOTFILES/install.sh"

# --- 6. wtyczki nvima (wersje z lazy-lock.json) -------------------
info "Instaluje wtyczki nvima"
nvim --headless "+Lazy! restore" +qa

info "Instaluje LSP-y i formattery (mason)"
# nie przez :MasonToolsInstall -- ta komenda w headless nie istnieje jeszcze
# w chwili wywolania (wtyczka siedzi na VeryLazy) i nvim wisi w nieskonczonosc
nvim --headless -S "$DOTFILES/nvim/scripts/mason-install.lua" || true

# --- 7. wtyczki tmuxa --------------------------------------------
info "Instaluje wtyczki tmuxa"
"$HOME/.tmux/plugins/tpm/bin/install_plugins" || true

info "ready to rock, setup complete"
