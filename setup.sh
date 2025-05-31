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

checkdir ~/.config
link ~/.dotfiles ~/dotfiles
link ~/.config/tmux ~/dotfiles/tmux
link ~/.config/nvim ~/dotfiles/nvim
