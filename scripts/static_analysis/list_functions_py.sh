#!/bin/bash

list_functions() {
  local files=("$@") 
  if [[ ${#files[@]} -eq 0 ]]; then
    files=(*.py)  
  fi

  for filepath in "${files[@]}"; do
    if [[ -f "$filepath" && "$filepath" =~ \.py$ ]]; then
      echo "Listing functions in: $filepath"
      grep -oP 'def \K\w+' "$filepath"  
    fi
  done
}

list_functions "$@"
