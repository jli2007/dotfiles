# ─────────────────────────────────────────────────────────────
#  Sourced from ~/.zshrc. Everything is additive and guarded:
#  if a tool is missing, that feature is skipped silently rather
#  than erroring on every shell start.
#  Delete the source line in ~/.zshrc to fully revert.
# ─────────────────────────────────────────────────────────────

# starship + fzf are installed to ~/.local/bin as official
# prebuilt binaries, NOT via brew: Homebrew dropped bottles for
# macOS 14, so `brew install starship` would compile Rust from
# source (and fzf would compile Go). See changelog.txt.
export PATH="$HOME/.local/bin:$PATH"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"
command -v starship >/dev/null && eval "$(starship init zsh)"

# ctrl+r fuzzy history · ctrl+t fuzzy file picker · alt+c cd
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# Grey ghost-text prediction from history; ctrl+f accepts it.
_zsh_autosuggest=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if [ -r "$_zsh_autosuggest" ]; then
  source "$_zsh_autosuggest"
  bindkey '^f' autosuggest-accept
fi
unset _zsh_autosuggest

# Must be sourced LAST - it wraps the widgets defined above.
_zsh_hl=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -r "$_zsh_hl" ]; then
  source "$_zsh_hl"
  # Stock highlighting paints anything that isn't a known command in red,
  # which hits every half-typed line. Plain text stays white; a recognised
  # command goes green, so the signal is "it turned green" not "it's red".
  # Hex values, because the Rose Pine Moon theme remaps ANSI green to teal
  # and ANSI cyan to salmon.
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#e0def4'
  ZSH_HIGHLIGHT_STYLES[command]='fg=#9ece6a'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=#9ece6a'
  ZSH_HIGHLIGHT_STYLES[function]='fg=#9ece6a'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=#9ece6a'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=#9ece6a'
  ZSH_HIGHLIGHT_STYLES[path]='fg=#7dcfff'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f6c177'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f6c177'
  ZSH_HIGHLIGHT_STYLES[comment]='fg=#6e6a86'
fi
unset _zsh_hl

alias ..='cd ..'
