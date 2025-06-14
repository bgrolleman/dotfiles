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
  link ~/.config/$1 ~/dotfiles/$1
}

checkdir ~/.config
link ~/.dotfiles ~/dotfiles
link ~/.profile ~/dotfiles/profile
link ~/.config/i3 ~/dotfiles/i3

configlink tmux
configlink nvim
configlink kitty
configlink polybar
configlink picom.conf
