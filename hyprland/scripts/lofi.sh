#!/bin/bash

declare -A menu_options=(
  ["Lofi Girl ☕🎶"]="https://play.streamafrica.net/lofiradio"
  ["Nier Radio 🎮🎶"]="category:nier_songs"
  ["Last Summer Whisper 🌅📺"]="https://www.youtube.com/watch?v=SNq4zqTN_DQ&list=RDSNq4zqTN_DQ&start_radio=1"
  ["Fly Me to the Moon 🌕🎙️"]="https://www.youtube.com/watch?v=w2xi6Qjv8mw&list=RDSNq4zqTN_DQ&index=3"
  ["Hatsune Miku 🎤"]="category:hatsune_miku_songs"
)

declare -A hatsune_miku_songs=(
  ["World is Mine"]="https://www.youtube.com/watch?v=EuJ6UR_pD5s"
  ["Gasolina"]="https://www.youtube.com/watch?v=V-IpEogkdaM"
  ["Aishite"]="https://www.youtube.com/watch?v=Ypl1JbdSvJs"
)

declare -A nier_songs=(
  ["Ashes of Dreams"]="https://www.youtube.com/watch?v=UgSHUZvs8jg"
  ["Grandma"]="https://www.youtube.com/watch?v=f03IHCr9dJY"
  ["Voice of no Return"]="https://www.youtube.com/watch?v=ABvi5qegodY"
  ["Weight of the World"]="https://www.youtube.com/watch?v=Dsk3DTdTY3Y"
)

notification() {
  notify-send -u normal "🎵 Now Playing:" "$@"
}

select_option() {
  local -n options=$1
  local prompt="$2"
  printf "%s\n" "${!options[@]}" | rofi -i -dmenu -config ~/.config/dotfiles/rofi/config.rasi -p "$prompt"
}

main() {
  local choice=$(select_option menu_options "▶ Select a stream or category:")
  [ -z "$choice" ] && exit 1

  local target="${menu_options[$choice]}"

  if [[ "$target" == category:* ]]; then
    local category_name="${target#category:}"

    local -n category_array="$category_name"

    local subchoice=$(select_option category_array "▶ Select a $choice song:")
    [ -z "$subchoice" ] && exit 1

    local link="${category_array[$subchoice]}"
    notification "$subchoice"
    mpv --no-video --ytdl-format=bestaudio --volume=100 "$link"
  else
    notification "$choice"
    mpv --no-video --ytdl-format=bestaudio --volume=100 "$target"
  fi
}

pkill mpv && notify-send -u low "⏹ Online Music Stopped" || main
