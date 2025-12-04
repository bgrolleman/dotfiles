#!/bin/sh
i3-msg "workspace 1; append_layout ~/.config/i3/workspace-1.json"
sleep 0.5
/usr/bin/brave-browser &
sleep 0.5
/usr/bin/kitty &
sleep 0.5
flatpak run com.logseq.Logseq &
sleep 0.5
gtk-launch "brave-knaiokfnmjjldlfhlioejgcompgenfhb-Default.desktop" &
