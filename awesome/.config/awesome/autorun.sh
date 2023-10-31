#!/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}
run "lxpolkit"
run "blueman-applet"
# run "feh" --bg-fill $HOME/Downloads/wallpaps/current.png
run "xfce4-power-manager"
