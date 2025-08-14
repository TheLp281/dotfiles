#!/bin/bash

DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="$(dirname "$0")/.wallpaper_state"
HYPRPAPER_CONF="$HOME/.config/dotfiles/hyprland/hyprpaper/hyprpaper.conf"

echo "Searching in directory: $DIR"

if [ ! -f "$STATE_FILE" ]; then
  echo 0 >"$STATE_FILE"
fi

LAST_INDEX=$(cat "$STATE_FILE")

shopt -s nullglob
IMAGES=("$DIR"/*.{png,jpg,jpeg,webp,gif})
shopt -u nullglob

echo "Found images: ${IMAGES[@]}"

TOTAL_IMAGES=${#IMAGES[@]}

if [ $TOTAL_IMAGES -eq 0 ]; then
  echo "No images found in the specified directory."
  exit 1
fi

INDEX=$(((LAST_INDEX + 1) % TOTAL_IMAGES))
SELECTED_IMAGE=${IMAGES[$INDEX]}

echo "Selected image: $SELECTED_IMAGE"
echo $INDEX >"$STATE_FILE"
swww img "$SELECTED_IMAGE"
