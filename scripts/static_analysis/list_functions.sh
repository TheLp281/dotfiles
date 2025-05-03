#!/bin/bash

list_functions() {
  local files=("$@") 
  if [[ ${#files[@]} -eq 0 ]]; then
    files=(*.js) 
  fi

  for filepath in "${files[@]}"; do
    if [[ -f "$filepath" && "$filepath" =~ \.js$ ]]; then
      echo "Listing functions in: $filepath"
      grep -oP 'function \K\w+' "$filepath" 
    else
      echo "Error: $filepath is not a valid JavaScript file."
    fi
  done
}

list_functions "$@"
