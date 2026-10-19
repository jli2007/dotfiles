# dotfiles-public

Terminal and agent config for this Mac.
Real files live here; `~/.config/*` symlinks point back at them, so editing either path edits the same file and no rebuild step exists.

Inspired by [kunchenguid/dotfiles](https://github.com/kunchenguid/dotfiles), but deliberately without nix-darwin.
That repo rebuilds an entire machine declaratively; this one is just config files plus `brew install`.

## The three layers

These are independent programs stacked inside each other, each with its own config:

| Layer | What it owns | Config | Scope |
|---|---|---|---|
| Ghostty | window, font, colors, opacity | `.config/ghostty/config` | Ghostty only |
| tmux | panes, windows, persistent sessions | `.config/tmux/tmux.conf` | only while inside tmux |
| zsh | prompt, aliases, history, PATH | `~/.zshrc` + `zsh/dotfiles.zsh` | **every** terminal app |

The prompt follows you into Terminal.app, VS Code's terminal and tmux, because they all run the same zsh.
It does not follow you over ssh - remote machines have their own `~/.zshrc`.

## tmux

Prefix is `ctrl+b` (left at the default so tutorials match).

```
tmux            new session          tmux a     attach
tmux ls         list sessions        prefix d   detach
```

| Keys | Does |
|---|---|
| `prefix` `\|` / `-` | split right / down, in the current directory |
| `prefix` `h j k l` | move between panes |
| `prefix` `H J K L` | resize (repeatable) |
| `prefix` `c` / `n` / `p` | new window / next / prev |
| `prefix` `1`..`9` | jump to window |
| `prefix` `z` | zoom pane fullscreen (toggle) |
| `prefix` `x` | close pane |
| `prefix` `[` | scroll mode — `v` select, `y` copy, `q` quit |
| `prefix` `r` | reload config |

Sessions survive closing the Ghostty window. Detach with `prefix d`, reattach later with `tmux a`.

## nvim

Leader is `<Space>`. Press it and wait — which-key lists everything bound under it.

| Keys | Does |
|---|---|
| `<leader>f` / `<leader>s` | find files / grep project |
| `<leader>b` / `<leader>/` | buffers / search in current file |
| `<leader>e` | file browser (oil — edit the dir like a buffer, `:w` applies) |
| `<leader>g` | git UI (neogit) |
| `<leader>w` | write |
| `gd` | goto definition |
| `ctrl+h/j/k/l` | move between splits |
| `<Esc>` | clear search highlight |

First launch bootstraps lazy.nvim and clones plugins; needs network once.

## Shell

starship prompt, `ctrl+r` fuzzy history, `ctrl+t` fuzzy file picker, grey autosuggestions (`ctrl+f` accepts), syntax highlighting.

## Agents

`AGENTS.md` is the single policy file, shared by both agents:

- `~/.claude/CLAUDE.md` imports it with `@~/dotfiles-public/AGENTS.md`
- `~/.codex/AGENTS.md` is a symlink to it

Edit `AGENTS.md` and both pick it up.

## Reverting

| To undo | Do |
|---|---|
| shell changes | delete the `>>> dotfiles-public >>>` block in `~/.zshrc` |
| a terminal config | `rm ~/.config/<tool>`, the tool reverts to stock defaults |
| everything | backups are at `~/.zshrc.backup-*` and `~/.claude/settings.json.backup-*` |
