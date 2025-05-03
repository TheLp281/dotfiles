#!/bin/bash
# Script to remove a file and open vim on it

if [ -z "$1" ]; then
  echo "Usage: rvim <file>"
  exit 1
fi

FILE="$1"
TMP_DIR="/tmp/rvim"
mkdir -p "$TMP_DIR"
BASENAME=$(basename "$FILE")
TMP_FILE="$TMP_DIR/$BASENAME"

if [ -e "$FILE" ]; then
  cp "$FILE" "$TMP_FILE"
  
  rm -f "$FILE"
else
  touch "$TMP_FILE"
fi

vim "$FILE"
