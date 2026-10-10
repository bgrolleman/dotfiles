# Noctalia v5

Noctalia v5 (`noctalia` package) is a native Wayland shell with no Qt dependency. It replaces v4
(`noctalia-shell` + `noctalia-qs`, Quickshell/QML), which broke on Qt 6.12.

## Files

- `noctalia/config.toml` - hand-edited config, hot-reloaded. Linked to `~/.config/noctalia/config.toml`.
- `~/.local/state/noctalia/settings.toml` - GUI-managed overrides and runtime state (not in this repo).
- `noctalia/settings.json` - old v4 config, kept for reference or fallback.

Validate after editing: `noctalia config validate`. Open the settings GUI: `noctalia msg settings-open`.

## Startup and keybinds

- Started from `niri/cfg/autostart.kdl` with `spawn-at-startup "noctalia"`.
- Keybinds in `niri/cfg/keybinds.kdl` call `noctalia msg <command>`; list them with `noctalia msg --help`.
- Panel ids for `panel-toggle`: clipboard, control-center, launcher, polkit, session, tray-drawer, wallpaper.
- Wallpaper is set with `noctalia msg wallpaper-set [output] <path>` and persists.

## Bar

- Layout is the `start`, `center` and `end` lists in `[bar.main]`.
- `[bar.main.monitor.ultrawide]` matches DP-1 and sets `margin_ends = 768`, which gives about 70% width on 5120px.
  Formula: `(monitor_width - wanted_width) / 2`.

## Not ported from v4

- System monitor widget (widget id unknown in v5), per-widget options such as hover-only labels.
- v4 plugins (`polkit-agent`): v5 has a built-in `polkit` panel instead.
- The v4 bar only ran on DP-1; v5 runs on every output.

## Rolling back

Set autostart to `qs -c noctalia-shell` again and restore the `qs ... ipc call` binds from git history.
This needs a `noctalia-shell` that works with the installed Qt version.
