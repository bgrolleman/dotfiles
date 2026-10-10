# Changelog

## 2026-10-10 (cleanup)

- Niri: floating windows open bottom-left by default; Picture-in-picture floats at a fixed offset.
- Noctalia v4 `settings.json`: move workspaces and system monitor to the right, add taskbar, enable idle.
- tmux: add per-window agent status indicator, 2s status refresh and a Prefix+Tab window switcher popup.
- Claude settings: pin model to sonnet, add herdr SessionStart hook, humanizer and ui-ux-pro-max plugins.
- CLAUDE.md: document claude/fish/kanshi linking, `workspaces.kdl` and the tmux helper script living outside the repo.

## 2026-10-10

- Fix niri login: Mod+T bind had three actions, niri rejected the config and fell back to defaults (no bar, no kanshi).
- Autostart now launches `noctalia` (v5, native) instead of `qs -c noctalia-shell` (v4, Quickshell/QML).
- Reason for the switch: Qt 6.12 broke noctalia-shell 4.x colours (`resolveColorKey is not a function`) and noctalia-qs was built on 6.11.
- Port all niri keybinds from `qs ... ipc call` to `noctalia msg` (launcher, lock, session, volume, media, brightness).
- Add `noctalia/config.toml`: theme, wallpaper, weather, idle, dock and bar layout ported from the old `settings.json`.
- Bar on the 5120px ultrawide (DP-1) is limited to ~70% width via a per-monitor `margin_ends` override.
- Restore previous wallpaper (`stellar-blade-2024-ultrawide.jpg`) on all outputs.
- Document the noctalia v4 to v5 migration (files, keybinds, bar, rollback) in `docs/noctalia-v5.md` and CLAUDE.md.
