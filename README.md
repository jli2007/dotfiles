## dotfiles

terminal and agent config for macos. real files live here, `~/.config/*` symlinks point back at them.

setup on a new machine:

```sh
git clone <this repo> ~/dotfiles && ~/dotfiles/install.sh
```

see `changelog.txt` for every setting that differs from a default.

### layers

- `.config/ghostty/config` — window, font, colors. ghostty only
- `.config/tmux/tmux.conf` — panes, windows, sessions. only inside tmux
- `zsh/dotfiles.zsh` — prompt, aliases, history. every terminal
- `AGENTS.md` — agent rules. imported by claude, symlinked into codex

### tmux

prefix is `ctrl+b`.

- `tmux` new session, `tmux a` attach, `tmux ls` list
- `prefix d` detach, session keeps running
- `prefix | -` split right / down, in the current directory
- `prefix h j k l` move between panes
- `prefix H J K L` resize, repeatable
- `prefix c n p` new window, next, prev
- `prefix 1-9` jump to window
- `prefix z` zoom pane fullscreen
- `prefix x` close pane
- `prefix [` scroll mode — `v` select, `y` copy, `q` quit
- `prefix r` reload config

### nvim

leader is space. press it and wait, which-key lists the rest.

- `<leader>f` find files
- `<leader>s` grep project
- `<leader>b` buffers
- `<leader>/` search current file
- `<leader>e` file browser
- `<leader>g` git
- `<leader>w` write
- `gd` goto definition
- `ctrl+h j k l` move between splits
- `esc` clear search highlight

first launch clones plugins, needs network once.

### shell

- `ctrl+r` fuzzy history
- `ctrl+t` fuzzy file picker
- `alt+c` fuzzy cd
- `ctrl+f` accept the grey suggestion

### reverting

- shell — delete the `>>> dotfiles >>>` block in `~/.zshrc`
- one tool — `rm ~/.config/<tool>`, it falls back to stock defaults
- backups — `~/.zshrc.backup-*`, `~/.claude/settings.json.backup-*`
