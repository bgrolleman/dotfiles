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
