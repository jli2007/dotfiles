# ─────────────────────────────────────────────────────────────
#  Sourced from ~/.zshrc. Delete the source line there to revert.
#
#  Split in two:
#    - functional bits load everywhere (fzf, history, aliases)
#    - visual bits load in ghostty ONLY
#
#  Why: the prompt colors are 24-bit hex, and Terminal.app has no
#  truecolor support - it renders the escapes as garbled highlight
#  blocks. Terminal.app, VS Code and ssh keep a plain prompt.
# ─────────────────────────────────────────────────────────────

export PATH="$HOME/.local/bin:$PATH"

# Ghostty exports these, so they are inherited by child processes
# (tmux panes included). That is fine here; the fastfetch block below
# is the only place it matters, and it checks $TMUX separately.
if [[ -n "$GHOSTTY_RESOURCES_DIR" || "$TERM_PROGRAM" == "ghostty" ]]; then
  typeset -g _IN_GHOSTTY=1
else
  typeset -g _IN_GHOSTTY=0
fi

# ── everywhere ───────────────────────────────────────────────
# ctrl+r fuzzy history · ctrl+t fuzzy file picker · alt+c cd
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# Grey ghost text from history; ctrl+f accepts. fg=8 is a plain
# 256-color code, safe in every terminal.
_zsh_autosuggest=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if [ -r "$_zsh_autosuggest" ]; then
  source "$_zsh_autosuggest"
  bindkey '^f' autosuggest-accept
fi
unset _zsh_autosuggest

alias ..='cd ..'
alias ff='fastfetch'

# ── ghostty only ─────────────────────────────────────────────
if (( _IN_GHOSTTY )); then

  export STARSHIP_CONFIG="$HOME/.config/starship.toml"
  command -v starship >/dev/null && eval "$(starship init zsh)"

  # Sourced last - it wraps the widgets defined above.
  # Hex colors, so this is gated to ghostty along with starship.
  _zsh_hl=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  if [ -r "$_zsh_hl" ]; then
    source "$_zsh_hl"
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

  # New ghostty window only, never a tmux pane.
  if [[ -o interactive ]] && [[ -z "$TMUX" ]] && command -v fastfetch >/dev/null; then
    fastfetch
  fi

else
  # Plain prompt for Terminal.app, VS Code, ssh - basic ANSI colors
  # that work in any terminal. This is the prompt from before any of
  # these changes.
  PROMPT='%F{green}%n@%m%f  %F{cyan}%~%f
%% '
fi
