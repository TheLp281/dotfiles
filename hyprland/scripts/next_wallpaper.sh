DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="$(dirname "$0")/.wallpaper_state"

if [ ! -f "$STATE_FILE" ]; then
  echo 0 >"$STATE_FILE"
fi

LAST_INDEX=$(cat "$STATE_FILE")

shopt -s nullglob
IMAGES=($DIR/*.{png,jpg,jpeg,gif,webp,bmp,tiff,svg})
shopt -u nullglob

TOTAL_IMAGES=${#IMAGES[@]}

if [ $TOTAL_IMAGES -eq 0 ]; then
  exit 1
fi

INDEX=$(((LAST_INDEX + 1) % TOTAL_IMAGES))
SELECTED_IMAGE="${IMAGES[$INDEX]}"
echo $INDEX >"$STATE_FILE"

swww img "$SELECTED_IMAGE" --transition-duration 1 --transition-fps 60 --transition-type random

