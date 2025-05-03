#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide a file to process."
  exit 1
fi

file="$1"

awk '{
  line = $0
  match(line, /\/\/.*/)
  if (RSTART > 0) {
    url_pos = index(line, "https://")
    if (url_pos == 0 || url_pos > RSTART) {
      print substr(line, 1, RSTART - 1)
    } else {
      print line
    }
  } else {
    print line
  }
}' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

echo "Comment lines removed from $file"
