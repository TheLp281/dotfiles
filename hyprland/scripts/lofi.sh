#!/bin/bash


declare -A menu_options=(
  ["Lofi Girl ☕️🎶"]="https://play.streamafrica.net/lofiradio"
  ["Easy Rock 96.3 FM 📻🎶"]="https://radio-stations-philippines.com/easy-rock"
  ["Wish 107.5 FM 📻🎶"]="https://radio-stations-philippines.com/dwnu-1075-wish"
  ["Chillhop ☕️🎶"]="http://stream.zeno.fm/fyn8eh3h5f8uv"
  ["SmoothChill ☕️🎶"]="https://media-ssl.musicradio.com/SmoothChill"
  ["YouTube Chill Radio 📺🎶"]="https://www.youtube.com/watch?v=leVjYZWXvFs&list=RDleVjYZWXvFs&start_radio=1"
)

notification() {
  notify-send -u normal "🎵 Now Playing:" "$@"
}

main() {
  choice=$(printf "%s\n" "${!menu_options[@]}" | rofi -i -dmenu -config ~/.config/dotfiles/rofi/config.rasi -p "▶ Select a stream:")

  if [ -z "$choice" ]; then
    exit 1
  fi

  link="${menu_options[$choice]}"

  notification "$choice"

  mpv --no-video --ytdl-format=bestaudio --volume=100 "$link"
}

pkill mpv && notify-send -u low "⏹ Online Music Stopped" || main

