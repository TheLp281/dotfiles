#!/bin/bash

iDIR="$HOME/.config/swaync/icons"

declare -A menu_options=(
  ["Lofi Girl ☕️🎶"]="https://play.streamafrica.net/lofiradio"
  ["White Noise 📖🎶"]="https://www.youtube.com/watch?v=nMfPqeZjc2c&t=7040s&pp=ygULd2hpdGUgbm9pc2U%3D"
  ["Easy Rock 96.3 FM 📻🎶"]="https://radio-stations-philippines.com/easy-rock"
  ["Wish 107.5 FM 📻🎶"]="https://radio-stations-philippines.com/dwnu-1075-wish"
  ["Wish 107.5 YT Pinoy HipHop 🎻🎶"]="https://youtube.com/playlist?list=PLkrzfEDjeYJnmgMYwCKid4XIFqUKBVWEs&si=vahW_noh4UDJ5d37"
  ["Wish 107.5 YT Wishclusives ☕️🎶"]="https://youtube.com/playlist?list=PLkrzfEDjeYJn5B22H9HOWP3Kxxs-DkPSM&si=d_Ld2OKhGvpH48WO"
  ["Chillhop ☕️🎶"]="http://stream.zeno.fm/fyn8eh3h5f8uv"
  ["SmoothChill ☕️🎶"]="https://media-ssl.musicradio.com/SmoothChill"
  ["Relaxing Music ☕️🎶"]="https://youtube.com/playlist?list=PLMIbmfP_9vb8BCxRoraJpoo4q1yMFg4CE"
)

notification() {
  notify-send -u normal "Playing now: $@"
}

main() {
  choice=$(printf "%s\n" "${!menu_options[@]}" | rofi -i -dmenu -config ~/.config/dotfiles/rofi/config.rasi -p "")

  if [ -z "$choice" ]; then
    exit 1
  fi

  link="${menu_options[$choice]}"

  notification "$choice"

  if [[ $link == *playlist* || $link == *watch* ]]; then
    vlc --intf rc --rc-host localhost:12345 --no-video --volume 50 "$link" &
  else
    vlc --intf rc --rc-host localhost:12345 --volume 50 "$link" &
  fi
}

# Check if VLC is already running
if ! pgrep -x "vlc" > /dev/null; then
  main
else
  notify-send -u low "Online Music is already playing"
fi

# Ensure playerctl interacts with the correct player (vlc)
playerctl -p vlc play-pause
