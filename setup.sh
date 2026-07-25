#!/bin/bash
#
# Simple shell script to setup symlinks
#
checkdir() {
  echo "Checking Directory $1"
  if [ ! -d "$1" ]; then
    mkdir "$1"
  fi
}
link() {
  echo "Linking $1 to $2"
  if [ ! -e "$1" ]; then
    ln -s "$2" "$1"
  fi
}
# Like link(), but backs up existing regular files instead of skipping them
smartlink() {
  local target="$1" source="$2"
  echo "Linking $target to $source"
  if [ -L "$target" ]; then
    : # already a symlink, nothing to do
  elif [ -e "$target" ]; then
    mv "$target" "${target}.bak"
    echo "  Backed up existing file to ${target}.bak"
    ln -s "$source" "$target"
  else
    ln -s "$source" "$target"
  fi
}
configlink() {
  link ~/.config/$1 ~/.dotfiles/$1
}

checkdir ~/.config
link ~/.profile ~/.dotfiles/profile

configlink i3
configlink tmux
configlink nvim
configlink kitty
configlink polybar
configlink picom.conf
configlink niri
configlink noctalia
configlink kanshi

checkdir ~/.claude
link ~/.claude/settings.json ~/.dotfiles/claude/settings.json

# Fish shell config
checkdir ~/.config/fish
checkdir ~/.config/fish/conf.d
smartlink ~/.config/fish/config.fish ~/.dotfiles/fish/config.fish
link ~/.config/fish/conf.d/ssh-keychain.fish ~/.dotfiles/fish/conf.d/ssh-keychain.fish

# Migrate BW_SESSION and other machine-specific fish vars to local.fish
if [ -f ~/.config/fish/config.fish.bak ] && [ ! -f ~/.config/fish/local.fish ]; then
  echo "  Migrating machine-specific config from config.fish.bak to local.fish"
  grep -v '^#' ~/.config/fish/config.fish.bak | grep -v '^\s*$' > ~/.config/fish/local.fish
  echo "  Review ~/.config/fish/local.fish and remove anything now handled by dotfiles"
fi
