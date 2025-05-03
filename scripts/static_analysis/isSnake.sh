#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

grep -n -E '\b[a-zA-Z0-9]+_[a-zA-Z0-9]+\b' "$@"
