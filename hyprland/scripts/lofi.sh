#!/bin/bash


declare -A menu_options=(
  ["Lofi Girl ☕🎶"]="https://play.streamafrica.net/lofiradio"
  ["Nier Chill Radio 🎮🎶"]="https://www.youtube.com/watch?v=leVjYZWXvFs&list=RDleVjYZWXvFs&start_radio=1"
  ["Last Summer Whisper 🌅📺"]="https://www.youtube.com/watch?v=SNq4zqTN_DQ&list=RDSNq4zqTN_DQ&start_radio=1"
  ["Fly Me to the Moon 🌕🎙️"]="https://www.youtube.com/watch?v=w2xi6Qjv8mw&list=RDSNq4zqTN_DQ&index=3"
  ["Plants Vs Zombies Jazz 🧟🎷"]="https://www.youtube.com/watch?v=L7-c-LbNq9I&list=RDL7-c-LbNq9I&start_radio=1&pp=oAcB"
  ["Hatsune Miku"]="https://www.youtube.com/watch?v=lLNjr_nzFZc&t=268s"
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

