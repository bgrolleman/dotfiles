# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles for a Linux desktop, currently running **Niri** (Wayland compositor) with **Noctalia** as the desktop shell. There are legacy X11 configs (i3, polybar, picom) that are no longer the primary setup.

## Deployment

Configs are deployed by symlinking into `~/.config/`, `~/.profile` and `~/.claude/settings.json` (fish is linked per file):

```bash
bash ~/.dotfiles/setup.sh
```

The script is idempotent — it skips links that already exist. After adding a new top-level config directory, add a `configlink <dirname>` line to `setup.sh`.

## Installing Desktop Applications

```bash
cd ansible.desktop
./install-desktop-toolsontech.sh
```

This installs ansible if missing, then runs the playbook. Tasks are split by category in `ansible.desktop/tasks/`.

## Architecture

### Niri (Wayland compositor)
`niri/config.kdl` is just includes — the real config lives in `niri/cfg/`:
- `input.kdl` — keyboard/mouse/touchpad settings
- `keybinds.kdl` — all keybindings
- `layout.kdl` — gaps, border, window sizing
- `display.kdl` — monitor layout and scaling
- `autostart.kdl` — apps launched on compositor start
- `rules.kdl` — window-specific rules
- `workspaces.kdl` — named workspaces
- `animation.kdl`, `misc.kdl` — tweaks

Edit the relevant split file, not `config.kdl` itself.

### Noctalia (desktop shell / bar)
Runs **Noctalia v5** (`noctalia`, native). Config is `noctalia/config.toml` (TOML, hot-reloaded); validate with `noctalia config validate`.
`noctalia/settings.json` is the legacy v4 config (kept for rollback, still tweaked occasionally). See `docs/noctalia-v5.md` for details and `CHANGELOG.md` for history.

### Neovim
Uses **LazyVIM** framework. Entry point is `nvim/init.lua` which bootstraps lazy.nvim via `nvim/lua/config/lazy.lua`.

- `nvim/lua/config/` — core config (options, keymaps, autocmds)
- `nvim/lua/plugins/` — plugin overrides/additions on top of LazyVIM defaults
- `nvim/lua/colorschemes/` — colorscheme configs

LazyVIM handles most plugin management; only deviations from LazyVIM defaults need entries in `lua/plugins/`.

### tmux
`tmux/tmux.conf` + catppuccin theme as a git submodule at `tmux/plugins/catppuccin/tmux`. The agent-status indicators call `~/.local/bin/tmux-window-agent-status`, which is **not** in this repo. After cloning, initialize the submodule:

```bash
git submodule update --init
```

### Shell / profile
`fish/` holds the fish config (`config.fish`, `conf.d/ssh-keychain.fish`); machine-specific vars go in untracked `~/.config/fish/local.fish`.

`profile` is symlinked to `~/.profile`. It sets up SSH keys via `keychain` and defines the `notes` alias (attaches/creates a tmux session with nvim opening `~/Notes/Personal`).

`zoxide.bash` provides shell integration for zoxide (directory jumping) — sourced separately, not via `profile`.
