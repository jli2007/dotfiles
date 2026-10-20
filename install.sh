#!/usr/bin/env bash
# Sets up this machine from these dotfiles.
# Safe to run repeatedly: it only adds what is missing and never
# overwrites a real file it did not create.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"
ok(){ printf '  \033[32mok\033[0m   %s\n' "$1"; }
skip(){ printf '  --   %s\n' "$1"; }
warn(){ printf '  \033[33mwarn\033[0m %s\n' "$1"; }

echo "dotfiles: $DOTFILES"
mkdir -p "$CONFIG" "$HOME/.local/bin"

echo
echo "symlinks"
link(){
  local src="$DOTFILES/$1" dst="$2"
  if [ -L "$dst" ]; then
    [ "$(readlink "$dst")" = "$src" ] && { skip "$dst already linked"; return; }
    ln -sfn "$src" "$dst"; ok "relinked $dst"; return
  fi
  if [ -e "$dst" ]; then warn "$dst exists and is NOT a symlink - leaving it alone"; return; fi
  ln -sfn "$src" "$dst"; ok "linked $dst"
}
link ".config/tmux"          "$CONFIG/tmux"
link ".config/ghostty"       "$CONFIG/ghostty"
link ".config/nvim"          "$CONFIG/nvim"
link ".config/starship.toml" "$CONFIG/starship.toml"

echo
echo "agent config"
link "AGENTS.md" "$HOME/.codex/AGENTS.md"
if [ ! -e "$HOME/.claude/CLAUDE.md" ]; then
  mkdir -p "$HOME/.claude"
  echo '@~/dotfiles/AGENTS.md' > "$HOME/.claude/CLAUDE.md"
  ok "created ~/.claude/CLAUDE.md importing AGENTS.md"
else
  skip "~/.claude/CLAUDE.md exists"
fi

echo
echo "shell"
# ~/.zshrc stays a real file (it holds PATH and machine-specific exports);
# we only append a fenced source block.
if grep -q '^# >>> dotfiles >>>' "$HOME/.zshrc" 2>/dev/null; then
  skip "~/.zshrc block already present"
else
  [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.backup-$(date +%Y%m%d-%H%M%S)"
  cat >> "$HOME/.zshrc" <<'BLOCK'

# >>> dotfiles >>>
# Delete this whole block to fully revert the shell changes.
[ -f "$HOME/dotfiles/zsh/dotfiles.zsh" ] && source "$HOME/dotfiles/zsh/dotfiles.zsh"
# <<< dotfiles <<<
BLOCK
  ok "appended block to ~/.zshrc (backed up first)"
fi

echo
echo "packages"
if command -v brew >/dev/null; then
  for f in tmux jq zsh-autosuggestions zsh-syntax-highlighting; do
    brew list --formula "$f" >/dev/null 2>&1 && skip "$f" || { brew install "$f" && ok "$f"; }
  done
  brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1 \
    && skip "nerd font" || brew install --cask font-jetbrains-mono-nerd-font
else
  warn "no homebrew; install tmux, jq and the zsh plugins yourself"
fi

# starship and fzf ship official prebuilt binaries. Preferred over brew
# because homebrew stopped publishing bottles for older macOS, and building
# them from source drags in the whole Rust and Go toolchains.
echo
echo "prebuilt binaries -> ~/.local/bin"
if command -v starship >/dev/null; then skip "starship"; else
  tmp=$(mktemp -d)
  curl -fsSL -o "$tmp/s.tar.gz" https://github.com/starship/starship/releases/latest/download/starship-aarch64-apple-darwin.tar.gz
  tar -xzf "$tmp/s.tar.gz" -C "$tmp" && install -m 755 "$tmp/starship" "$HOME/.local/bin/starship"
  rm -rf "$tmp"; ok "starship"
fi
if command -v fzf >/dev/null; then skip "fzf"; else
  tmp=$(mktemp -d)
  url=$(curl -fsSL https://api.github.com/repos/junegunn/fzf/releases/latest \
        | python3 -c "import sys,json;print(next(a['browser_download_url'] for a in json.load(sys.stdin)['assets'] if 'darwin_arm64' in a['name']))")
  curl -fsSL -o "$tmp/f.tar.gz" "$url"
  tar -xzf "$tmp/f.tar.gz" -C "$tmp" && install -m 755 "$tmp/fzf" "$HOME/.local/bin/fzf"
  rm -rf "$tmp"; ok "fzf"
fi

echo
echo "done. open a new terminal, or: source ~/.zshrc"
echo "nvim installs its plugins on first launch."
