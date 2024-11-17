#!/bin/bash
grim /tmp/fullscreen_screenshot.png
scrot -p /tmp/cursor_only.png
convert /tmp/cursor_only.png -fuzz 10% -transparent black /tmp/cursor_only_transparent.png
convert /tmp/fullscreen_screenshot.png /tmp/cursor_only_transparent.png -composite ~/Pictures/final_screenshot.png
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
convert /tmp/fullscreen_screenshot.png /tmp/cursor_only_transparent.png -composite ~/Pictures/screenshot_$timestamp.png
rm /tmp/fullscreen_screenshot.png /tmp/cursor_only.png /tmp/cursor_only_transparent.png ~/Pictures/final_screenshot.png

